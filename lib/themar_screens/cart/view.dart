import 'package:api/core/designs/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'bloc.dart';
import 'model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final bloc = GetIt.I.get<CartBloc>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("اجمالى المنتجات"),
                                  Text(
                                    "${state.model.totalBeforeDiscount} ر.س",
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("الخصم"),
                                  Text("${state.model.totalDiscountCart} ر.س"),
                                ],
                              ),
                              Divider(
                                color: Colors.white,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("الاجمالى"),
                                  Text("${state.model.totalAfterDiscount} ر.س"),
                                ],
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.3)),
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
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final ProductModel model;
  final VoidCallback onDeletePress, onUpdate;

  const _Item(
      {super.key,
      required this.model,
      required this.onDeletePress,
      required this.onUpdate});

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
                IconButton(
                    onPressed: () {
                      widget.model.plus();
                      setState(() {});
                      widget.onUpdate();
                    },
                    icon: Icon(Icons.add)),
                Text("${widget.model.amount}"),
                IconButton(
                    onPressed: () {
                      widget.model.minus();
                      setState(() {});
                      widget.onUpdate();
                    },
                    icon: Icon(Icons.remove)),
              ]),
            )
          ],
        )),
        IconButton(onPressed: widget.onDeletePress, icon: Icon(Icons.delete)),
      ],
    );
  }
}
