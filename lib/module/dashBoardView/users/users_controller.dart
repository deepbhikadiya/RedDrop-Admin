import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_redrop/package/config_packages.dart';

class UsersController extends GetxController {
  RxList userList = ["All users", "Approved users", "Declined users"].obs;
  RxInt selectedTabIndex = 0.obs;
  Rx<TextEditingController> searchUserController = TextEditingController().obs;

  RxString searchString = "".obs;

  Rxn<GetAllUserModel> allUserModel = Rxn<GetAllUserModel>();
  RxList<User> allUserList = <User>[].obs;
  RxList<User> baseAllUserList = <User>[].obs;
  RxBool isLoadingUser = false.obs;
  RxInt page = 1.obs;

  Future<void> showUserDetailDialogue(BuildContext context, {required snapshot}) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 3 : 20),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32, left: 16, right: 16, top: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.dialogueGrayColor.withOpacity(0.2)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getImageView(
                        finalUrl: "https://cors-anywhere.herokuapp.com/" + snapshot["image"],
                        height: 52,
                        width: 52,
                        fit: BoxFit.contain,
                      ),
                      const Gap(14),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          "Name",
                          style: const TextStyle().normal14w700.textColor(AppColor.black),
                        ),
                        Text(
                          (snapshot['first_name'] ?? "") + (snapshot['middle_name'] ?? "") + snapshot['last_name'] ?? "",
                          style: const TextStyle().normal12w400.textColor(AppColor.black),
                        ),
                        const Gap(20),
                        Text(
                          "Blood Group",
                          style: const TextStyle().normal14w700.textColor(AppColor.black),
                        ),
                        Text(
                          snapshot["blood_group"] ?? "",
                          style: const TextStyle().normal12w400.textColor(AppColor.black),
                        ),
                      ]),
                      const Spacer(),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(
                          "Number",
                          style: const TextStyle().normal14w700.textColor(AppColor.black),
                        ),
                        Text(
                          snapshot["phone_number"] ?? "",
                          style: const TextStyle().normal12w400.textColor(AppColor.black),
                        ),
                        const Gap(20),
                        Text(
                          "Aadhar Number",
                          style: const TextStyle().normal14w700.textColor(AppColor.black),
                        ),
                        Text(
                          snapshot["aadhar_no"] ?? "",
                          style: const TextStyle().normal12w400.textColor(AppColor.black),
                        ),
                      ]),
                      const Gap(16),
                    ],
                  ),
                ),
                const Gap(11),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Adhar card",
                    style: const TextStyle().normal18w600.textColor(AppColor.black),
                  ),
                ),
                const Gap(11),
                Divider(
                  color: AppColor.black.withOpacity(0.1),
                ),
                SizedBox(
                  height: 200,
                  child: getImageView(
                    height: 200,
                    width: 400,
                    fit: BoxFit.contain,
                    finalUrl: "https://cors-anywhere.herokuapp.com/" + snapshot["aadhar_image"],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<User>> getUsersFromFirestore() async {
    List<User> users = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

      for (var doc in querySnapshot.docs) {
        User user = User.fromFirestore(doc);
        users.add(user);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
    }
    allUserList.value = users;

    return users;
  }

  void sendNotification({required String fcmToken, required String bodyTxt, required String titleTxt, required String notificationType, required String requestId}) async {
    var url = 'https://fcm.googleapis.com/fcm/send';

    var body = jsonEncode({
      "to": fcmToken,
      "notification": {"body": bodyTxt, "title": titleTxt},
      "data": {"click_action": "HandleNotifyActivity", "body": bodyTxt, "title": titleTxt, "notification_type": notificationType, "request_id": requestId}
    });

    await http.post(Uri.parse(url), headers: {'Content-Type': 'application/json', 'Authorization': 'key=${'YOUR SERVER KEY'}'}, body: body);
  }
}
