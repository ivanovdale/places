import 'package:flutter/material.dart';
import 'package:places/helpers/app_colors.dart';
import 'package:places/helpers/app_strings.dart';
import 'package:places/helpers/app_typography.dart';

class SightDetails extends StatelessWidget {
  const SightDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 360,
            child: Stack(
              children: [
                ColoredBox(
                  color: AppColors.lightBlueShade800,
                ),
                Positioned(
                  left: 16,
                  top: 36,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    width: 32,
                    height: 32,
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 15.0,
                      color: AppColors.martinique,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 336,
            child: Container(
              color: AppColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 24.0,
                        left: 16.0,
                      ),
                      child: Text(
                        'Пряности и радости',
                        style: AppTypography.roboto24Regular
                            .copyWith(color: AppColors.oxfordBlue),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2.0,
                          left: 16.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ресторан',
                            style: AppTypography.roboto14Regular
                                .copyWith(color: AppColors.oxfordBlue),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 2.0,
                          left: 16.0,
                        ),
                        child: Text(
                          'закрыто до 09:00',
                          style: AppTypography.roboto14Regular.copyWith(
                            color: AppColors.waterloo,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Text(
                      'Пряный вкус радостной жизни вместе с шеф-поваром Изо Дзандзава, благодаря которой у гостей ресторана есть возможность выбирать из двух направлений: европейского и восточного',
                      style: AppTypography.roboto14Regular.copyWith(
                        color: AppColors.oxfordBlue,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.fruitSalad,
                      ),
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 20,
                            height: 22,
                            color: AppColors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            AppStrings.buildRouteText,
                            style: AppTypography.roboto14Regular.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 24,
                      left: 16,
                      right: 16,
                      bottom: 19,
                    ),
                    child: Divider(
                      thickness: 0.8,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 22,
                              height: 19,
                              color: AppColors.waterlooInactive,
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            Text(
                              AppStrings.planText,
                              style: AppTypography.roboto14Regular.copyWith(
                                color: AppColors.waterlooInactive,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 18,
                              color: AppColors.oxfordBlue,
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            Text(
                              AppStrings.toFavorites,
                              style: AppTypography.roboto14Regular.copyWith(
                                color: AppColors.oxfordBlue,
                                fontWeight: FontWeight.w400,
                              ),
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
        ],
      ),
    );
  }
}
