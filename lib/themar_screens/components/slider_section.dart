import 'package:api/core/designs/app_images.dart';
import 'package:api/models/sliders_models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../core/logic/dio_helper.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
  int currentIndex = 0;
  bool isLoading = true;
  late SliderData model;
  late CustomResponse response;

  Future<void> getData() async {
    response = await DioHelper.getData(url: "sliders");
    if (response.isSuccess) {
      model = SliderData.fromJson(response.data);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(height: 218,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (!response.isSuccess) {
      return SizedBox(height: 218,
        child: Column(
          children: [
            Center(
              child: Text(
                "${response.message ?? "failed try again"}",
                style: TextStyle(color: Colors.red),
              ),
            ),
            FilledButton(
              onPressed: () => getData(),
              child: Text("اعادة المحاولة"),
            )
          ],
        ),
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
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
                itemCount: model.list.length,
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  autoPlayInterval: Duration(seconds: 3),
                  onPageChanged: (index, reason) {
                    currentIndex = index;
                    setState(() {});
                  },
                ),
                itemBuilder: (context, index, realIndex) => AppImages(
                  model.list[index].image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (index) => Padding(
                padding: EdgeInsetsDirectional.only(end: index != 4 ? 8 : 0),
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Color(0xff16A124)
                      .withOpacity(index == currentIndex ? 1 : .10),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
