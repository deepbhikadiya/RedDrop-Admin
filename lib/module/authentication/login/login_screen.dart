import 'package:web_redrop/components/auth_field.dart';
import 'package:web_redrop/module/authentication/login/login_controller.dart';

import '../../../package/config_packages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put<LoginController>(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          if (!Responsive.isMobile(context))
            Expanded(
              flex: 3,
              child: Container(
                color: AppColor.primaryRed,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Gap(180),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "RedDrop",
                            style: const TextStyle().normal40w500.textColor(AppColor.white),
                          ),
                          Text(
                            "Bridge the Gap, Be a Donor's Beacon.",
                            style: const TextStyle().normal18w500.textColor(AppColor.white),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Align(alignment: Alignment.bottomLeft, child: SizedBox(height: 200, width: 300, child: Image.asset(AppImage.auth))),
                  ],
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.isMobile(context) ? 16.0 : 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello Again!",
                        style: const TextStyle().normal26w500,
                      ),
                      const Gap(10),
                      Text(
                        "Welcome Back",
                        style: const TextStyle().normal18w400,
                      ),
                      const Gap(45),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            AuthTextField(
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: AppColor.textFieldBorder,
                              ),
                              hintText: "ID",
                              width: double.infinity,
                              controller: loginController.idController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if ((val ?? "").isEmpty) {
                                  return "Please enter email";
                                } else if (!val.toString().isEmail) {
                                  return "Please enter valid email";
                                }
                              },
                            ),
                            Obx(
                              () => AuthTextField(
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: AppColor.textFieldBorder,
                                ),
                                hintText: "Password",
                                obscureText: loginController.password.value,
                                maxLine: 1,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    loginController.password.value = !loginController.password.value;
                                  },
                                  child: Icon(loginController.password.value ? Icons.remove_red_eye_outlined : Icons.remove_red_eye),
                                ),
                                width: double.infinity,
                                controller: loginController.passwordController,
                                textInputAction: TextInputAction.done,
                                validator: (val) {
                                  if ((val ?? "").isEmpty) {
                                    return "Please enter password";
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(20),
                      Obx(() {
                        return CommonAppButton(
                          borderRadius: 30,
                          text: "Login",
                          // buttonType: ButtonType.progress,
                          buttonType: loginController.isLoad.value == true ? ButtonType.progress : ButtonType.enable,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              loginController.login(context, email: loginController.idController.text, password: loginController.passwordController.text);
                            }
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
