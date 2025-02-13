import 'package:api/themar_screens/components/category_section/cubit.dart';
import 'package:api/themar_screens/components/category_section/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/designs/app_images.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  late CategoriesCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
    //cubit.getData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return SizedBox(
            height: 128,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CategoriesErrorState) {
          return SizedBox(
            height: 128,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "${state.message}",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                FilledButton(
                  onPressed: () => cubit.getData(),
                  child: Text("اعادة المحاولة"),
                )
              ],
            ),
          );
        } else if (state is CategoriesSuccessState) {
          return SizedBox(
            height: 128,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "الاقسام",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) => SizedBox(
                      width: 45,
                    ),
                    itemCount: state.list.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Expanded(
                          child: AppImages(
                            state.list[index].image,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          "${state.list[index].name}",
                          style: TextStyle(
                              fontSize: 12,
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
        }
        return SizedBox.shrink();
      },
    );
  }
}
