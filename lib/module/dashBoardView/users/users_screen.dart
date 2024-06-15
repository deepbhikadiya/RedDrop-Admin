import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_redrop/components/header_card.dart';
import 'package:web_redrop/components/header_widget.dart';
import 'package:web_redrop/module/dashBoardView/users/users_controller.dart';
import 'package:web_redrop/package/config_packages.dart';
import 'package:web_redrop/package/screen_packages.dart';
import 'package:web_redrop/utils/app_toast.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final usersController = Get.put<UsersController>(UsersController());
  final headerCardController = Get.put<HeaderCardController>(HeaderCardController());
  RxList<DocumentSnapshot> filteredUsers = <DocumentSnapshot>[].obs;
  late AsyncSnapshot<QuerySnapshot<Object?>> filterSnapshot;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderWidget(
          headerText: "User List",
        ),
        HeaderCardWidget(),
        const Gap(20),
        Container(
          height: 50,
          margin: const EdgeInsets.only(left: 40),
          child: ListView.builder(
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: usersController.userList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: index == 0 ? 0.0 : 40),
                      child: Obx(() {
                        return GestureDetector(
                          onTap: () {
                            usersController.searchString.value = "";
                            usersController.searchUserController.value.clear();
                            usersController.page.value = 1;
                            usersController.selectedTabIndex.value = index;
                            filteredUsers.value = changeData(filteredUsers, filterSnapshot);
                          },
                          child: Column(
                            children: [
                              Text(
                                usersController.userList[index],
                                style: TextStyle(
                                        decoration: usersController.selectedTabIndex.value == index ? TextDecoration.underline : null,
                                        decorationColor: usersController.selectedTabIndex.value == index ? AppColor.primaryBlue : Colors.transparent)
                                    .normal24w500
                                    .textColor(usersController.selectedTabIndex.value == index ? AppColor.primaryBlue : AppColor.black.withOpacity(0.5)),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }),
        ),
        const Gap(0),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                left: Responsive.isDesktop(context) ? 28 : 24,
                right: Responsive.isDesktop(context) ? 42 : 16,
                bottom: Responsive.isDesktop(context) ? 50 : 24,
                top: Responsive.isDesktop(context) ? 0 : 24),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.black.withOpacity(.11)),
              borderRadius: BorderRadius.circular(28.89),
              color: Colors.white,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(28.89),
                  child: Container(
                    height: 76,
                    color: AppColor.white,
                    child: Row(
                      children: [
                        if (Responsive.isMobile(context)) const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "All Users",
                                style: const TextStyle().textColor(AppColor.black).normal22w700,
                              ),
                            ],
                          ),
                        ),
                        // const Spacer(),
                        // if (Responsive.isDesktop(context)) ...[
                        //   SizedBox(
                        //     width: MediaQuery.of(context).size.width / 2.5,
                        //     child: InputField(
                        //       controller: usersController.searchUserController.value,
                        //       suffixIcon:GestureDetector(
                        //         onTap: (){
                        //           usersController.searchUserController.value.clear();
                        //         },
                        //         child: const Icon(Icons.close),
                        //
                        //     ),
                        //   ),),
                        //   const Gap(20),
                        //   GestureDetector(
                        //     onTap: (){
                        //       // _onSearchChanged(usersController.searchUserController.value.text);
                        //     },
                        //     child: Container(
                        //       padding: const EdgeInsets.all(10),
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(12),
                        //         color: AppColor.primaryRed,
                        //       ),
                        //       child: Text("Search",style: const TextStyle().normal14w400.textColor(AppColor.white),),
                        //     ),
                        //   ),
                        //   const Gap(20),
                        // ],
                      ],
                    ),
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    filterSnapshot = snapshot;
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    headerCardController.updateCounts(snapshot.data).then((value) {
                      headerCardController.dashBordHeader.refresh();
                    });

                    filteredUsers.value = changeData(filteredUsers, filterSnapshot);

                    return Expanded(
                      child: Obx(() {
                        return DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          bottomMargin: 10,
                          minWidth: 10,
                          headingTextStyle: const TextStyle().normal15w700.textColor(AppColor.black),
                          headingRowColor: MaterialStateProperty.all(AppColor.primaryRed.withOpacity(0.07)),
                          headingRowHeight: 52,
                          dataRowHeight: 43,
                          dataTextStyle: const TextStyle().normal14w500.textColor(AppColor.black),
                          columns:  [
                            const DataColumn2(label: Text("User name"), size: ColumnSize.L),
                            const DataColumn2(label: Text("Blood Group")),
                            const DataColumn2(label: Text("Gender")),
                            const DataColumn2(label: Text("Phone number")),
                            const DataColumn2(label: Text("Adhar number")),
                            if (usersController.selectedTabIndex.value == 0)
                              const DataColumn2(size: ColumnSize.M, label: Text("Status")),
                          ],
                          rows: filteredUsers.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                            return DataRow(
                              onLongPress: () {
                                usersController.showUserDetailDialogue(context, snapshot: data);
                              },
                              cells: [
                                DataCell(Text((data['first_name'] ?? "") +" "+ (data['middle_name'] ?? "") +" "+ data['last_name'] ?? "")),
                                DataCell(Text(data['blood_group'] ?? "")),
                                DataCell(Text(data['gender'] ?? "")),
                                DataCell(Text(data['phone_number'] ?? "")),
                                DataCell(Text(data['aadhar_no'] ?? "")),
                                if (usersController.selectedTabIndex.value == 0)
                                  DataCell(Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance.collection('users').doc(document.id).update({'is_verified': 1});
                                          usersController.sendNotification(
                                            bodyTxt: "Your RedDrop request is approved! Please log in to save lives or find donors.",
                                            fcmToken: data['fcm_token'],
                                            notificationType: "login",
                                            requestId: "",
                                            titleTxt: "Hello ${data["first_name"]??""} ${data['middle_name']??""}!"
                                          );
                                          showAppToast("User verified successfully");

                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColor.saveGreen), color: AppColor.saveGreen.withOpacity(0.3)),
                                          child: Text(
                                            "Approved",
                                            style: const TextStyle().normal12w500.textColor(AppColor.black),
                                          ),
                                        ),
                                      ),
                                      const Gap(5),
                                      GestureDetector(
                                        onTap: () {
                                          FirebaseFirestore.instance.collection('users').doc(document.id).update({'is_verified': 0});
                                          usersController.sendNotification(
                                              bodyTxt: "Your RedDrop request has been declined. For assistance, contact support. Thank you.",
                                              fcmToken: data['fcm_token'],
                                              notificationType: "login",
                                              requestId: "",
                                              titleTxt: "Hello ${data["first_name"]??""} ${data['middle_name']??""}!"
                                          );
                                          showAppToast("User request declined");
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                          decoration:
                                              BoxDecoration(border: Border.all(color: AppColor.primaryRed), borderRadius: BorderRadius.circular(8), color: AppColor.primaryRed.withOpacity(0.3)),
                                          child: Text(
                                            "Declined",
                                            style: const TextStyle().normal12w500.textColor(AppColor.black),
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                                // if (usersController.selectedTabIndex.value == 1)
                                //   DataCell(GestureDetector(
                                //     onTap: () {
                                //       FirebaseFirestore.instance.collection('users').doc(document.id).update({'is_verified': 0});
                                //       showAppToast("User request declined");
                                //     },
                                //     child: Container(
                                //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                //       decoration: BoxDecoration(border: Border.all(color: AppColor.primaryRed), borderRadius: BorderRadius.circular(8), color: AppColor.primaryRed.withOpacity(0.3)),
                                //       child: Text(
                                //         "Declined",
                                //         style: const TextStyle().normal12w500.textColor(AppColor.black),
                                //       ),
                                //     ),
                                //   )),
                                // if (usersController.selectedTabIndex.value == 2)
                                //   DataCell(GestureDetector(
                                //     onTap: () {
                                //       FirebaseFirestore.instance.collection('users').doc(document.id).update({'is_verified': 1});
                                //       showAppToast("User verified successfully");
                                //     },
                                //     child: Container(
                                //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColor.saveGreen), color: AppColor.saveGreen.withOpacity(0.3)),
                                //       child: Text(
                                //         "Approved",
                                //         style: const TextStyle().normal12w500.textColor(AppColor.black),
                                //       ),
                                //     ),
                                //   )),
                              ],
                            );
                          }).toList(),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const Gap(20),
      ],
    );
  }

  List<DocumentSnapshot<Object?>> changeData(List<DocumentSnapshot<Object?>> filteredUsers, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    if (usersController.selectedTabIndex.value == 1) {
      filteredUsers = snapshot.data!.docs.where((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return data['is_verified'] == 1;
      }).toList();
    } else if (usersController.selectedTabIndex.value == 2) {
      filteredUsers = snapshot.data!.docs.where((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return data['is_verified'] == 0;
      }).toList();
    } else {
      filteredUsers = snapshot.data!.docs.where((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return data['is_verified'] == (-1);
      }).toList();
    }
    return filteredUsers;
  }
}
