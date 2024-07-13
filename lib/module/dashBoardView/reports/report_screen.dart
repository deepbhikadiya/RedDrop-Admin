import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:universal_html/html.dart' as html;

import 'package:web_redrop/package/config_packages.dart';
import 'package:web_redrop/package/screen_packages.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final reportController = Get.put<ReportController>(ReportController());

  Map<String, int> bloodGroupCounts = {
    'A +ve': 0,
    'B +ve': 0,
    'O +ve': 0,
    'AB +ve': 0,
    'A -ve': 0,
    'B -ve': 0,
    'O -ve': 0,
    'AB -ve': 0,
  };

  RxList<ChartData> data = [
    ChartData(x: "A +ve", y: 0),
    ChartData(x: "B +ve", y: 0),
    ChartData(x: "O +ve", y: 0),
    ChartData(x: "AB +ve", y: 0),
    ChartData(x: "A -ve", y: 0),
    ChartData(x: "B -ve", y: 0),
    ChartData(x: "O -ve", y: 0),
    ChartData(x: "AB -ve", y: 0),
  ].obs;

  Future<void> generateChart({String? bloodGroup}) async {
    reportController.isLoadingDashboard.value = true;
    if (bloodGroup != null && bloodGroupCounts.containsKey(bloodGroup)) {
      bloodGroupCounts[bloodGroup] = (bloodGroupCounts[bloodGroup] ?? 0) + 1; // Using ?? operator
    }

    // Update chart data
    for (var chartData in data) {
      chartData.y = bloodGroupCounts[chartData.x] ?? 0; // Using ?? operator
    }
    reportController.isLoadingDashboard.value = false;
  }

  Future<void> generateExcelFile(DateRange dateRange) async {
    final workbook = xlsio.Workbook();
    final sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('Donation Date');

    ///donor
    sheet.getRangeByName('B1').setText('Donor First Name');
    sheet.getRangeByName('C1').setText('Donor Last Name');
    sheet.getRangeByName('D1').setText('Donor Phone Number');
    sheet.getRangeByName('E1').setText('Donor Blood Group');
    sheet.getRangeByName('F1').setText('Donor DOB');
    sheet.getRangeByName('G1').setText('Donor Profile');
    sheet.getRangeByName('H1').setText('Donor Aadhar');
    sheet.getRangeByName('I1').setText('Donor City');
    sheet.getRangeByName('J1').setText('Donor Area');

    ///seeker

    sheet.getRangeByName('L1').setText('Seeker First Name');
    sheet.getRangeByName('M1').setText('Seeker Last Name');
    sheet.getRangeByName('N1').setText('Seeker Phone Number');
    sheet.getRangeByName('O1').setText('Seeker Blood Group');
    sheet.getRangeByName('P1').setText('Seeker DOB');
    sheet.getRangeByName('Q1').setText('Seeker Profile');
    sheet.getRangeByName('R1').setText('Seeker Aadhar');
    sheet.getRangeByName('S1').setText('Seeker City');
    sheet.getRangeByName('T1').setText('Seeker Area');

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('donation_history').get();
    if (snapshot.docs.isEmpty) {
      showAppToast("No Donation History");
      return;
    }
    for (int i = 0; i < snapshot.docs.length; i++) {
      final row = i + 2;
      var data = (snapshot.docs[i].data() as Map<String, dynamic>);
      DateTime donationDate = data['date'].toDate().toLocal();
      String donationDateString = '${donationDate.year}-${donationDate.month.toString().padLeft(2, '0')}-${donationDate.day.toString().padLeft(2, '0')}';

      DateTime donorDOB = data['donor']['date_of_birth'].toDate().toLocal();
      String donorDOBString = '${donorDOB.year}-${donorDOB.month.toString().padLeft(2, '0')}-${donorDOB.day.toString().padLeft(2, '0')}';

      sheet.getRangeByIndex(row, 1).setText(donationDateString);
      sheet.getRangeByIndex(row, 2).setText(data['donor']['first_name'] ?? '');
      sheet.getRangeByIndex(row, 3).setText(data['donor']['last_name'] ?? '');
      sheet.getRangeByIndex(row, 4).setText(data['donor']['phone_number'] ?? '');
      sheet.getRangeByIndex(row, 5).setText(data['donor']['blood_group'] ?? '');
      sheet.getRangeByIndex(row, 6).setText(donorDOBString);
      sheet.getRangeByIndex(row, 7).setText(data['donor']['image'] ?? '');
      sheet.getRangeByIndex(row, 8).setText(data['donor']['aadhar_image'] ?? '');
      sheet.getRangeByIndex(row, 9).setText(data['donor']['city'] ?? '');
      sheet.getRangeByIndex(row, 10).setText(data['donor']['area'] ?? '');

      ///seker
      DateTime seekerDOB = data['seeker']['date_of_birth'].toDate().toLocal();
      String seekerDOBString = '${seekerDOB.year}-${seekerDOB.month.toString().padLeft(2, '0')}-${seekerDOB.day.toString().padLeft(2, '0')}';
      sheet.getRangeByIndex(row, 12).setText(data['seeker']['first_name'] ?? '');
      sheet.getRangeByIndex(row, 13).setText(data['seeker']['last_name'] ?? '');
      sheet.getRangeByIndex(row, 14).setText(data['seeker']['phone_number'] ?? '');
      sheet.getRangeByIndex(row, 15).setText(data['seeker']['blood_group'] ?? '');
      sheet.getRangeByIndex(row, 16).setText(seekerDOBString);
      sheet.getRangeByIndex(row, 17).setText(data['seeker']['image'] ?? '');
      sheet.getRangeByIndex(row, 18).setText(data['seeker']['aadhar_image'] ?? '');
      sheet.getRangeByIndex(row, 19).setText(data['seeker']['city'] ?? '');
      sheet.getRangeByIndex(row, 20).setText(data['seeker']['area'] ?? '');
    }

    final excelBytes = workbook.saveAsStream();
    const excelFileName = 'donation_history.xlsx';

    final blob = html.Blob([Uint8List.fromList(excelBytes).buffer]);

    final url = html.Url.createObjectUrlFromBlob(blob);
   html.AnchorElement(href: url)
      ..target = 'web-download'
      ..download = excelFileName
      ..click();
    showAppToast("Successfully Download");
  }

  DateRange? dateRange = DateRange(DateTime.now(), DateTime.now());
  RxList<DocumentSnapshot> filteredUsers = <DocumentSnapshot>[].obs;
  late AsyncSnapshot<QuerySnapshot<Object?>> filterSnapshot;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(40),
      decoration: CommonContainerDecoration.boxDecoration(borderRadius: 23),
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SingleChildScrollView(child: report()),
      ),
    );
  }

  Widget report() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Donation History Report",
              style: const TextStyle().normal32w600.textColor(AppColor.primaryRed),
            ),
            const Spacer(),
            CommonAppButton(
              borderRadius: 12,
              width: 200,
              height: 42,
              text: "Generate Report",
              buttonType: ButtonType.enable,
              onTap: () {
                generateExcelFile(dateRange!);
              },
            ),
            const Gap(20),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Divider(
            color: AppColor.primaryRed,
          ),
        ),
        const Gap(10),
        Text(
          "Please select date range to generate donation history report.",
          style: const TextStyle().normal16w400.textColor(Colors.black),
        ),
        const Gap(10),
        // SfCartesianChart(
        //                 borderColor: Colors.transparent,
        //                 // primaryXAxis: const CategoryAxis(
        //                 //   borderColor: Colors.transparent,
        //                 //   majorGridLines: MajorGridLines(width: 0),
        //                 // ),
        //                 primaryXAxis: const CategoryAxis(),
        //
        //                 primaryYAxis: const NumericAxis(
        //                   borderColor: Colors.transparent,
        //                   minimum: 0,
        //                   maximum: 400,
        //                   interval: 100,
        //                   majorGridLines: MajorGridLines(width: 0),
        //                 ),
        //                 // tooltipBehavior: _tooltip,
        //                 legend: const Legend(),
        //                 series: <CartesianSeries<ChartData, String>>[
        //                   ColumnSeries<ChartData, String>(
        //                     dataSource: data,
        //                     xValueMapper: (ChartData data, _) => data.x,
        //                     yValueMapper: (ChartData data, _) => data.y,
        //                     color: AppColor.primaryRed,
        //                   )
        //                 ],
        // ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                showRangeDateDialogue(context);
              },
              child: Text(
                "SELECT DATE",
                style: const TextStyle(decoration: TextDecoration.underline).normal18w500.textColor(AppColor.primaryRed),
              ),
            ),
            const Gap(10),
            Text(
              "${DateFormat("dd/MM/yyyy").format(dateRange!.start)}-${DateFormat("dd/MM/yyyy").format(dateRange!.end)}",
              style: const TextStyle().normal16w400.textColor(Colors.black),
            ),
          ],
        ),
        const Gap(20),
        Container(
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
                      const Spacer(),
                      if (Responsive.isDesktop(context)) ...[
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: InputField(
                            onChange: (val) {
                              filteredUsers.value = changeData(filteredUsers, filterSnapshot);
                              setState(() {});
                            },
                            controller: reportController.searchUserController.value,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                reportController.searchUserController.value.clear();
                                filteredUsers.value = changeData(filteredUsers, filterSnapshot);
                                setState(() {});
                              },
                              child: const Icon(Icons.close),
                            ),
                          ),
                        ),
                        const Gap(20),
                      ],
                    ],
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('donation_history').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  filterSnapshot = snapshot;
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  filteredUsers.value = changeData(filteredUsers, filterSnapshot);
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
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
                        columns: const [
                          DataColumn2(label: Text("Donor name"), size: ColumnSize.L),
                          DataColumn2(label: Text("Blood Group")),
                          DataColumn2(label: Text("Seeker name"), size: ColumnSize.L),
                          DataColumn2(label: Text("Donation date"), size: ColumnSize.S),
                          DataColumn2(label: Text("Location")),
                        ],
                        rows: filteredUsers.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                          generateChart(bloodGroup: data['blood_group'].toString());

                          return DataRow(
                            onLongPress: () {},
                            cells: [
                              DataCell(Text((data["donor"]['first_name'] ?? "") + " " + (data["donor"]['middle_name'] ?? "") + " " + data["donor"]['last_name'] ?? "")),
                              DataCell(Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColor.primaryRed,
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: Row(
                                  children: [
                                    const Gap(5),
                                    Text(
                                      data['blood_group'] ?? "",
                                      style: const TextStyle().normal16w400.textColor(Colors.white),
                                    ),
                                    const Gap(5),
                                    const Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )),
                              DataCell(Text((data["seeker"]['first_name'] ?? "") + " " + (data["seeker"]['middle_name'] ?? "") + " " + data["seeker"]['last_name'] ?? "")),
                              DataCell(Text(DateFormat("dd/MM/yyyy").format(data['date'].toDate()))),
                              DataCell(Text(data["location"]['address'] ?? "")),
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


      ],
    );
  }

  List<DocumentSnapshot> changeData(List<DocumentSnapshot> filteredUsers, AsyncSnapshot<QuerySnapshot> snapshot) {
    filteredUsers = snapshot.data!.docs.toList();
    if (reportController.searchUserController.value.text.isNotEmpty) {
      String searchText = reportController.searchUserController.value.text.toLowerCase();
      filteredUsers = snapshot.data!.docs.where((doc) {
        var data = doc.data() as Map<String, dynamic>;

        return (data["donor"]['first_name'] ?? "").toLowerCase().contains(searchText) ||
            (data["donor"]['middle_name'] ?? "").toLowerCase().contains(searchText) ||
            (data["donor"]['last_name'] ?? "").toLowerCase().contains(searchText) ||
            (data["seeker"]['first_name'] ?? "").toLowerCase().contains(searchText) ||
            (data["seeker"]['middle_name'] ?? "").toLowerCase().contains(searchText) ||
            (data["seeker"]['last_name'] ?? "").toLowerCase().contains(searchText) ||
            (data['blood_group'] ?? "").toLowerCase().contains(searchText) ||
            (data["location"]['address'] ?? "").toLowerCase().contains(searchText);
      }).toList();
    }
    return filteredUsers;
  }

  Future<void> showRangeDateDialogue(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width / 2.8 : 20, vertical: 50),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24, top: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Date range",
                      style: const TextStyle().normal22w700.textColor(AppColor.primaryRed),
                    ),
                    const Gap(25),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Center(
                        child: DateRangePickerWidget(
                          maxDate: DateTime.now(),
                          doubleMonth: false,
                          height: 350,
                          initialDateRange: DateRange(DateTime.now(), DateTime.now()),
                          initialDisplayedDate: DateTime.now(),
                          onDateRangeChanged: (dateRange1) {
                            dateRange = dateRange1;
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Text(
                              "Cancel",
                              style: const TextStyle().normal14w400.textColor(AppColor.black),
                            )),
                        const Gap(15),
                        GestureDetector(
                            onTap: () {
                              Get.back();
                              setState(() {});
                            },
                            child: Text(
                              "Confirm",
                              style: const TextStyle().normal14w400.textColor(AppColor.primaryRed),
                            )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
