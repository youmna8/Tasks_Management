import 'package:first_app/core/Commons/Commons.dart';
import 'package:first_app/core/Services/Service_Locator.dart';
import 'package:first_app/core/database/Cache/Cache_Helper.dart';

import 'package:first_app/core/utiles/app_colors.dart';
import 'package:first_app/core/utiles/app_srtings.dart';
import 'package:first_app/core/widgets/Text_Button.dart';
import 'package:first_app/features/auth/data/model/On_Boarding_Model.dart';
import 'package:first_app/features/task/presentation/screens/Home_Screen/Home_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/widgets/Elevated_Button.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.background,
            body: Padding(
                padding: const EdgeInsets.all(24),
                child: PageView.builder(
                    controller: controller,
                    itemCount: OnBoardingModel.OnBoardingScreens.length,
                    itemBuilder: ((context, index) {
                      return Column(
                        children: [
                          index != 2
                              ? Align(
                                  alignment: Alignment.topLeft,
                                  child: MyTextButton(
                                    text: AppString.skip,
                                    onPressed: () {
                                      controller.jumpToPage(2);
                                    },
                                  ))
                              : const SizedBox(
                                  height: 50,
                                ),
                          const SizedBox(
                            height: 16,
                          ),
                          Image.asset(
                              OnBoardingModel.OnBoardingScreens[index].img),
                          const SizedBox(
                            height: 35,
                          ),
                          SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            effect: ExpandingDotsEffect(
                                activeDotColor: AppColors.primary,
                                dotHeight: 10,
                                spacing: 8),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(OnBoardingModel.OnBoardingScreens[index].title,
                              style: Theme.of(context).textTheme.displayLarge),
                          const SizedBox(
                            height: 42,
                          ),
                          Text(
                              OnBoardingModel.OnBoardingScreens[index].subTitle,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.displayMedium),
                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            children: [
                              index != 0
                                  ? MyTextButton(
                                      text: AppString.back,
                                      onPressed: () {
                                        controller.previousPage(
                                            duration: const Duration(
                                                microseconds: 1000),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn);
                                      },
                                    )
                                  : Container(),
                              const Spacer(),
                              index != 2
                                  ? MyElevatedButton(
                                      text: AppString.next,
                                      onPressed: () {
                                        controller.nextPage(
                                            duration: const Duration(
                                                microseconds: 1000),
                                            curve:
                                                Curves.fastLinearToSlowEaseIn);
                                      },
                                    )

                                
                                  : MyElevatedButton(
                                      text: AppString.getStarted,
                                      onPressed: () async {
                                        await sl<CacheHelper>()
                                            .saveData(
                                                key: AppString.onboarding,
                                                value: true)
                                            .then((value) {
                                          print('onboarding is visited');
                                          navigate(
                                              context: context,
                                              screen: HomeScreen());
                                        });
                                        
                                      },
                                    )
                            
                            ],
                          )
                        ],
                      );
                    })))));
  }
}
