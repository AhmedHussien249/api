import 'package:api/main.dart';
import 'package:api/themar_screens/components/products/models.dart';
import 'package:api/themar_screens/components/products/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/designs/app_images.dart';
import 'cubit.dart';

part 'items_products.dart';
part 'loading.dart';

class ProductsSection extends StatefulWidget {
  const ProductsSection({super.key});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  final cubit = GetIt.instance<ProductsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          if (state is ProductsErrorState) {
            return SizedBox(
              height: 218.h,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  FilledButton(
                    onPressed: () => cubit.getData(),
                    child: const Text("اعادة المحاولة"),
                  )
                ],
              ),
            );
          } else if (state is ProductsSuccessState) {
            return GridView.builder(
              padding:  EdgeInsets.all(16.h.w),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 20,
                childAspectRatio: 189 / 300,
              ),
              itemBuilder: (context, index) => _Item(model: state.list[index]),
              itemCount: state.list.length,
            );
          } else {
            return const _Loading();
          }
        });
  }
}
