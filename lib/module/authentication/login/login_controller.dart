import 'package:web_redrop/module/dashBoardView/dashboard_view_screen.dart';
import 'package:web_redrop/utils/app_toast.dart';

import '../../../package/config_packages.dart';

class LoginController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final globalController = Get.find<GlobalController>();
  RxBool isLoad = false.obs;
  RxBool password = false.obs;

  ///login

  Future<void> login(context, {required String email, required String password}) async {
    try {
      isLoad.value = true;
      final QuerySnapshot querySnapshots = await FirebaseFirestore.instance.collection('admin').where("email", isEqualTo: email).get();
      if (querySnapshots.docs.isNotEmpty) {
        final bool isVerified = querySnapshots.docs.first.get('password') == password;
        if (isVerified) {
          // Get.offAllNamed(AppRouter.bottomBarScreen);
          isLoad.value = false;
          Navigator.pushAndRemoveUntil(
              Get.context!,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const DashBoardViewScreen(),
              ),
              (route) => false);
        } else {
          isLoad.value = false;
          showAppToast("Invalid password");
        }
      } else {
        isLoad.value = false;
        showAppToast("User not found");
      }
    } on FirebaseException catch (e) {
      isLoad.value = false;
      print('FirebaseException: $e');
    } catch (e) {
      isLoad.value = false;
      print('Error: $e');
    }
  }
}
