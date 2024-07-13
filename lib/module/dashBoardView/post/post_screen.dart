
import 'package:web_redrop/package/config_packages.dart';
import 'package:web_redrop/package/screen_packages.dart';


class PushNotificationScreen extends StatefulWidget {
  const PushNotificationScreen({super.key});

  @override
  State<PushNotificationScreen> createState() => _PushNotificationScreenState();
}

class _PushNotificationScreenState extends State<PushNotificationScreen> {
  final pushNotificationController = Get.put<PushNotificationController>(PushNotificationController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState

    pushNotificationController.titleController.clear();
    pushNotificationController.descController.clear();
    pushNotificationController.imageFiles?.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: MediaQuery
              .of(context)
              .size
              .width / 5,
          right: MediaQuery
              .of(context)
              .size
              .width / 5,
          bottom: MediaQuery
              .of(context)
              .size
              .width / 15.5,
          top: MediaQuery
              .of(context)
              .size
              .width / 15.5),
      decoration: CommonContainerDecoration.boxDecoration(borderRadius: 23),
      child: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SingleChildScrollView(child: _columnWidget(context)),
      ),
    );
  }

  Widget _columnWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Create Post",
          style: const TextStyle().normal32w600.textColor(AppColor.primaryRed),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 3.0),
          child: Divider(
            color: AppColor.primaryRed,
          ),
        ),
        const Gap(10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Post Title",
                          style: const TextStyle().normal16w500.textColor(AppColor.black),
                        ),
                        const Gap(10),
                        InputField(
                          validator: (val) {
                            if (val == null ) {
                              return "Title is Required";
                            }
                          },
                          maxLine: 1,
                          controller: pushNotificationController.titleController,
                        ),
                        const Gap(10),
                        Text(
                          "Location",
                          style: const TextStyle().normal16w500.textColor(AppColor.black),
                        ),
                        const Gap(10),
                        InputField(
                          validator: (val) {
                            if (val == null ) {
                              return "Location is Required";
                            }
                          },
                          maxLine: 1,
                          controller: pushNotificationController.descController,
                        ),
                        const Gap(10),
                        _uploadImage(),
                        const Gap(10),
                      ],
                    ),
                  ),
                  const Gap(30),
                  CommonAppButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        if ((pushNotificationController.imageFiles ?? []).isNotEmpty) {
                          await uploadImagesAndAddPost();
                        } else {
                          showAppToast("Please Select image");
                        }
                      }
                    },
                    buttonType: ButtonType.enable,
                    text: "Add",
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> uploadImagesAndAddPost() async {
    try {
      List<String> imageUrls = [];
      showLoader();
      for (XFile file in pushNotificationController.imageFiles!) {
        Reference storageRef = FirebaseStorage.instance.ref().child('images/${DateTime
            .now()
            .millisecondsSinceEpoch}');
        final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path},
        );
        UploadTask uploadTask = storageRef.putData(await file.readAsBytes(), metadata);
        TaskSnapshot taskSnapshot = await uploadTask;
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      await FirebaseFirestore.instance.collection('posts').add({
        'title': pushNotificationController.titleController.text,
        'imageUrls': imageUrls,
        'location': pushNotificationController.descController.text,
        'createdAt': DateTime.now(),
      }).then((value) {

        pushNotificationController.sendNotificationsToUsers();
        pushNotificationController.imageFiles?.clear();
        pushNotificationController.titleController.clear();
        pushNotificationController.descController.clear();
        setState(() {});
        dismissLoader();



        showAppToast("Post Added Successfully!");
      });
    } catch (e) {
      dismissLoader();
    }
  }

  Widget _uploadImage() {
    return GestureDetector(
      onTap: () {
        selectFiles();
      },
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 4,
        decoration: BoxDecoration(color: AppColor.primaryRed.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: (pushNotificationController.imageFiles ?? []).isNotEmpty
              ? ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: pushNotificationController.imageFiles!.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: kIsWeb
                      ? Image.network(pushNotificationController.imageFiles![index].path)
                      : Image.file(File(pushNotificationController.imageFiles![index].path)),
                );
              })
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImage.camera,
                height: 24,
                width: 27,
              ),
              const Gap(8),
              Text(
                "Add photo",
                style: const TextStyle().normal16w500.textColor(AppColor.black.withOpacity(0.5)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectFiles() async {
    List<XFile>? files = await ImagePicker().pickMultiImage(
      maxHeight: 1000,
      maxWidth: 1000,
    );

    if (files.isNotEmpty) {
      setState(() {
        pushNotificationController.imageFiles = files;
      });
    }
  }
}
