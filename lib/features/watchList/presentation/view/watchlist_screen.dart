import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/features/watchList/presentation/cubit/watchlist_cubit.dart';
import 'package:movies_app/features/watchList/presentation/cubit/watchlist_state.dart';
import 'package:movies_app/support/app_colors.dart';
import 'package:movies_app/support/app_images.dart';
import 'package:movies_app/support/resources/api_info/api_consts.dart';
import 'package:movies_app/support/routes_manager/routes.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Watchlist',
          style: TextStyle(color: AppColors.yellowColor),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WatchlistLoaded) {
            if (state.items.isEmpty) {
              return Center(
                  child: Image.asset(
                AppImages.emptyData,
                width: 100.h,
                fit: BoxFit.contain,
              ));
            }
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      Routes.movieDetails,
                      arguments: state.items[index].id),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    leading: Image.network(
                      ApiConsts.imageBaseUrl +
                          ApiConsts.imagesSize +
                          state.items[index].posterUrl,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                          color: AppColors.whiteColor, fontSize: 14.sp),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: AppColors.redColor,
                      ),
                      onPressed: () {
                        context.read<WatchlistCubit>().removeItem(item.id);
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is WatchlistError) {
            return Center(child: Text(state.message));
          }
          return const Center(
              child: Text('Start adding items to your watchlist!'));
        },
      ),
    );
  }
}
