import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:temp_house/app/extensions.dart';
import 'package:temp_house/domain/models/domain.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/common/widget/main_image.dart';
import 'package:temp_house/presentation/offers_screen/viewmodel/offers_viewmodel.dart';
import 'package:temp_house/presentation/resources/assets_manager.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';
import 'package:temp_house/presentation/resources/styles_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class OffersBody extends StatelessWidget {
  const OffersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.infinity,
      child: BlocBuilder<OffersViewModel, BaseStates>(
        builder: (context, state) {
          OffersViewModel viewModel = OffersViewModel.get(context);
          return ListView.separated(
            padding: const EdgeInsets.all(AppPadding.p20),
            itemCount: viewModel.getOffers.length,
            itemBuilder: (context, index) {
              return FutureBuilder<OfferModel>(
                future: viewModel.getOffers[index],
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    OfferModel offer = snapshot.data!;
                    return OfferItem(
                      viewModel: viewModel,
                      offer: offer,
                    );
                  } else if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.all(AppPadding.p40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            LottieAssets.error,
                            repeat: false,
                            width: context.width() * .4,
                          ),
                          const SizedBox(height: AppSize.s10),
                          Text(
                            'Error: ${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: getSemiBoldStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.f16,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(
                      child: Lottie.asset(
                        LottieAssets.loading,
                        width: context.width() * .3,
                      ),
                    );
                  }
                },
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: AppSize.s20);
            },
          );
        },
      ),
    );
  }
}

class OfferItem extends StatelessWidget {
  const OfferItem({
    super.key,
    required this.viewModel,
    required this.offer,
  });

  final OffersViewModel viewModel;
  final OfferModel offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(AppSize.s15),
      ),
      child: Row(
        children: [
          MainImage(
            imageUrl: offer.user.imageUrl,
            width: AppSize.s50,
          ),
          const SizedBox(width: AppSize.s10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.user.username,
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.f14,
                  ),
                ),
                Text(
                  offer.home.title,
                  style: getBoldStyle(
                    color: ColorManager.black.withOpacity(.5),
                    fontSize: FontSize.f12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSize.s5),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${offer.price}\$',
                    style: getRegularStyle(
                      color: offer.price > offer.home.price
                          ? Colors.green
                          : ColorManager.black,
                      fontSize: FontSize.f16,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: AppSize.s10),
                SizedBox.square(
                  dimension: context.width() * .11,
                  child: IconButton(
                    onPressed: () {
                      viewModel.declineOffer(offerId: offer.id);
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: ColorManager.transparent,
                      foregroundColor: Colors.red,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.red),
                        borderRadius:
                            BorderRadius.circular(context.width() * .11),
                      ),
                    ),
                    icon: Icon(
                      Icons.close_rounded,
                      size: context.width() * .07,
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s10),
                SizedBox.square(
                  dimension: context.width() * .11,
                  child: IconButton(
                    onPressed: () {
                      viewModel.acceptOffer(
                        offerId: offer.id,
                        userId: offer.user.uid,
                        homeId: offer.home.homeId,
                      );
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: ColorManager.transparent,
                      foregroundColor: Colors.green,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.green),
                        borderRadius:
                            BorderRadius.circular(context.width() * .11 / 2),
                      ),
                    ),
                    icon: Icon(
                      Icons.check_rounded,
                      size: context.width() * .07,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
