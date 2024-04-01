import 'package:cydeva_lua_application/common/bases/custom_button.dart';
import 'package:cydeva_lua_application/common/colors/colors.dart';
import 'package:cydeva_lua_application/models/favorite_model.dart';
import 'package:cydeva_lua_application/screens/my_account/my_account_bloc.dart';
import 'package:cydeva_lua_application/screens/user_screen/user_screen.dart';
import 'package:cydeva_lua_application/screens/wishlist_screen/bloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late WishlistBloc wishlistBloc;
  String title = 'Chọn chủ đề bạn yêu thích';
  List<FavoriteCategory> listWishlist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wishlistBloc = context.read<WishlistBloc>();
    wishlistBloc.add(ListFavoriteInitital());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<WishlistBloc, WishlistState>(
        listener: (context, state) {
          if (state.status == WishlistStatus.submittedSuccess) {
            print('Ok');

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => BlocProvider(
                          create: (context) => MyAccountBloc(),
                          child: UserScreen(),
                        )));
          }
          if (state.status == WishlistStatus.failed) {
            showDialog(
                context: context,
                builder: (builder) => AlertDialog(
                      title: Text(
                        'Failed',
                      ),
                      content: Text(state.message!),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('OK'))
                      ],
                    ));
            print('Failed');
          }
        },
        bloc: wishlistBloc,
        builder: (context, state) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: (state.status == WishlistStatus.loading)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 40),
                      Wrap(
                        runSpacing: 16,
                        spacing: 16,
                        children:
                            List.generate(state.listData!.length, (index) {
                          // final isSelected = selectedListInex.contains(index);
                          return GestureDetector(
                            onTap: () {
                              wishlistBloc.add(ListFavoriteChanged(
                                  listData: state.listData![index]));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: state.listSelectedData!
                                        .contains(state.listData![index])
                                    ? AppColors.colorBorderWishList
                                    : Colors.white,
                                border: Border.all(
                                    color: AppColors.colorBorderWishList),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Chip(
                                backgroundColor: state.listSelectedData!
                                        .contains(state.listData![index])
                                    ? AppColors.colorBorderWishList
                                    : Colors.white,
                                label: Text(
                                  state.listData![index].title ?? '',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: state.listSelectedData!
                                            .contains(state.listData![index])
                                        ? Colors.white
                                        : AppColors.colorBorderWishList,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 400,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                              buttonName: 'Bỏ qua',
                              backgroundColorButton: AppColors.neutralWhite,
                              borderColor: AppColors.colorBorderWishList,
                              textColor: AppColors.colorBorderWishList,
                              function: () {},
                              height: 50,
                              width: 180,
                              fontSize: 16,
                              colorShadow: Colors.transparent),
                          CustomButton(
                              buttonName: 'Xác nhận',
                              backgroundColorButton:
                                  AppColors.colorBorderWishList,
                              borderColor: AppColors.colorBorderWishList,
                              textColor: AppColors.neutralWhite,
                              function: () {
                                wishlistBloc.add(SubmitFavorite(
                                    listData: state.listSelectedData));
                              },
                              height: 50,
                              width: 180,
                              fontSize: 16,
                              colorShadow: Colors.transparent)
                        ],
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
