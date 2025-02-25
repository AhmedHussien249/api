import 'package:api/main.dart';
import 'package:api/themar_screens/components/category_section/cubit.dart';
import 'package:api/themar_screens/components/category_section/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/designs/app_images.dart';

part 'loading.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final cubit = GetIt.instance<CategoriesCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is CategoriesErrorState) {
          return SizedBox(
            height: 128.h,
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
        } else if (state is CategoriesSuccessState) {
          return SizedBox(
            height: 128.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  child: Text(
                    "الاقسام",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                 SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.separated(
                    padding:  EdgeInsets.symmetric(horizontal: 16.h),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>  SizedBox(
                      width: 45.w,
                    ),
                    itemCount: state.list.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Expanded(
                          child: AppImages(
                            state.list[index].image,
                            height: 70.h,
                            width: 70.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          state.list[index].name,
                          style:  TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const _Loading();
        }
      },
    );
  }
}
