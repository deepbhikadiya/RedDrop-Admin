import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_redrop/components/common_container_decoration.dart';
import 'package:web_redrop/module/authentication/login/login_screen.dart';
import 'package:web_redrop/package/config_packages.dart';

import 'dashboard_view_controller.dart';

class DashBoardViewScreen extends StatelessWidget {
  const DashBoardViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? null
          : AppBar(
              forceMaterialTransparency: true,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppImage.post,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
      drawer: Builder(
        builder: (BuildContext context) {
          if (!Responsive.isDesktop(context)) {
            return SizedBox(
              width: 250,
              child: _menuWidget(context),
            );
          } else {
            return Container();
          }
        },
      ),
      backgroundColor: AppColor.primaryCream.withOpacity(0.5),
      body: _bodyWidget(context),
    );
  }
}

Widget _bodyWidget(context) {
  final tabBarController = Get.put<DashboardViewController>(DashboardViewController());
  return Column(
    children: [

      Expanded(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                child: _menuWidget(context),
              ),
            Expanded(
              flex: 8,
              child: Obx(
                () {
                  return Navigator(
                    key: tabBarController.navigatorKeys[tabBarController.selectedIndex.value],
                    onGenerateRoute: (RouteSettings settings) {
                      return MaterialPageRoute(builder: (_) {
                        return tabBarController.widget.elementAt(tabBarController.selectedIndex.value);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Padding headerWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 38.0, vertical: 21),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(45), color: AppColor.white),
      child: Row(
        children: [
          Image.asset(
            AppImage.post,
            height: 40,
          ),
          const Spacer(),
          Container(
            width: 390,
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              style: const TextStyle().normal14w500.textColor(AppColor.black),
              cursorColor: AppColor.black,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                hintText: 'Search',
                suffixIcon: const Icon(
                  Icons.search,
                  color: AppColor.primaryRed,
                ),
                hintStyle: const TextStyle().normal14w500.textColor(AppColor.primaryRed),
                fillColor: AppColor.black.withOpacity(.04),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(97),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(97),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(97),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: AppColor.primaryRed,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _menuWidget(context) {
  final tabBarController = Get.put<DashboardViewController>(DashboardViewController());

  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
      color: AppColor.primaryRed,
    ),
    child: Container(
      decoration: Responsive.isDesktop(context) ? CommonContainerDecoration.boxDecoration(borderRadius: 0, color: AppColor.primaryRed) : null,
      margin: const EdgeInsets.only(bottom: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            const Gap(20),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Text(
                    "RedDrop",
                    style: const TextStyle().normal36w600.textColor(AppColor.white),
                  )
                ],
              ),
            ),
            const Gap(20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Divider(),
            ),
            const Gap(0),
            SingleChildScrollView(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: tabBarController.tabBar.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      tabBarController.selectedIndex.value = index;
                      if (Responsive.isMobile(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: Obx(
                      () => Container(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: tabBarController.selectedIndex.value == index ? AppColor.lightOrange : Colors.transparent),
                        child: Row(
                          children: [
                            Image.asset(
                              tabBarController.tabBar[index]['image'],
                              height: 24,
                              color: tabBarController.selectedIndex.value == index ? AppColor.black : AppColor.white,
                            ),
                            const Gap(12),
                            Expanded(
                              child: Text(
                                tabBarController.tabBar[index]['text'],
                                style: tabBarController.selectedIndex.value == index
                                    ? const TextStyle().normal16w700.textColor(AppColor.black)
                                    : const TextStyle().normal16w400.textColor(
                                          AppColor.white,
                                        ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                final textTheme = Theme.of(context).textTheme.apply(displayColor: Theme.of(context).colorScheme.onSurface);
                showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    // Add a title to the dialog with the 'Logout?' text, using the textTheme to apply styles
                    title: Text(
                      'Logout?',
                      style: textTheme.titleMedium!.copyWith(
                        color: AppColor.primaryRed,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                    // Add content to the dialog with the 'Are you sure want to logout?' text, using the textTheme to apply styles
                    content: Text(
                      'Are you sure want to logout?',
                      style: textTheme.titleSmall!,
                    ),
                    // Add two actions to the dialog: Cancel and Logout
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          'Cancel',
                          style: textTheme.labelLarge!,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text(
                          'Logout',
                          style: textTheme.labelLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          AppPref().clear();
                          Navigator.pushAndRemoveUntil(
                              Get.context!,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => const LoginScreen(),
                              ),
                                  (route) => false);
                        },
                      ),
                    ],
                  ),
                );


              },
              behavior: HitTestBehavior.translucent,
              child: Text(
                "LogOut",
                style: const TextStyle(decoration: TextDecoration.underline, decorationColor: AppColor.white).normal14w600.textColor(AppColor.white),
              ),
            ),
            const Gap(52),
          ],
        ),
      ),
    ),
  );
}
