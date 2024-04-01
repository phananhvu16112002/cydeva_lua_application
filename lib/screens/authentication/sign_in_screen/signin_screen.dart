import 'package:cydeva_lua_application/common/bases/custom_button.dart';
import 'package:cydeva_lua_application/common/bases/custom_text.dart';
import 'package:cydeva_lua_application/screens/authentication/register_screen/register_screen.dart';
import 'package:cydeva_lua_application/common/colors/Colors.dart';
import 'package:cydeva_lua_application/screens/authentication/sign_in_screen/bloc/signin_bloc.dart';
import 'package:cydeva_lua_application/screens/user_screen/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isVietnam = true;
  bool isEngland = false;
  String welcome = 'Chào mừng đến với LUA';
  String description =
      'Sed vel turpis adipiscing penatibus orci neque. Erat sed fermentum ipsum vel quis quam. Nunc etiam dui tortor, non in aliquam lacinia tempor.';
  late ProgressDialog _progressDialog;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressDialog = customLoading();
  }

  ProgressDialog customLoading() {
    return ProgressDialog(context,
        customBody: Container(
          width: 200,
          height: 150,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white),
          child: const Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppColors.borderColor,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Loading',
                style: TextStyle(
                    fontSize: 16,
                    color: AppColors.neutralBlack,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocListener<SigninBloc, SigninState>(
          listener: (context, state) async {
            if (state.status == BaseStatus.success) {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => BlocProvider.value(
                            value: BlocProvider.of<SigninBloc>(context),
                            child: const ProfileScreen(),
                          )));
              await _progressDialog.hide();
            }
            if (state.status == BaseStatus.failed) {
              print('Failed to login to Google');
              await _progressDialog.hide();
              await customDialog(context);
            }
          },
          child: BlocBuilder<SigninBloc, SigninState>(
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/loginImage.png',
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 18),
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
                                      child: GestureDetector(
                                        onTap: () {
                                          _showBottomSheet(context);
                                        },
                                        child: isVietnam
                                            ? Image.asset(
                                                'assets/images/vietnam.png',
                                                width: 32,
                                                height: 24,
                                              )
                                            : Image.asset(
                                                'assets/images/england.png',
                                                width: 32,
                                                height: 24,
                                              ),
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
                                        builder: (builder) =>
                                            const ProfileScreen(),
                                      ),
                                    );
                                  },
                                  child: methodSignIn('Đăng nhập với Apple',
                                      'assets/icons/apple.svg'),
                                ),
                                const SizedBox(height: 16),
                                InkWell(
                                  onTap: () {
                                    _progressDialog.show();
                                    context
                                        .read<SigninBloc>()
                                        .add(SignInSubmitted());
                                  },
                                  child: methodSignIn('Đăng nhập với Google',
                                      'assets/icons/google.svg'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> customDialog(BuildContext context) => showDialog(
      context: context,
      builder: (builder) => AlertDialog(
            backgroundColor: Colors.white,
            title: const CustomText(
                message: 'Login',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.colorText),
            content: const CustomText(
                message: 'Failed to login google account',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.colorText),
            actions: [TextButton(onPressed: () {}, child: const Text('OK'))],
          ));

  Container methodSignIn(String method, String svgPath) {
    return Container(
      width: 390,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.neutralWhite,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Row(
          children: [
            SvgPicture.asset(svgPath),
            const SizedBox(
              width: 16,
            ),
            customText(method, 14, FontWeight.w400, AppColors.colorText, 0),
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
        height: height,
      ),
    );
  }

  Padding englandOption(Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/images/england.png'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const CustomText(
                    message: 'Tiếng Anh',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorText,
                  ),
                ],
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: isEngland
                        ? AppColors.colorButton
                        : AppColors.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isEngland
                          ? AppColors.colorButton
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding vietnamOption(Function() onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset('assets/images/vietnam.png'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const CustomText(
                    message: 'Tiếng Việt',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorText,
                  ),
                ],
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: isVietnam
                        ? AppColors.colorButton
                        : AppColors.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isVietnam
                          ? AppColors.colorButton
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            height: 330,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CustomText(
                      message: 'Chọn ngôn ngữ',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorText,
                    ),
                  ),
                  vietnamOption(() {
                    setState(() {
                      isVietnam = true;
                      isEngland = false;
                    });
                  }),
                  englandOption(() {
                    setState(() {
                      isVietnam = false;
                      isEngland = true;
                    });
                  }),
                  const SizedBox(
                    height: 110,
                  ),
                  CustomButton(
                    buttonName: 'Xác nhận',
                    backgroundColorButton: AppColors.colorButton,
                    borderColor: Colors.transparent,
                    textColor: AppColors.neutralWhite,
                    function: () {
                      _updateLanguageSelection(isVietnam);
                      Navigator.pop(context);
                    },
                    height: 50,
                    width: 380,
                    fontSize: 16,
                    colorShadow: Colors.transparent,
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _updateLanguageSelection(bool isVietnamSelected) {
    setState(() {
      isVietnam = isVietnamSelected;
      isEngland = !isVietnamSelected;
    });
  }
}
