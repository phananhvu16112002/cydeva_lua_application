import 'package:cydeva_lua_application/common/bases/CustomText.dart';
import 'package:cydeva_lua_application/common/colors/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> errorMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutralWhite,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    appbar(),
                    const SizedBox(
                      height: 16,
                    ),
                    customTextField(
                        nameController,
                        TextInputType.text,
                        'Họ và tên',
                        'Nhập họ và tên',
                        AppColors.hintTextColor, (value) {
                      if (value!.isEmpty) {
                        return 'Bắt buộc phải nhập tên';
                      }
                      return null;
                    }, const Icon(null), null),
                    const SizedBox(
                      height: 22,
                    ),
                    customTextField(
                        genderController,
                        TextInputType.text,
                        'Giới tính',
                        'Chọn giới tính',
                        AppColors.hintTextColor, (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng chọn giới tính';
                      }
                      return null;
                    }, const Icon(Icons.arrow_drop_down_outlined), null),
                    const SizedBox(
                      height: 22,
                    ),
                    customTextField(
                        phoneController,
                        TextInputType.phone,
                        'Số điện thoại',
                        'Nhập số điện thoại',
                        AppColors.hintTextColor, (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      return null;
                    }, const Icon(null), null),
                    const SizedBox(
                      height: 22,
                    ),
                    customTextField(
                        addressController,
                        TextInputType.text,
                        'Địa chỉ',
                        'Nhập địa chỉ của bạn',
                        AppColors.hintTextColor, (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập địa chỉ';
                      }
                      return null;
                    }, const Icon(null), null),
                    const SizedBox(
                      height: 22,
                    ),
                    customTextField(
                        emailController,
                        TextInputType.emailAddress,
                        'Email',
                        'sample@gmail.com',
                        const Color(0xff2D3748), (value) {
                      if (value!.isEmpty) {
                        return 'Vui lòng nhập email';
                      }
                      return null;
                    }, const Icon(null), null),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // print('aloalo');
                        }
                      },
                      child: Container(
                        width: 400,
                        height: 52,
                        decoration: BoxDecoration(
                            color: AppColors.colorButton,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: CustomText(
                              message: 'Xác nhận',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.neutralWhite),
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  // Stack customTextField(
  //     TextEditingController textEditingController,
  //     TextInputType textInputType,
  //     String labelText,
  //     String hintText,
  //     Color colorHintText,
  //     String? Function(String?)? validator) {
  //   return Stack(
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(top: 10.0),
  //         child: TextFormField(
  //           // cursorColor: Colors.black,
  //           readOnly: false,
  //           controller: textEditingController,
  //           keyboardType: textInputType,
  //           style: const TextStyle(
  //               color: AppColors.colorLabelText,
  //               fontWeight: FontWeight.normal,
  //               fontSize: 15),
  //           obscureText: false,
  //           decoration: InputDecoration(
  //               filled: true,
  //               fillColor: Colors.white,
  //               // isDense: true,
  //               hintStyle: TextStyle(
  //                   color: colorHintText,
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.w400),
  //               border: const OutlineInputBorder(
  //                   borderSide:
  //                       BorderSide(width: 1, color: AppColors.colorBorder),
  //                   borderRadius: BorderRadius.all(Radius.circular(8))),
  //               contentPadding: const EdgeInsets.all(20),
  //               suffixIcon: const IconButton(onPressed: null, icon: Icon(null)),
  //               hintText: hintText, // change here hinttext
  //               // labelText: 'asdasdsad',
  //               enabledBorder: const OutlineInputBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(8)),
  //                   borderSide:
  //                       BorderSide(width: 1, color: AppColors.colorBorder)),
  //               errorBorder: const OutlineInputBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(8)),
  //                   borderSide: BorderSide(width: 1, color: Colors.red)),
  //               focusedBorder: const OutlineInputBorder(
  //                 borderRadius: BorderRadius.all(Radius.circular(8)),
  //                 borderSide: BorderSide(width: 1, color: Colors.black),
  //               )),
  //           validator: validator,
  //           // onSaved: onSaved,
  //           // onChanged: onChanged,
  //         ),
  //       ),
  //       Positioned(
  //         top: 2,
  //         left: 8,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8),
  //           child: Container(
  //             height: 20,
  //             color: Colors.white,
  //             child: Padding(
  //                 padding: const EdgeInsets.only(left: 4),
  //                 child: RichText(
  //                     text: TextSpan(children: [
  //                   TextSpan(
  //                     text: labelText,
  //                     style: const TextStyle(
  //                       fontWeight: FontWeight.w400,
  //                       fontSize: 12,
  //                       color: AppColors.colorLabelText,
  //                     ),
  //                   ),
  //                   const TextSpan(
  //                     text: ' *',
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.w400,
  //                       fontSize: 12,
  //                       color: AppColors.saoColor,
  //                     ),
  //                   ),
  //                 ]))),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Stack customTextField(
      TextEditingController textEditingController,
      TextInputType textInputType,
      String labelText,
      String hintText,
      Color colorHintText,
      String? Function(String?)? validator,
      Icon icon,
      Function()? onPressed) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TextFormField(
            controller: textEditingController,
            keyboardType: textInputType,
            style: const TextStyle(
                color: AppColors.colorLabelText,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            obscureText: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(
                  color: colorHintText,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              border: const OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.colorBorder),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              contentPadding: const EdgeInsets.all(20),
              suffixIcon: IconButton(onPressed: onPressed, icon: icon),
              hintText: hintText,
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide:
                      BorderSide(width: 1, color: AppColors.colorBorder)),
              errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: Colors.red)),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 1, color: AppColors.colorButton),
              ),
            ),
            validator: validator,
          ),
        ),
        Positioned(
          top: 2,
          left: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: 20,
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: labelText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.colorLabelText,
                      ),
                    ),
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.saoColor,
                      ),
                    ),
                  ]))),
            ),
          ),
        ),
      ],
    );
  }

  Center avatar() {
    return Center(
      child: Stack(
        children: [
          Image.asset('assets/images/avatar.png'),
          Positioned(
            top: 60,
            left: 60,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: AppColors.colorCamera),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/camera.svg',
                  width: 22,
                  height: 18,
                  fit: BoxFit.none,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget appbar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      color: AppColors.neutralWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/icons/arrowback.svg'),
                const SizedBox(
                  width: 100,
                ),
                const CustomText(
                    message: 'Thông tin cá nhân ',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.colorTextAppbar),
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            avatar()
          ],
        ),
      ),
    );
  }
}
