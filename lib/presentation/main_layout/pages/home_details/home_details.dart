import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:temp_house/presentation/base/base_states.dart';
import 'package:temp_house/presentation/base/cubit_listener.dart';
import 'package:temp_house/presentation/chat_screen/chat_service/chat_services.dart';
import 'package:temp_house/presentation/chat_screen/view/chat_view.dart';
import 'package:temp_house/presentation/common/widget/cached_image.dart';
import 'package:temp_house/presentation/main_layout/pages/home_details/home_details_viewmodel.dart';
import 'package:temp_house/presentation/resources/font_manager.dart';
import 'package:temp_house/presentation/resources/routes_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/styles_manager.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

import '../../../common/data_intent/data_intent.dart';
import '../../../common/widget/main_app_bar.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/text_styles.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  int _currentIndex = 0;
  ChatServices chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeDetailsViewModel()..start(),
      child: BlocConsumer<HomeDetailsViewModel, BaseStates>(
        listener: (context, state) {
          if (state is ErrorState ||
              state is LoadingState ||
              state is SuccessState) {
            Navigator.pop(context);
          }
          baseListener(context, state);
        },
        builder: (context, state) {
          HomeDetailsViewModel viewModel = HomeDetailsViewModel.get(context);
          final int displayedRating =
              (viewModel.getHome.rate / viewModel.getHome.numberOfRates)
                  .clamp(0, 5)
                  .floor();
          return Scaffold(
            bottomNavigationBar: SizedBox(
              height: AppSize.s80,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: AppSize.s50,
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppMargin.m10, vertical: AppMargin.m8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            ColorManager.blue.withOpacity(.7),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                receiveEmail: viewModel.getHome.ownerName,
                                receiveID: viewModel.getHome.ownerId,
                                chatID: chatServices.getChatRoomID(
                                  DataIntent.getUser().uid,
                                  viewModel.getHome.ownerId,
                                ),
                              ),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          SVGAssets.chat,
                          width: AppSize.s35,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: AppSize.s50,
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppMargin.m10, vertical: AppMargin.m8),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            ColorManager.blue.withOpacity(.7),
                          ),
                        ),
                        onPressed: () {
                          GlobalKey<FormState> formKey = GlobalKey<FormState>();
                          TextEditingController priceController =
                              TextEditingController(
                            text: viewModel.getHome.price.toString(),
                          );
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Choose your price or send with the current price',
                                  style: getBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.f24,
                                  ),
                                ),
                                content: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: priceController,
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return AppStrings
                                                .validationsFieldRequired
                                                .tr();
                                          } else if (int.parse(v) <
                                              viewModel.getHome.price) {
                                            return AppStrings
                                                .validationsLowerPrice
                                                .tr();
                                          }
                                          return null;
                                        },
                                        style: getRegularStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.f16,
                                        ),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s20),
                                            borderSide: const BorderSide(
                                              color: ColorManager.primary,
                                              width: AppSize.s1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s20),
                                            borderSide: const BorderSide(
                                              color: ColorManager.primary,
                                              width: AppSize.s2,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s20),
                                            borderSide: const BorderSide(
                                              color: ColorManager.error,
                                              width: AppSize.s1,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                AppSize.s20),
                                            borderSide: const BorderSide(
                                              color: ColorManager.error,
                                              width: AppSize.s2,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: AppSize.s20),
                                      SizedBox(
                                        width: AppSize.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (formKey.currentState!.validate()) {
                                              viewModel.sendOffer(
                                                int.parse(priceController.text.trim()),
                                              );
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorManager.primary,
                                            foregroundColor: ColorManager.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(AppSize.s15),
                                            ),
                                          ),
                                          child: Text(
                                            'Send Offer',
                                            style: getBoldStyle(
                                              color: ColorManager.white,
                                              fontSize: FontSize.f20,
                                            ),
                                          ),
                                        ),

                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          SVGAssets.cart,
                          width: AppSize.s28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            appBar: buildMainAppBar(
              context,
              Text(
                viewModel.getHome.title,
                style: AppTextStyles.notificationsScreenTitleTextStyle(context),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: AppSize.s200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      scrollPhysics: viewModel.getHome.imageUrls.length > 1
                          ? null
                          : const NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: viewModel.getHome.imageUrls.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                                horizontal: AppMargin.m5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              child: CachedImage(
                                imageUrl: imageUrl,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: AppSize.s10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      viewModel.getHome.imageUrls.length,
                      (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentIndex == index ? 12.0 : 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.grey
                                : Colors.grey.withOpacity(0.5),
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Text(
                        "${_currentIndex + 1}/${viewModel.getHome.imageUrls.length}",
                        style: AppTextStyles.smallTitleTextStyle(context),
                      ),
                      const SizedBox(
                        width: AppSize.s16,
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          ColorManager.primary.withOpacity(.1),
                          ColorManager.blue.withOpacity(.2),
                          ColorManager.blue.withOpacity(.4),
                        ])),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${AppStrings.price.tr()} : ',
                                  style: AppTextStyles
                                      .homeDetailsDescriptionTextStyle(context),
                                ),
                                TextSpan(
                                  text:
                                      '${viewModel.getHome.price} ${AppStrings.priceHome.tr()}${viewModel.getHome.rentPeriod}',
                                  style: AppTextStyles
                                      .homeDetailsDescriptionContactTextStyle(
                                          context),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSize.s10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${AppStrings.area.tr()} : ',
                                  style: AppTextStyles
                                      .homeDetailsDescriptionTextStyle(context),
                                ),
                                TextSpan(
                                  text:
                                      '${viewModel.getHome.area} ${AppStrings.meter.tr()}',
                                  style: AppTextStyles
                                      .homeDetailsDescriptionContactTextStyle(
                                          context),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSize.s10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${AppStrings.paymentScreenTitle.tr()} : ',
                                  style: AppTextStyles
                                      .homeDetailsDescriptionTextStyle(context),
                                ),
                                TextSpan(
                                  text: AppStrings.paymentCash.tr(),
                                  style: AppTextStyles
                                      .homeDetailsDescriptionContactTextStyle(
                                          context),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSize.s10),
                          FittedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                HomeDetailsContent(
                                  object: ' ${AppStrings.bedHome.tr()} ',
                                  icon: SVGAssets.bed,
                                  number:
                                      viewModel.getHome.numberOfBeds.toString(),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .1,
                                ),
                                HomeDetailsContent(
                                  object: ' ${AppStrings.wifiHome.tr()} ',
                                  icon: viewModel.getHome.wifiServices
                                      ? SVGAssets.wifi
                                      : Icons.wifi_off_outlined,
                                  number: '',
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .1,
                                ),
                                HomeDetailsContent(
                                  object: ' ${AppStrings.bathroomHome.tr()} ',
                                  icon: SVGAssets.bathRoom,
                                  number: viewModel.getHome.numberOfBathrooms
                                      .toString(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSize.s10),
                          Row(
                            children: [
                              Text(
                                '${AppStrings.homeDetailsRating.tr()} : ',
                                style: AppTextStyles
                                    .homeDetailsDescriptionTextStyle(context),
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star_rounded,
                                    color: index < displayedRating
                                        ? Colors.orange.withOpacity(.7)
                                        : Colors.grey.withOpacity(.7),
                                    size: AppSize.s35,
                                  );
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSize.s10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${AppStrings.description.tr()} : ',
                                  style: AppTextStyles
                                      .homeDetailsDescriptionTextStyle(context),
                                ),
                                TextSpan(
                                  text: viewModel.getHome.description,
                                  style: AppTextStyles
                                      .homeDetailsDescriptionContactTextStyle(
                                          context),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSize.s15),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${AppStrings.location.tr()} : ',
                                  style: AppTextStyles
                                      .homeDetailsDescriptionTextStyle(context),
                                ),
                                TextSpan(
                                  text: viewModel.getHome.location,
                                  style: AppTextStyles
                                      .homeDetailsDescriptionContactTextStyle(
                                          context),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppSize.s15),
                          Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  height: AppSize.s170,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(AppSize.s12),
                                    child: Image.asset(
                                      ImageAssets.map,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    DataIntent.pushInitialLocation(
                                        viewModel.getHome.coordinates);
                                    Navigator.pushNamed(
                                        context, Routes.homesMapRoute);
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    height: AppSize.s50,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: ColorManager.error),
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s12),
                                      color: ColorManager.offwhite,
                                    ),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          SVGAssets.pin,
                                          width: AppSize.s30,
                                          colorFilter: const ColorFilter.mode(
                                              ColorManager.black,
                                              BlendMode.modulate),
                                        ),
                                        Text(
                                          AppStrings.seeLocation.tr(),
                                          style: AppTextStyles
                                              .homeGeneralTextStyle(
                                                  context,
                                                  ColorManager.black,
                                                  FontSize.f18),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HomeDetailsContent extends StatelessWidget {
  const HomeDetailsContent({
    super.key,
    required this.object,
    required this.icon,
    required this.number,
  });

  final String object;
  final dynamic icon;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (icon is String)
          SvgPicture.asset(
            icon,
            color: ColorManager.offwhite,
          )
        else if (icon is IconData)
          Icon(
            icon,
            color: ColorManager.offwhite,
          ),
        const SizedBox(
          width: AppSize.s2,
        ),
        Text(
          number,
          style: AppTextStyles.homeDetailsDescriptionContactTextStyle(context),
        ),
        Text(
          overflow: TextOverflow.ellipsis,
          object,
          style: AppTextStyles.homeDetailsDescriptionTextStyle(context),
        ),
      ],
    );
  }
}
