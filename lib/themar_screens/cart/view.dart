import 'package:api/core/designs/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../update_cart_item/bloc.dart';
import 'bloc.dart';
import 'model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final bloc = GetIt.I.get<CartBloc>();
  final updateBloc = GetIt.I.get<UpdateCartItemBloc>();
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButton(
              items: [
                DropdownMenuItem(
                  value: "en",
                  child: Text("En"),
                ),
                DropdownMenuItem(
                  value: "ar",
                  child: Text("Ar"),
                ),
                DropdownMenuItem(
                  value: "fr",
                  child: Text("Fr"),
                ),
              ],
              onChanged: (value) {
                selectedLanguage = value;
                setState(() {});
                context.setLocale(Locale(selectedLanguage!));
              })
        ],
        title: Text("cart".tr()),
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is CartErrorState) {
            return Center(child: Text(state.message));
          } else if (state is CartSuccessState) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemCount: state.model.list.length,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16.h,
                    ),
                    itemBuilder: (context, index) => _Item(
                      model: state.model.list[index],
                      onDeletePress: () {
                        state.model.list.removeAt(index);
                        setState(() {});
                      },
                      onUpdate: () {
                        setState(() {});
                      },
                      updateBloc: updateBloc,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  // height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: "عندك كوبون؟ ادخل رقم الكوبون"),
                            ),
                          ),
                          SizedBox(width: 8),
                          FilledButton(onPressed: () {}, child: Text("تطبيق"))
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                          child: Text(
                              "جميع الاسعار تشمل قيمة الضريبه المضافه ${state.model.vat}%")),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("اجمالى المنتجات"),
                                Text(
                                  "${state.model.totalBeforeDiscount} ر.س",
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("الخصم"),
                                Text("${state.model.totalDiscountCart} ر.س"),
                              ],
                            ),
                            Divider(
                              color: Colors.white,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("الاجمالى"),
                                Text("${state.model.totalAfterDiscount} ر.س"),
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:
                                Theme.of(context).primaryColor.withOpacity(.3)),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: Text("goToCompleteOrder".trim()),
                      )
                    ],
                  ),
                  width: double.infinity,
                  // color: Colors.red,
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final ProductModel model;
  final UpdateCartItemBloc updateBloc;
  final VoidCallback onDeletePress, onUpdate;

  const _Item(
      {super.key,
      required this.model,
      required this.onDeletePress,
      required this.onUpdate,
      required this.updateBloc});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImages(
          widget.model.image,
          height: 70.h,
          width: 70.w,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.model.title),
            Row(
              children: [
                Text(
                  "${widget.model.price}ر.س",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                SizedBox(width: 4),
                Text(
                  "${widget.model.priceBeforeDiscount}ر.س",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Theme.of(context).primaryColor),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    BorderRadius.circular(16), // Adjust the radius as needed
              ),
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                BlocListener(
                  bloc: widget.updateBloc,
                  listener: (BuildContext context, state) {
                    if (state is UpdateCartItemSuccessState &&
                        state.id == widget.model.id &&
                        state.isAdd) {
                      print("Listener");

                      widget.model.plus();
                      setState(() {});
                      widget.onUpdate();
                    }
                  },
                  child: IconButton(
                      onPressed: () {
                        widget.updateBloc.add(UpdateCartItemEvent(
                            id: widget.model.id,
                            amount: widget.model.amount,
                            isAdd: true));
                      },
                      icon: Icon(Icons.add)),
                ),
                Text("${widget.model.amount}"),
                BlocListener(
                  bloc: widget.updateBloc,
                  listener: (BuildContext context, state) {
                    if (state is UpdateCartItemSuccessState &&
                        state.id == widget.model.id &&
                        !state.isAdd) {
                      print("Listener");
                      widget.model.minus();
                      setState(() {});
                      widget.onUpdate();
                    }
                  },
                  child: IconButton(
                      onPressed: () {
                        ;
                        widget.updateBloc.add(UpdateCartItemEvent(
                          id: widget.model.id,
                          amount: widget.model.amount,
                          isAdd: false,
                        ));
                      },
                      icon: Icon(Icons.remove)),
                ),
              ]),
            )
          ],
        )),
        IconButton(onPressed: widget.onDeletePress, icon: Icon(Icons.delete)),
      ],
    );
  }
}
