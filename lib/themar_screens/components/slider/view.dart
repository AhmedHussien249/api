import 'package:api/core/designs/app_images.dart';
import 'package:api/themar_screens/components/slider/cubit.dart';
import 'package:api/themar_screens/components/slider/states.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  late SliderCubit cubit;

  @override
  void initState() {
    cubit = BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit, SliderStates>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SliderLoadingStates) {
            return const SizedBox(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              height: 218,
            );
          } else if (state is SliderErrorStates) {
            return SizedBox(
              height: 218,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "${state.message}",
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
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
              height: 232,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: CarouselSlider.builder(
                        itemCount: state.list.length,
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1,
                          autoPlayInterval: const Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            cubit.changeCurrentIndex(index);
                            print("BlocBuilder");
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
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding:
                            EdgeInsetsDirectional.only(end: index != 4 ? 8 : 0),
                        child: CircleAvatar(
                          radius: 6,
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
            return const SizedBox.shrink();
          }
        });
  }
}
