import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temp_house/presentation/resources/color_manager.dart';
import 'package:temp_house/presentation/resources/strings_manager.dart';
import 'package:temp_house/presentation/resources/text_styles.dart';
import 'package:temp_house/presentation/resources/values_manager.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.notificationsScreenUnread.tr(),
              style: AppTextStyles.notificationsScreenSectionHeaderTextStyle(
                  context),
            ),
            OptionMenu(),
          ],
        ),
        const SizedBox(height: AppSize.s10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 2,
          itemBuilder: (context, index) {
            return const NotificationItem();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 30);
          },
        ),
        const SizedBox(height: AppSize.s50),
        Text(
          AppStrings.notificationsScreenAll.tr(),
          style:
              AppTextStyles.notificationsScreenSectionHeaderTextStyle(context),
        ),
        const SizedBox(height: AppSize.s20),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            return const NotificationItem();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 30);
          },
        ),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: ColorManager.white,
          radius: AppSize.s25,
        ),
        const SizedBox(width: AppSize.s10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Glanda ',
                  style: AppTextStyles.notificationsScreenPersonNameTextStyle(
                      context),
                  children: [
                    TextSpan(
                      text: 'just sent a photo, please check your message',
                      style: AppTextStyles.notificationsScreenItemBodyTextStyle(
                          context),
                    ),
                  ],
                ),
              ),
              Text(
                'Today at 08.00 AM',
                style: AppTextStyles.notificationsScreenDateTextStyle(context),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class OptionMenuItem {
  final IconData icon;
  final String text;
  final Function onPressed;

  OptionMenuItem({
    required this.icon,
    required this.text,
    required this.onPressed,
  });
}

class OptionMenu extends StatelessWidget {
  OptionMenu({super.key});

  final List<OptionMenuItem> menu = [
    OptionMenuItem(
      text: AppStrings.notificationsScreenMarkAllRead.tr(),
      icon: Icons.check,
      onPressed: () {},
    ),
    OptionMenuItem(
      text: AppStrings.notificationsScreenRemoveAll.tr(),
      icon: Icons.delete,
      onPressed: () {},
    ),
  ];

  List<PopupMenuEntry> buildOptions(
    BuildContext context,
    List<OptionMenuItem> items,
  ) {
    List<PopupMenuEntry> list = [];
    for (OptionMenuItem item in items) {
      list.add(
        PopupMenuItem(
          onTap: () {
            item.onPressed();
          },
          child: Row(
            children: [
              Icon(
                item.icon,
                color: ColorManager.primary,
              ),
              const SizedBox(width: AppSize.s10),
              Text(
                item.text,
                style:
                    AppTextStyles.notificationsScreenOptionTextStyle(context),
              ),
            ],
          ),
        ),
      );
      list.add(
        const PopupMenuDivider(
          height: AppSize.s1,
        ),
      );
    }
    list.removeLast();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_horiz_outlined),
      color: ColorManager.offwhite,
      iconColor: ColorManager.white,
      offset: const Offset(-AppSize.s50, AppSize.s0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      itemBuilder: (context) => buildOptions(context, menu),
    );
  }
}
