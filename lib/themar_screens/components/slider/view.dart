import 'package:api/core/designs/app_images.dart';
import 'package:api/themar_screens/components/slider/cubit.dart';
import 'package:api/themar_screens/components/slider/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

part 'loading.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  final cubit = GetIt.instance<SliderCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderStates>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SliderErrorStates) {
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
          } else if (state is SliderSuccessStates) {
            return Container(
              margin:
                   EdgeInsets.symmetric(horizontal: 16.h).copyWith(top: 16.w),
              height: 232.h,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: CarouselSlider.builder(
                        itemCount: state.list.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1,
                          autoPlayInterval: const Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            cubit.changeCurrentIndex(index);
                            //print("BlocBuilder");
                          },
                        ),
                        itemBuilder: (context, index, realIndex) => AppImages(
                          state.list[index].image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding:
                            EdgeInsetsDirectional.only(end: index != 4.w ? 8.w : 0),
                        child: CircleAvatar(
                          radius: 6.r,
                          backgroundColor: const Color(0xff16A124).withOpacity(
                              index == state.currentIndex ? 1 : .10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const _Loading();
          }
        });
  }
}
