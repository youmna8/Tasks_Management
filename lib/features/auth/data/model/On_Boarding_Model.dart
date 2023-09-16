
import 'package:first_app/core/utiles/app_assets.dart';
import 'package:first_app/core/utiles/app_srtings.dart';

class OnBoardingModel {
  final String img;
  final String title;
  final String subTitle;

  OnBoardingModel({
    required this.img,
    required this.title,
    required this.subTitle,
  });
  static List<OnBoardingModel> OnBoardingScreens = [
    OnBoardingModel(img: AppAsset.on1,title: AppString.onBoardingTitleOne,subTitle: AppString.subTitleOne),
    OnBoardingModel(img: AppAsset.on2,title: AppString.onBoardingTitleTwo,subTitle: AppString.subTitleTwo),
    OnBoardingModel(img: AppAsset.on3,title: AppString.onBoardingTitleThree,subTitle: AppString.subTitleThree),
    

  ];
}
