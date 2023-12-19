import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/modal.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:promeal/screen/transfers_history.screen.dart';
import 'package:promeal/utils/email_to_name.utils.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appListener = context.watch<AppProvider>();
    final accountListener = context.watch<AccountProvider>();

    String type = appListener.historyTabIndex == 0 ? 'food' : 'forfeited';

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
                                    userTab[index],
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
                                  userTab[index],
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
      
        SizedBox(height: AppSize.height(2)),

          /*-----------------------------------------------------------|
          SEARCH SECTION
        |------------------------------------------------------------*/

          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
            child: Extrude(
              pressed: true,
              child: Container(
                padding: const EdgeInsets.only(left: 14),
                width: double.infinity,
                height: 52,
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "I'm looking for...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const Spacer(),
                        Extrude(
                          onPress: () {},
                          primary: true,
                          radius: 8,
                          child: const SizedBox(
                            width: appbar - 5,
                            height: appbar - 5,
                            child: Icon(
                              Icons.search_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        )
                        // Spacer(),
                      ],
                    ),
                    SizedBox(width: AppSize.width(3))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: AppSize.height(1)),
          Expanded(
              child: ListView.builder(
                  itemCount: accountListener.accounts.where((element) => element.email != accountListener.accountModel!.email).length,
                  itemBuilder: (BuildContext context, index) {
                    return BounceInRight(
                      delay: Duration(milliseconds: index * 100),
                      child: Container(
                        margin: EdgeInsets.only(
                          bottom: AppSize.height(2),
                          top: index == 0 ? AppSize.height(1) : 0,
                          left: AppSize.width(4),
                          right: AppSize.width(4),
                        ),
                        width: double.infinity,
                        child: Extrude(
                          onPress: () {
                            showConfirmTransfer(context, () {
                             
                            }, message: "You are about to transfer your");
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.width(2),
                              vertical: AppSize.height(1.3),
                            ),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(AppAsset.profile),
                                  height: 30,
                                ),
                                const SizedBox(width: 10),
                                Text("${accountListener.accounts.where((element) => element.email != accountListener.accountModel!.email).toList()[index].name}", style: AppStyle.apply(context))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }))
       

      ],
    );
  }
}
