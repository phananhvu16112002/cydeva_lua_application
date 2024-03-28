import 'dart:io';

import 'package:cydeva_lua_application/common/bases/custom_text.dart';
import 'package:cydeva_lua_application/common/colors/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedGender = 'Nam';
  String errorTextName = '';
  String errorTextPhone = '';
  String errorTextAddress = '';
  String errorTextEmail = '';
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  XFile? file;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(nameFocusNode);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    addressFocusNode.dispose();
    emailFocusNode.dispose();
  }

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
                    AppColors.hintTextColor,
                    const Icon(null),
                    null,
                    1000,
                    errorTextName,
                    FilteringTextInputFormatter.singleLineFormatter,
                    nameFocusNode,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  dropdownvalue_gender(),
                  const SizedBox(
                    height: 22,
                  ),
                  customTextField(
                      phoneController,
                      TextInputType.phone,
                      'Số điện thoại',
                      'Nhập số điện thoại',
                      AppColors.hintTextColor,
                      const Icon(null),
                      null,
                      10,
                      errorTextPhone,
                      FilteringTextInputFormatter.digitsOnly,
                      phoneFocusNode),
                  const SizedBox(
                    height: 22,
                  ),
                  customTextField(
                      addressController,
                      TextInputType.text,
                      'Địa chỉ',
                      'Nhập địa chỉ của bạn',
                      AppColors.hintTextColor,
                      const Icon(null),
                      null,
                      1000,
                      errorTextAddress,
                      FilteringTextInputFormatter.singleLineFormatter,
                      addressFocusNode),
                  const SizedBox(
                    height: 22,
                  ),
                  customTextField(
                      emailController,
                      TextInputType.emailAddress,
                      'Email',
                      'sample@gmail.com',
                      const Color(0xff2D3748),
                      const Icon(null),
                      null,
                      1000,
                      errorTextEmail,
                      FilteringTextInputFormatter.singleLineFormatter,
                      emailFocusNode),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      _validateInputs();
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack dropdownvalue_gender() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: DropdownButtonFormField<String>(
            // dropdownColor: Colors.red,
            style: const TextStyle(
                color: AppColors.colorLabelText,
                fontWeight: FontWeight.normal,
                fontSize: 15),
            value: selectedGender,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(
                  color: AppColors.hintTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: 1, color: AppColors.colorBorder),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              contentPadding: EdgeInsets.all(20),
              hintText: 'Chọn giới tính',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide:
                      BorderSide(width: 1, color: AppColors.colorBorder)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(width: 1, color: Colors.red)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(width: 1, color: AppColors.colorButton),
              ),
            ),
            onChanged: (String? newValue) {
              setState(() {
                selectedGender = newValue!;
              });
            },
            items: ['Nam', 'Nữ', 'Khác']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                alignment: Alignment.centerLeft,
                value: value,
                child: Container(child: Text(value)),
              );
            }).toList(),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Vui lòng chọn giới tính';
              }
              return null;
            },
          ),
        ),
        Positioned(
          top: 0,
          left: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: 20,
              color: Colors.white,
              child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                      text: 'Giới tính',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.colorLabelText,
                      ),
                    ),
                    TextSpan(
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

  void _validateInputs() {
    setState(() {
      errorTextName = '';
      errorTextPhone = '';
      errorTextAddress = '';
      errorTextEmail = '';
    });

    if (!_formKey.currentState!.validate()) {
      nameFocusNode.requestFocus();
      return;
    }

    if (nameController.text.isEmpty) {
      setState(() {
        errorTextName = 'Vui lòng nhập tên';
        errorTextPhone = '';
        errorTextAddress = '';
        errorTextEmail = '';
      });
      nameFocusNode.requestFocus();
      return;
    }
    if (phoneController.text.isEmpty) {
      setState(() {
        errorTextPhone = 'Vui lòng nhập số điện thoại';
        errorTextAddress = '';
        errorTextEmail = '';
        errorTextName = '';
      });
      phoneFocusNode.requestFocus();
      return;
    }
    if (addressController.text.isEmpty) {
      setState(() {
        errorTextAddress = 'Vui lòng nhập địa chỉ';
        errorTextPhone = '';
        errorTextEmail = '';
        errorTextName = '';
      });
      addressFocusNode.requestFocus();
      return;
    }
    if (emailController.text.isEmpty) {
      setState(() {
        errorTextEmail = 'Vui lòng nhập email';
        errorTextPhone = '';
        // errorTextEmail = '';
        errorTextAddress = '';
        errorTextName = '';
      });
      emailFocusNode.requestFocus();
      return;
    }
  }

  Widget customTextField(
      TextEditingController textEditingController,
      TextInputType textInputType,
      String labelText,
      String hintText,
      Color colorHintText,
      // String? Function(String?)? validator,
      Icon icon,
      Function()? onPressed,
      int maxLength,
      String? error,
      TextInputFormatter textInputFormatter,
      FocusNode focusNode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextFormField(
                focusNode: focusNode,
                inputFormatters: [textInputFormatter],
                maxLength: maxLength,
                controller: textEditingController,
                keyboardType: textInputType,
                style: const TextStyle(
                    color: AppColors.colorLabelText,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
                obscureText: false,
                decoration: InputDecoration(
                  counterText: '',
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
                    borderSide:
                        BorderSide(width: 1, color: AppColors.colorButton),
                  ),
                ),
                // validator: validator,
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
        ),
        error!.isNotEmpty
            ? const SizedBox(
                height: 16,
              )
            : Container(),
        error.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: CustomText(
                    message: error,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.red),
              )
            : Container()
      ],
    );
  }

  // Center avatar() {
  //   return Center(
  //     child: Stack(
  //       children: [
  //         file != null
  //             ? Container(
  //                 width: 100,
  //                 height: 100,
  //                 decoration:
  //                     BoxDecoration(borderRadius: BorderRadius.circular(24),color : Colors.white),
  //                 child: Image.file(
  //                   File(file!.path),
  //                   // width: 40,
  //                   // height: 40,
  //                   fit: BoxFit.contain,
  //                 ))
  //             : Image.asset('assets/images/avatar.png'),
  //         Positioned(
  //           top: 60,
  //           left: 60,
  //           child: Container(
  //             width: 40,
  //             height: 40,
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(24),
  //                 color: AppColors.colorCamera),
  //             child: Center(
  //               child: InkWell(
  //                 onTap: () {
  //                   showModalBottomSheet(
  //                       context: context, builder: (builder) => bottomSheet());
  //                 },
  //                 child: SvgPicture.asset(
  //                   'assets/icons/camera.svg',
  //                   width: 22,
  //                   height: 18,
  //                   fit: BoxFit.none,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Center avatar() {
    return Center(
      child: Stack(
        children: [
          file != null
              ? Container(
                  width: 100, 
                  height: 100, 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                    image: DecorationImage(
                      image: FileImage(File(file!.path)),
                      fit:
                          BoxFit.cover, 
                    ),
                  ),
                )
              : Image.asset('assets/images/avatar.png',width: 100,height: 100,),
          Positioned(
            top: 60,
            left: 60,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.colorCamera,
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (builder) => bottomSheet(),
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/icons/camera.svg',
                    width: 22,
                    height: 18,
                    fit: BoxFit.none,
                  ),
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

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        file = pickedFile;
      });
    }
  }
