import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:machine_care/constants/constants.dart';
import '../ui.dart';

class WidgetSliderBanner extends StatelessWidget {
  final double? padding;
  final double? radius;

  const WidgetSliderBanner({Key? key, this.padding, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 138;
    return Container(
      margin: const EdgeInsets.only(bottom: 0, top: 38 ),
      height: height,
      padding: EdgeInsets.symmetric(horizontal: padding ?? 0),
      child:  DataFilter.banners.isEmpty
          ? WidgetImageAsset(
        url: AppImages.bannerDefault,
        width: Get.width,
        fit: BoxFit.contain,
        height: height,
      )
          : CarouselSlider(
        items: List.generate(
            DataFilter.banners.length,
                (index) => GestureDetector(
                onTap: () {},
                child: WidgetImageNetwork(
                    width: Get.width ,
                    radius: radius ?? 8,
                    height: height,
                    url: DataFilter.banners[index].url ?? "",
                    placeHolderType: PlaceHolderType.typeBanner
                ))),
        options: CarouselOptions(
          height: height,
          aspectRatio: 16 / 9,
          viewportFraction: 1,
          initialPage: 0,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          scrollDirection: Axis.horizontal,
        ),
      )
    );
  }
}
