import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/screen/transfers_history.screen.dart';
import 'package:promeal/utils/email_to_name.utils.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final appListener = context.watch<AppProvider>();
    final accountListener = context.watch<AccountProvider>();

    String type = appListener.historyTabIndex == 0 ? 'food': 'forfit';

    return Column(
      children: [
        SizedBox(height: AppSize.height(2)),

        /*-----------------------------------------------------------|
          TOGGLE SECTION
        |------------------------------------------------------------*/

        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
          child: Extrude(
            pressed: false,
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.1, horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      historyTab.length,
                      (index) => appListener.historyTabIndex == index
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
                                    historyTab[index],
                                    style: AppStyle.apply(context, size: 14),
                                  )),
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                context
                                    .read<AppProvider>()
                                    .toggleHistoryTab(index);
                              },
                              child: SizedBox(
                                width: AppSize.width(42),
                                height: 40,
                                child: Center(
                                    child: Text(
                                  historyTab[index],
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
                itemCount: accountListener.notifications.where((element) => element.type == type).toList().length,
                itemBuilder: (BuildContext context, index) {
                  return FadeInUp(
                    duration: Duration(milliseconds: (index+1) * 700),
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: AppSize.height(2),
                        top: index == 0 ? AppSize.height(1) : 0,
                        left: AppSize.width(4),
                        right: AppSize.width(4),
                      ),
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1, color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5))
                          )
                        ),
                        padding: const  EdgeInsets.only(
                          bottom: 5
                        ),
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
                                    width: 25,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: AppSize.width(70),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(formatNameFromEmail(accountListener.notifications.where((element) => element.type == type).toList()[index].from!), style: AppStyle.apply(context)),
                                      Text("${accountListener.notifications.where((element) => element.type == type).toList()[index].content}",  style: AppStyle.apply(context, size: 11, fontWeight: FontWeight.w300))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(formatTime(accountListener.notifications.where((element) => element.type == type).toList()[index].createdAt!), style: AppStyle.apply(context, size: 11, fontWeight: FontWeight.w300),)
                          ],
                        ),
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
