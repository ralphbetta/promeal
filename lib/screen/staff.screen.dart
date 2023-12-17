import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/modal.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/events.provider.dart';
import 'package:provider/provider.dart';

class TransferToScreen extends StatefulWidget {
  const TransferToScreen({super.key});

  @override
  State<TransferToScreen> createState() => _TransferToScreenState();
}

class _TransferToScreenState extends State<TransferToScreen> {
  final int delay = 400;
  @override
  Widget build(BuildContext context) {
    final accountListerner = context.watch<AccountProvider>();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: Container(),
          actions: [
            SizedBox(width: AppSize.width(4)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Extrude(
                  onPress: () {
                    Navigator.pop(context);
                  },
                  primary: true,
                  radius: 8,
                  child: const SizedBox(
                    width: appbar + 5,
                    height: appbar,
                    child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(width: AppSize.width(4)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Staff".toUpperCase(), style: AppStyle.apply(context, fontWeight: FontWeight.w700, size: 18)),
              ],
            ),
            const Spacer(),
          ],
          elevation: 0.9,
          shadowColor: Theme.of(context).colorScheme.background),
      body: SafeArea(
          child: Column(
        children: [
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
                  itemCount: accountListerner.accounts.where((element) => element.email != accountListerner.accountModel!.email).length,
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
                              Map body = {"meal": context.read<EventProvider>().meal, "key": accountListerner.accounts.where((element) => element.email != accountListerner.accountModel!.email).toList()[index].key};
                              Navigator.pop(context);
                               context.read<EventProvider>().transfer(context, body);
                            }, message: "You are about to transfer your ${context.read<EventProvider>().meal} to ${accountListerner.accounts.where((element) => element.email != accountListerner.accountModel!.email).toList()[index].name}");
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
                                Text("${accountListerner.accounts.where((element) => element.email != accountListerner.accountModel!.email).toList()[index].name}", style: AppStyle.apply(context))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      )),
    );
  }
}
