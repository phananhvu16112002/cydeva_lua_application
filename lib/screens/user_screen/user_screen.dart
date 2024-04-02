import 'package:cydeva_lua_application/common/bases/custom_text.dart';
import 'package:cydeva_lua_application/common/colors/Colors.dart';
import 'package:cydeva_lua_application/models/user.dart';
import 'package:cydeva_lua_application/screens/authentication/sign_in_screen/bloc/signin_bloc.dart';
import 'package:cydeva_lua_application/screens/authentication/sign_in_screen/signin_screen.dart';
import 'package:cydeva_lua_application/screens/my_account/my_account.dart';
import 'package:cydeva_lua_application/screens/my_account/bloc/my_account_bloc.dart';
import 'package:cydeva_lua_application/screens/wishlist_screen/bloc/wishlist_bloc.dart';
import 'package:cydeva_lua_application/screens/wishlist_screen/wishlist_screen.dart';
import 'package:cydeva_lua_application/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _SettingScreenBodyState();
}

class _SettingScreenBodyState extends State<UserScreen> {
  String? fullName = '';
  String? avatar = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfor().then((value) {
      setState(() {
        fullName = value[0];
        avatar = value[1];
      });
    });
  }

  Future<List> getInfor() async {
    var temp1 = await SecureStorage().readSecureData('full_name');
    var temp2 = await SecureStorage().readSecureData('url');
    var tempArray = [];
    tempArray.add(temp1);
    tempArray.add(temp2);
    return tempArray;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.neutralWhite,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 380,
                    height: 84,
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: avatar!.isEmpty
                                ? Image.asset('assets/images/avatar.png')
                                : Image.network(avatar!)),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            // width: 300,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: AppColors.borderColor))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                    message: fullName ?? '',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.colorName),
                                const SizedBox(
                                  height: 4,
                                ),
                                const CustomText(
                                    message: 'Người mới',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.colorRole),
                                const SizedBox(
                                  height: 4,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => BlocProvider(
                                    create: (context) => MyAccountBloc(),
                                    child: const MyAccountPage(),
                                  )));
                    },
                    child: customOptions(
                        'user', 'Tài khoản của tôi', AppColors.colorText),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => BlocProvider(
                                    create: (context) => WishlistBloc(),
                                    child: const WishListScreen(),
                                  )));
                    },
                    child: Container(
                      width: 380,
                      height: 70,
                      child: Image.asset('assets/images/banner.png'),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Container(
                    height: 370,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.colorShadow.withOpacity(0.09),
                              blurRadius: 45,
                              offset: const Offset(0, 8))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          customOptions(
                              'dollar', 'Gói đăng ký', AppColors.colorText),
                          customOptions(
                              'language', 'Ngôn ngữ', AppColors.colorText),
                          customOptions(
                              'payment', 'Thanh toán', AppColors.colorText),
                          customOptions(
                              'help', 'Trung tâm hỗ trợ', AppColors.colorText),
                          customOptions('shield', 'Quyền riêng tư và bảo mật',
                              AppColors.colorText),
                          InkWell(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (builder) => AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: const Text('Sign Out'),
                                        content: const Text('Are you sure ?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                await SecureStorage()
                                                    .deleteSecureData(
                                                        'phone_number');
                                                await SecureStorage()
                                                    .deleteSecureData(
                                                        'full_name');
                                                await SecureStorage()
                                                    .deleteSecureData(
                                                        'address');
                                                await SecureStorage()
                                                    .deleteSecureData('url');
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (builder) =>
                                                            const SignInPage()),
                                                    (route) => false);
                                              },
                                              child: const Text(
                                                'OK',
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                'Cancel',
                                              ))
                                        ],
                                      ));
                            },
                            child: customOptions(
                                'signout', 'Đăng xuất', AppColors.saoColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  Container(
                    height: 90,
                    width: 380,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.colorShadow.withOpacity(0.09),
                              blurRadius: 45,
                              offset: const Offset(0, 8))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Center(
                        child: customOptions(
                            'garbage', 'Xoá tài khoản', AppColors.colorText),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget inforUser() {
    return Container(
      width: 380,
      height: 84,
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset('assets/images/avatar.png')),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Container(
              height: 60,
              // width: 300,
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: AppColors.borderColor))),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                      message: 'userDetail.name ?? ' '',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorName),
                  SizedBox(
                    height: 4,
                  ),
                  CustomText(
                      message: 'Người mới',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.colorRole),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding customOptions(String iconPath, String title, Color colorTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.borderColor))),
        child: Row(
          children: [
            SvgPicture.asset('assets/icons/$iconPath.svg'),
            const SizedBox(
              width: 8,
            ),
            CustomText(
                message: title,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: colorTitle)
          ],
        ),
      ),
    );
  }
}
