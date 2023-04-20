import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:machine_care/constants/constants.dart';
import 'package:machine_care/ui/ui.dart';
import 'package:machine_care/utils/utils.dart';

class WidgetImageNetwork extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double? radius;
  final BorderRadius? borderRadius;
  final PlaceHolderType? placeHolderType;

  const WidgetImageNetwork(
      {Key? key,
        required this.url,
        this.width,
        this.height,
        this.fit,
        this.radius,
        this.borderRadius,
        this.placeHolderType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? cacheWidthTemp;
    int? cacheHeightTemp;

      if (height != double.infinity && height != double.maxFinite) {
        cacheHeightTemp =
        height != null ? (height! * MediaQuery.of(context).devicePixelRatio).round() : null;
      }
      if (width != double.infinity && width != double.maxFinite) {
        cacheWidthTemp =
        width != null ? (width! * MediaQuery.of(context).devicePixelRatio).round() : null;
      }

    Widget avatar;
    if (File(url).existsSync()) {
      avatar = Image.file(File(url),
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          cacheHeight: cacheHeightTemp,
          cacheWidth: cacheWidthTemp);
    } else {
      avatar = CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        memCacheWidth: cacheWidthTemp,
        memCacheHeight: cacheHeightTemp,
        cacheKey: AppUtils.getKeyFromUrl(url),
        fit: fit ?? BoxFit.contain,
        placeholder: (context, url) => EmptyImage(
            width: width,
            height: height,
            radius: radius,
            borderRadius: borderRadius,
            placeHolderType: placeHolderType),
        errorWidget: (context, url, error) => EmptyImage(
            width: width,
            height: height,
            radius: radius,
            borderRadius: borderRadius,
            placeHolderType: placeHolderType),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
      child: avatar,
    );
  }
}

class EmptyImage extends StatelessWidget {
  final double? width;
  final double? height;
  final double? radius;
  final BorderRadius? borderRadius;
  final PlaceHolderType? placeHolderType;

  const EmptyImage(
      {Key? key, this.width, this.height, this.radius, this.borderRadius, this.placeHolderType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = const SizedBox();
    switch (placeHolderType) {
      case PlaceHolderType.avatar:
        child = SvgPicture.asset(
          AppImages.icNoAvatar,
          height: height,
          width: width,
          fit: BoxFit.cover,
        );
        break;
      case PlaceHolderType.typeBanner:
        child = WidgetImageAsset(
          url: AppImages.bannerDefault,
          height: height,
          width: width,
          fit: BoxFit.contain,
        );
        break;
      case PlaceHolderType.typeNothing:
        child = const SizedBox();
        break;

      default:
        child = WidgetImageAsset(
          url: AppImages.icNoImage,
          height: height,
          width: width,
          fit: BoxFit.contain,
        );
        break;
    }
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
      child: child,
    );
  }
}

class CustomCacheManager {
  static getCacheManager(String url) {
    int duration = 30;
    if (url.startsWith("https://www.ikara.co/avatar")) {
      duration = 1;
    } else {
      duration = 30;
    }
    return CacheManager(Config(
      AppUtils.getKeyFromUrl(url),
      stalePeriod: Duration(days: duration),
      fileService: HttpFileService(),
    ));
  }
}

enum PlaceHolderType {
  typeNothing,
  typeBanner,
  typeBannerPlaySong,
  typeDefault,
  avatar,
  playRecording,
  recording,
  family,
  singleSong,
  duetSong,
  inviteJudges,
  coverBackground,
  typeEvent
}
