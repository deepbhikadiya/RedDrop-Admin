import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_redrop/models/dashboard/dashboard_model.dart';
import 'package:web_redrop/models/dashboard/dashboard_tab_model.dart';
import 'package:web_redrop/module/dashBoardView/users/users_controller.dart';
import 'package:web_redrop/package/config_packages.dart';


class HeaderCardController extends GetxController {

  Future<void> updateCounts(QuerySnapshot? snapshot) async {
    if (snapshot != null) {
      int totalUsers = 0;
      int approvedUsers = 0;
      int declinedUsers = 0;

      snapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        // Check if data is not null and contains the key 'is_verified'
        if (data != null && data.containsKey('is_verified') &&
            data['is_verified'] == 1) {
          approvedUsers++;
        } else if(data != null && data.containsKey('is_verified') &&
            data['is_verified'] == 0){
          declinedUsers++;
        }
        else if(data != null && data.containsKey('is_verified') &&
            data['is_verified'] == -1){
          totalUsers++;
        }

      });
      if (dashBordHeader.isNotEmpty) {
        dashBordHeader[0].numbers = totalUsers.toString();
        dashBordHeader[1].numbers = approvedUsers.toString();
        dashBordHeader[2].numbers = declinedUsers.toString();
      }
      // dashBordHeader.refresh();
    }
  }


  RxList<DashBoardHeader> dashBordHeader = [
    DashBoardHeader(
        image: AppImage.profileUSer,
        heading: "Total Users",
        numbers: "0",
        percentage: "0"),
    DashBoardHeader(
        image: AppImage.profileTick,
        heading: "Approved Users",
        numbers: "0",
        percentage: "0"),
    DashBoardHeader(
        image: AppImage.monitor,
        heading: "Declined Users",
        numbers: "0",
        percentage: "0"),
  ].obs;


}

class HeaderCardWidget extends GetView<UsersController> {
  List<BoxShadow> boxShadowList = [
    BoxShadow(
      blurRadius: 16,
      offset: const Offset(4, 6),
      color: AppColor.black.withOpacity(.01),
    ),
    BoxShadow(
      blurRadius: 30,
      offset: const Offset(15, 26),
      color: AppColor.black.withOpacity(.09),
    ),
    BoxShadow(
      blurRadius: 40,
      offset: const Offset(34, 58),
      color: AppColor.black.withOpacity(.01),
    ),
    BoxShadow(
      blurRadius: 52,
      offset: const Offset(94, 162),
      color: AppColor.black.withOpacity(0),
    ),
  ];

  HeaderCardWidget({super.key});

  final headerCardController = Get.put<HeaderCardController>(
      HeaderCardController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      width: double.infinity,
      height: 170,
      child: Obx(() {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: headerCardController.dashBordHeader.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Plans? plans = subscriptionController
            //     .subscriptionModel.value?.plans?[index];
            return Row(
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 4.1,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(22),
                          height: 84,
                          width: 84,
                          decoration: BoxDecoration(
                              color: AppColor.primaryRed,
                              borderRadius: BorderRadius.circular(42)),
                          child: Image.asset(
                            headerCardController.dashBordHeader[index].image ??
                                "",
                            color: AppColor.white,
                          ),
                        ),
                        const Gap(38),
                        // Gap(MediaQuery.of(context).size.width/20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              headerCardController.dashBordHeader[index].heading
                                  .toString(),
                              style: const TextStyle()
                                  .normal14w400
                                  .textColor(AppColor.grayB3),
                            ),
                            Text(
                              headerCardController.dashBordHeader[index].numbers
                                  .toString(),
                              style: const TextStyle()
                                  .normal32w700
                                  .textColor(AppColor.black),
                            ),
                            // Row(
                            //   children: [
                            //     const Icon(
                            //       Icons.arrow_downward_rounded,
                            //       size: 20,
                            //       color: AppColor.primaryBlue,
                            //     ),
                            //     Text(
                            //       "${dashBordHeader[index].percentage}%",
                            //       style: const TextStyle()
                            //           .normal12w700
                            //           .textColor(AppColor.black),
                            //     ),
                            //     Text(
                            //       " this month",
                            //       style: const TextStyle()
                            //           .normal12w400
                            //           .textColor(AppColor.black),
                            //     ),
                            //   ],
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const VerticalDivider()
              ],
            );
          },
        );
      }),
    );

  }

  Stack _buildStack(DashBoardTabModel dashBoardModel) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(21),
            bottomRight: Radius.circular(21),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              dashBoardModel.image ?? '',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dashBoardModel.title ?? "",
                style: const TextStyle().normal18w700.textColor(AppColor.white),
              ),
              const Spacer(),
              Text(
                dashBoardModel.total ?? "",
                style: const TextStyle().normal28w700.textColor(AppColor.white),
              ),
            ],
          ),
        )
      ],
    );
  }
}