//   void takePhoto(ImageSource source) async {
//   final pickedFile = await _picker.pickImage(source: source);
//   if (pickedFile != null) {
//     // Resize and crop the image to make it square and of the desired size
//     final croppedFile = await ImageCropper.cropImage(
//       sourcePath: pickedFile.path,
//       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
//       compressFormat: ImageCompressFormat.jpg,
//       androidUiSettings: AndroidUiSettings(
//         toolbarTitle: 'Crop Image',
//         toolbarColor: Colors.deepOrange,
//         toolbarWidgetColor: Colors.white,
//         initAspectRatio: CropAspectRatioPreset.original,
//         lockAspectRatio: true,
//       ),
//       iosUiSettings: IOSUiSettings(
//         minimumAspectRatio: 1.0,
//       ),
//     );
//     if (croppedFile != null) {
//       setState(() {
//         file = croppedFile;
//       });
//     }
//   }
// }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            'Choose Your Photo',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  takePhoto(ImageSource.camera);
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.colorButton),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined,
                            color: AppColors.neutralWhite),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                            message: 'Camera',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.neutralWhite),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  takePhoto(ImageSource.gallery);
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.colorButton),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image, color: AppColors.neutralWhite),
                        SizedBox(
                          width: 5,
                        ),
                        CustomText(
                            message: 'Gallery',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.neutralWhite),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
