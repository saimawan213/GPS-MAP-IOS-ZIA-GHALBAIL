import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NativeAdSkeleton extends StatelessWidget {
  const NativeAdSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(top: 20.0),
      child: Padding(
        padding: EdgeInsets.only(top: 11, left: 8, right: 8, bottom: 10),
        child: Shimmer.fromColors(
          baseColor: Colors.black.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.2),
          period: Duration(milliseconds: 1500),
          enabled: true,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(height: 70, width: 70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        Skeleton(width: Get.width),
                        const SizedBox(height: 5),
                        const Skeleton(width: 80),
                        const SizedBox(height: 4),
                        const Skeleton(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Expanded(child: Skeleton(width: Get.width)),
              SizedBox(height: 6),
              Skeleton(width: Get.width, height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashNativeAdSkeleton extends StatelessWidget {
  const SplashNativeAdSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(top: 20.0),
      child: Padding(
        padding: EdgeInsets.only(top: 11, left: 20, right: 20, bottom: 20),
        child: Shimmer.fromColors(
          baseColor: Colors.white10.withOpacity(0.25),
          highlightColor: Colors.white.withOpacity(0.2),
          period: Duration(milliseconds: 1500),
          enabled: true,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(height: 70, width: 80),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        Skeleton(width: Get.width),
                        const SizedBox(height: 5),
                        const Skeleton(width: 80),
                        const SizedBox(height: 4),
                        const Skeleton(),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Expanded(child: Skeleton(width: Get.width)),
              SizedBox(height: 6),
              Skeleton(width: Get.width, height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerAdSkeleton extends StatelessWidget {
  const BannerAdSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffdff0df),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Shimmer.fromColors(
          baseColor: Colors.black.withOpacity(0.05),
          highlightColor: Colors.white.withOpacity(0.2),
          period: Duration(milliseconds: 1500),
          enabled: true,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Skeleton(
                    width: 55,
                    height: 45,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      children: [
                        Skeleton(),
                        SizedBox(height: 5),
                        Skeleton(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }
}
