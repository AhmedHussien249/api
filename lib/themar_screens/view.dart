import 'package:api/themar_screens/components/products/view.dart';
import 'package:api/themar_screens/components/slider/view.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/category_section/view.dart';

class Views extends StatefulWidget {
  const Views({super.key});

  @override
  State<Views> createState() => _ViewsState();
}

class _ViewsState extends State<Views> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text("منتجات"),
          centerTitle: true,
        ),
        body:  SingleChildScrollView(
          child: Column(
            children: [
              SliderSection(),
              SizedBox(
                height: 16,
              ),
              CategorySection(),
              SizedBox(
                height: 16,
              ),
              ProductsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// mvc
// mvp
// mvvm
// mvi
// design architecture

/* state Mangement (statelful - cubit-bloc-provider-getx-redux)
1. separate ui and logic
2. handle code into pieces
3.handle when refresh just refresh the need part
 */
