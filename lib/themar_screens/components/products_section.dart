import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/designs/app_images.dart';
import '../../models/products_models.dart';
part 'items_products.dart';
class ProductsSection extends StatefulWidget {
  const ProductsSection({super.key});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  late bool isLoading = true;
  late ProductsData model;

  Future<void> getData() async {
    final response =
    await Dio().get("https://thimar.amr.aait-d.com/api/products");
    model = ProductsData.fromJson(response.data);
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 198 / 300,
      ),
      itemBuilder: (context, index) => _Item(model: model.list[index]),
      itemCount: model.list.length,
    );
  }
}