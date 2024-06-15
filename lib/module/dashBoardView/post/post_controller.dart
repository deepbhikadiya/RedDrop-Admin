
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_redrop/package/config_packages.dart';

import '../../../utils/common_string.dart';

class PushNotificationController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  List<XFile>? imageFiles = [];

  void sendNotificationsToUsers() async {
    // Assuming you have a Firestore collection named 'users'
    QuerySnapshot usersSnapshot =
    await FirebaseFirestore.instance.collection('users').get();

    // Iterate through each user document and send notification
    usersSnapshot.docs.forEach((userDoc) {
      // Explicitly cast the result of data() to a Map<String, dynamic>
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      // Check if userData is not null and contains the 'fcm_token' key
      if (userData != null && userData.containsKey('fcm_token') && userData["is_verified"]==1) {
        String fcmToken = userData['fcm_token'];
        sendNotification(
          bodyTxt:
          "A new blood donation camp has been organized! Join us at ${descController.text} to donate blood and save lives. Your participation can make a huge difference!",
          fcmToken: fcmToken,
          notificationType: "post",
          requestId: "",
          titleTxt: "New Blood Donation Camp Alert!",
        );
      }
    });
  }

  void sendNotification(
      {required String fcmToken,
        required String bodyTxt,
        required String titleTxt,
        required String notificationType,
        required String requestId}) async {
    var url = 'https://fcm.googleapis.com/fcm/send';

    var body = jsonEncode({
      "to": fcmToken,
      "notification": {"body": bodyTxt, "title": titleTxt},
      "data": {
        "click_action": "HandleNotifyActivity",
        "body": bodyTxt,
        "title": titleTxt,
        "notification_type": notificationType,
        "request_id": requestId
      }
    });

    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=${CommonString.serverKey}'
        },
        body: body);

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Error: ${response.body}');
    }
  }

}


