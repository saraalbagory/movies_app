import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/support/app_colors.dart';
import 'package:movies_app/support/resources/api_info/api_consts.dart';

class MovieCard extends StatelessWidget {
  final String impagePath;
  final double height;
  final double width;
  final String movieId;

  const MovieCard(
      {super.key,
      required this.impagePath,
      required this.height,
      required this.width,
      required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              // color: AppColors.transparentBlack,
              borderRadius: BorderRadius.circular(20.h)),
          child: Image.network(
            ApiConsts.imageBaseUrl + ApiConsts.imagesSize + impagePath,
            fit: BoxFit.cover,
            isAntiAlias: true,
            errorBuilder: (context, error, stackTrace) {
              print(ApiConsts.imageBaseUrl + ApiConsts.imagesSize + impagePath);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Failed to load image'),
                  Text(error.toString()),
                ],
              );
            },
          ),
        ),
        Positioned(
          left: 15.h,
          top: 20.h,
          child: Container(
            height: 28.h,
            width: 58.w,
            decoration: BoxDecoration(
                color: AppColors.transparentBlack,
                borderRadius: BorderRadius.circular(7)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "7.7",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                Icon(
                  Icons.star_border_rounded,
                  fill: 1,
                  size: 15.sp,
                  color: AppColors.yellowColor,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
