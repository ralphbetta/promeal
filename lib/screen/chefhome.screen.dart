import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/screen/transfers_history.screen.dart';
import 'package:provider/provider.dart';

class ChefHomeScreen extends StatelessWidget {
  const ChefHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appListener = context.watch<AppProvider>();
    final accountListener = context.watch<AccountProvider>();

    return Column(
      children: [
        SizedBox(height: AppSize.height(2)),

        /*-----------------------------------------------------------|
          TOGGLE SECTION
        |------------------------------------------------------------*/

        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              statCard(context, "Users", "${accountListener.accounts.where((element) => element.role == 'user').length}"),
              statCard(context, "Claimed", "${accountListener.adminfoodHistory.where((element) => element.forfeited == false).length}"),
              statCard(context, "Transfered", "${accountListener.adminfoodHistory.where((element) => element.owner == element.actingUser!.id).length}"),
              statCard(context, "Forfeited", "${accountListener.adminfoodHistory.where((element) => element.forfeited == true).length}"),

            ],
          ),
        ),
        SizedBox(height: AppSize.height(3)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
          child: Extrude(
            pressed: false,
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.1, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      adminDashboardTab.length,
                      (index) => appListener.adminDashboardTabIndex == index
                          ? ElasticIn(
                              child: Extrude(
                                onPress: () {},
                                pressed: true,
                                radius: 8,
                                child: SizedBox(
                                  width: AppSize.width(42),
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                    adminDashboardTab[index],
                                    style: AppStyle.apply(context, size: 14),
                                  )),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                context.read<AppProvider>().toggleAdminDashboardTabIndex(index);
                              },
                              child: Container(
                                color: 
                                Theme.of(context).scaffoldBackgroundColor,
                                width: AppSize.width(42),
                                height: 40,
                                child: Center(
                                    child: Text(
                                  adminDashboardTab[index],
                                  style: AppStyle.apply(context, size: 14),
                                )),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: AppSize.height(1)),
        Expanded(
            child: ListView.builder(
                itemCount: accountListener.adminfoodHistory.where((element) => element.side == appListener.adminDashboardTabIndex).toList().length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: appListener.adminDashboardTabIndex == 0 ? FadeInRight(delay: Duration(milliseconds: animationDelay * index), child: adminDashboardCard(index, context, accountListener, appListener)) : FadeInLeft(delay: Duration(milliseconds: animationDelay * index), child: adminDashboardCard(index, context, accountListener, appListener)),
                  );
                }))
      ],
    );
  }

  adminDashboardCard(int index, BuildContext context, AccountProvider accountListener, AppProvider appListener) {
    return Container(
      margin: EdgeInsets.only(
        bottom: AppSize.height(2),
        top: index == 0 ? AppSize.height(1) : 0,
        left: AppSize.width(4),
        right: AppSize.width(4),
      ),
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5)))),
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                Extrude(
                  radius: 100,
                  child: Image(
                    image: AssetImage(AppAsset.profile),
                    width: 35,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("${accountListener.adminfoodHistory.where((element) => element.side == appListener.adminDashboardTabIndex).toList()[index].actingUser!.name}", style: AppStyle.apply(context, fontWeight: FontWeight.w500, size: 18)), SizedBox(height: 5), Text(accountListener.adminfoodHistory.where((element) => element.side == appListener.adminDashboardTabIndex).toList()[index].owner == accountListener.adminfoodHistory.where((element) => element.side == appListener.adminDashboardTabIndex).toList()[index].actingUser!.id ? "${accountListener.adminfoodHistory.where((element) => element.side == appListener.adminDashboardTabIndex).toList()[index].meal} - Claimed" : "${accountListener.adminfoodHistory[index].meal} - Transfered", style: AppStyle.apply(context, size: 12, fontWeight: FontWeight.w400))],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatTime(accountListener.adminfoodHistory[index].createdAt!),
                  style: AppStyle.apply(context, size: 12, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 8),
                Text(
                  DateFormat("MMM d").format(accountListener.adminfoodHistory[index].createdAt!),
                  style: AppStyle.apply(context, size: 12, fontWeight: FontWeight.w300),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  statCard(BuildContext context, String title, String count) {
    return Extrude(
      pressed: true,
      child: SizedBox(
        width: AppSize.width(18),
        height: AppSize.width(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(count, style: AppStyle.apply(context, size: 22, fontWeight: FontWeight.w500)), Text(title, style: AppStyle.apply(context, fontWeight: FontWeight.w300, size: 13))],
        ),
      ),
    );
  }
}
