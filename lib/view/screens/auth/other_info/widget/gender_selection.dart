import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/color_resources.dart';
import 'package:six_cash/util/dimensions.dart';
import 'package:six_cash/util/images.dart';
import 'package:six_cash/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_gender_card.dart';
class GenderSelectionSection extends StatelessWidget {
  const GenderSelectionSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller){
      return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: Dimensions.PADDING_SIZE_EXTRA_LARGE,
        left: Dimensions.PADDING_SIZE_LARGE,
        bottom: Dimensions.PADDING_SIZE_DEFAULT,
      ),
    
      decoration: BoxDecoration(
          color: ColorResources.getWhiteColor(),
          boxShadow: [
            BoxShadow(
              color: ColorResources.getShadowColor().withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 3),
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'select_your_gender'.tr,
            style: rubikMedium.copyWith(
              color: ColorResources.getBlackColor(),
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            ),
          ),
          const SizedBox(
            height: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          Wrap(
            children: [
              CustomGenderCard(
                icon: Images.male,
                text: 'male'.tr,
                color: controller.gender == 'Male' ? ColorResources.getSecondaryHeaderColor():ColorResources.genderDefaultColor.withOpacity(0.5),
                onTap: (){
                  controller.setGender('Male');
                },
              ),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
               CustomGenderCard(
                icon: Images.female,
                text: 'female'.tr,
                color: controller.gender == 'Female' ? ColorResources.getSecondaryHeaderColor():ColorResources.genderDefaultColor.withOpacity(0.5),
                onTap: (){
                  controller.setGender('Female');
                },
              ),
              const SizedBox(width: Dimensions.PADDING_SIZE_SMALL,),
               CustomGenderCard(
                icon: Images.other,
                text: 'other'.tr,
                color: controller.gender == 'Other' ? ColorResources.getSecondaryHeaderColor():ColorResources.genderDefaultColor.withOpacity(0.5),
                onTap: (){
                  controller.setGender('Other');
                },
              ),
            ],
          )
        ],
      ),
    );
    });
  }
}