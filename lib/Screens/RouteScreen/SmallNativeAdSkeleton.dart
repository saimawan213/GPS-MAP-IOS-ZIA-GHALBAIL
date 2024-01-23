import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mapsandnavigationflutter/Screens/RouteScreen/NativeAdSkeleton.dart';
import 'package:shimmer/shimmer.dart';

class SmallNativeAdSkeleton extends StatelessWidget {
  const SmallNativeAdSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: Padding(
        padding: EdgeInsets.only(top: 11, left: 8, right: 8, bottom: 12),
        child: Shimmer.fromColors(
          baseColor: Colors.black.withOpacity(0.05),
          highlightColor: Colors.white.withOpacity(0.2),
          period: Duration(milliseconds: 1500),

          //  enabled: true,
          enabled: false,

          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Skeleton(height: 90, width: 100),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 7),
                        const Skeleton(
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(height: 4,width: 5,),

                        Row(
                          children: [
                            const Skeleton(width: 40, height: 30),
                            const SizedBox(height: 4, width: 6,),

                            Column(
                              children: [
                                Skeleton(width:150, height: 10),
                                const SizedBox(height: 4),

                                Row(
                                  children: [
                                    const Skeleton(width: 50, height: 10),
                                    const Skeleton(width: 50, height: 10),
                                  ],
                                ),
                              ],
                            ),

                          ],
                        ),
                        const SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only( right: 10),
                          child: Skeleton(
                              height: 30,
                              width: Get.width),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
