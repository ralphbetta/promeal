import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/toggle.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/model/account.model.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({
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
                                context.read<AppProvider>().toggleHistoryTab(index);
                              },
                              child: Container(
                                color: Theme.of(context).scaffoldBackgroundColor,
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
                  Expanded(
                    child: TextField(
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: "I'm looking for...",
                        border: InputBorder.none,
                      ),
                      onChanged: (value){
                        context.read<AccountProvider>().searchAccounts(value);
                      },
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
                itemCount: accountListener.accountsFiltered.where((element) => element.email != accountListener.accountModel!.email && element.side == appListener.historyTabIndex).length,
                itemBuilder: (BuildContext context, index) {
                  
                  List<AccountModel> users = accountListener.accountsFiltered.where((element) => element.email != accountListener.accountModel!.email && element.side == appListener.historyTabIndex).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BounceInRight(
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
                              //showConfirmTransfer(context, () {}, message: "You are about to transfer your");

                              context.read<AppProvider>().toggleUser(users[index].id!);
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
                                  Text("${users[index].name}", style: AppStyle.apply(context))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                     appListener.expandedUserId != users[index].id ? Container() : Column(
                        children: [

                          FadeInRight(
                            child: Container(
                              // color: Theme.of(context).primaryColor,
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Theme.of(context).textTheme.bodyLarge!.color!))),
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSize.width(4),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSize.width(4),
                                vertical: AppSize.height(2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.verified, color: Theme.of(context).primaryColor),
                                      SizedBox(width: 15),
                                      Container(
                                        child: Text("Approve"),
                                      ),
                                    ],
                                  ),
                                  AppToggle(active: true, onTap: (){
                                    //todo
                                  })
                                ],
                              ),
                            ),
                          ),
                          FadeInLeft(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: AppSize.width(4),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSize.width(4),
                                vertical: AppSize.height(2),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.manage_accounts,
                                        color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.9),
                                      ),
                                      SizedBox(width: 15),
                                      Container(
                                        child: Text("Make Admin"),
                                      ),
                                    ],
                                  ),
                                  AppToggle(
                                    active: users[index].role == 'user' ? false: true,
                                    onTap: (){
                                      context.read<AccountProvider>().assignRole(users[index].id!, context);
                                    },
                                    )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    
                    ],
                  );
                }))
      ],
    );
  }
}
