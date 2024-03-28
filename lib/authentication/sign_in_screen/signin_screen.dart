import 'package:cydeva_lua_application/authentication/profile_screen.dart/profile_screen.dart';
import 'package:cydeva_lua_application/common/colors/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String welcome = 'Chào mừng đến với LUA';
  String description =
      'Sed vel turpis adipiscing penatibus orci neque. Erat sed fermentum ipsum vel quis quam. Nunc etiam dui tortor, non in aliquam lacinia tempor.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              'assets/images/loginImage.png',
              fit: BoxFit.fitHeight,
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/vietnam.png',
                                  width: 32,
                                  height: 24,
                                ),
                              ),
                            ],
                          ),
                          customText(welcome, 25, FontWeight.w400,
                              AppColors.neutralWhite, 0),
                          const SizedBox(
                            height: 8,
                          ),
                          customText(description, 14, FontWeight.w400,
                              AppColors.descriptionColor, 1.5),
                        ],
                      ),
                      const SizedBox(
                        height: 390,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => ProfileScreen()));
                            },
                            child: methodSignIn('Đăng nhập với Apple',
                                'assets/icons/apple.svg'),
                          ),
                          const SizedBox(height: 16),
                          methodSignIn(
                              'Đăng nhập với Google', 'assets/icons/google.svg')
                        ],
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container methodSignIn(String method, String svgPath) {
    return Container(
      width: 390,
      height: 60,
      decoration: BoxDecoration(
          color: AppColors.neutralWhite,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor)),
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Row(
          children: [
            SvgPicture.asset(svgPath),
            const SizedBox(
              width: 16,
            ),
            customText(method, 14, FontWeight.w400, AppColors.colorText, 0)
          ],
        ),
      ),
    );
  }

  Widget customText(String message, double fontSize, FontWeight fontWeight,
      Color color, double height) {
    return Text(
      message,
      maxLines: null,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          height: height),
    );
  }
}
