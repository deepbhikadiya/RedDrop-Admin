
import 'package:web_redrop/package/config_packages.dart';

class ReportController extends GetxController{
  Rx<TextEditingController> searchUserController = TextEditingController().obs;

  RxBool isLoadingDashboard = false.obs;
}