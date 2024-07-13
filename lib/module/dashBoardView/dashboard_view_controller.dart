
import 'package:web_redrop/module/dashBoardView/post/post_screen.dart';
import 'package:web_redrop/module/dashBoardView/users/users_screen.dart';
import 'package:web_redrop/package/config_packages.dart';

import 'reports/report_screen.dart';

class DashboardViewController extends GetxController {
  RxInt selectedIndex = 0.obs;
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey<NavigatorState>(),
    1: GlobalKey<NavigatorState>(),
    2: GlobalKey<NavigatorState>(),

  };
  RxList<Widget> widget = <Widget>[
    const UserScreen(),

    PushNotificationScreen(),
    const ReportScreen(),

  ].obs;
  RxList tabBar = [
    {"text": "Dashboard", "image": AppImage.dashboard},

    {"text": "Post", "image": AppImage.post},
    {"text": "Reports", "image": AppImage.report},

  ].obs;


}
