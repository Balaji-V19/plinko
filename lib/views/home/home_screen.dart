import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:plinko/constants/app_colors.dart';
import 'package:plinko/constants/app_textstyle.dart';
import 'package:plinko/notifiers/player_notifier.dart';
import 'package:provider/provider.dart';
import 'package:simple_waveform_progressbar/simple_waveform_progressbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Consumer<PlayerNotifier>(builder: (context, playerNotifier, _)
    {
      return FutureBuilder<Duration?>(
          future: playerNotifier.futureDuration,
          builder: (context, snapshot)
      {
        if (snapshot.hasError ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Music",
                      style: AppTextStyles.text14w500,
                    ),
                    Text(
                      "237 Online",
                      style: AppTextStyles.text14w500,
                    )
                  ],
                ),
              ),
              Center(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: ScreenUtil().screenWidth - 32.w,
                    decoration: BoxDecoration(
                        color: AppColors.pink,
                        borderRadius: BorderRadius.circular(12.r)),
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Center(
                        child: Text(
                          "Back to Plinko",
                          style: AppTextStyles.text14w500,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tru Tones - Dancing(feat. R)",
                      style: AppTextStyles.text20w600,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "Seth Pantalony",
                      style: AppTextStyles.text12w300
                          .copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  width: ScreenUtil().screenWidth - 32.w,
                  height: ScreenUtil().screenHeight * 0.5,
                  decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(16.r)),
                  child: StreamBuilder<Duration>(
                    stream: playerNotifier.audioPlayer.positionStream,
                    builder: (context, ss) {
                      if (ss.hasData && snapshot.data != null) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: ScreenUtil().screenWidth - 50.w,
                              height: ScreenUtil().screenHeight * 0.4,
                              child: WaveformProgressbar(
                                color: Colors.grey,
                                progressColor: AppColors.primary,
                                progress:
                                ss.data!.inMicroseconds / snapshot.data!.inMicroseconds,
                                onTap: (progress) {
                                  var tt = progress;
                                },
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            topLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(5.r),
                            topRight: Radius.circular(5.r)),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: IconButton(
                        icon:
                        const Icon(Icons.skip_previous, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: IconButton(
                        icon: Icon(
                          playerNotifier.isPlaying ? Icons.pause : Icons
                              .play_arrow,
                          color: AppColors.white,
                        ),
                        onPressed: playerNotifier.togglePlayPause,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30.r),
                          topRight: Radius.circular(30.r),
                          bottomLeft: Radius.circular(5.r),
                          topLeft: Radius.circular(5.r),
                        ),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: IconButton(
                        icon: const Icon(Icons.skip_next, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Icon(
                      Icons.volume_down,
                      color: AppColors.white,
                    ),
                    SizedBox(
                      width: ScreenUtil().screenWidth * 0.6,
                      child: Slider.adaptive(
                        value: playerNotifier.audioVolume,
                        onChanged: (updatedValue) {
                          playerNotifier.updateVolume(updatedValue);
                        },
                        min: 0,
                        max: 1,
                      ),
                    ),
                    const Icon(
                      Icons.volume_up,
                      color: AppColors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      });
    }),
    );
  }
}
