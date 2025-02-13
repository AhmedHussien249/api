import 'package:api/themar_screens/components/products/models.dart';
import 'package:api/themar_screens/components/products/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/designs/app_images.dart';
import 'cubit.dart';

part 'items_products.dart';

class ProductsSection extends StatefulWidget {
  const ProductsSection({super.key});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  late ProductsCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductsSuccessState) {
            return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 198 / 300,
              ),
              itemBuilder: (context, index) => _Item(model: state.list[index]),
              itemCount: state.list.length,
            );
          } else {
            return Center(
              child: Text("error"),
            );
          }
        });
  }
}
