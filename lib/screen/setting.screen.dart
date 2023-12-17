import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/toggle.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    AccountProvider appAccount = context.watch<AccountProvider>();

    return Column(
      children: [
        SizedBox(height: AppSize.height(2)),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image(
                image: AssetImage(AppAsset.profile),
                width: AppSize.width(15),
              )),
              SizedBox(height: AppSize.height(2)),
              Text("${appAccount.accountModel!.name}", style: AppStyle.apply(context, fontWeight: FontWeight.w500, size: 24)),
              SizedBox(height: AppSize.height(0.5)),
              Text("${appAccount.accountModel!.email}", style: AppStyle.apply(context)),
              SizedBox(height: AppSize.height(5)),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      const SizedBox(width: 10),
                      Text("Change Password", style: AppStyle.apply(context)),
                      const Spacer(),
                      const Extrude(
                          radius: 3,
                          primary: true,
                          child: SizedBox(
                              height: 25,
                              width: 25,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: Colors.white,
                              )))
                    ],
                  ),
                  SizedBox(height: AppSize.height(0.8)),
                  Divider(
                    height: 10,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  SizedBox(height: AppSize.height(1.5)),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_outlined,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      const SizedBox(width: 10),
                      Text("Notification Sound", style: AppStyle.apply(context)),
                      const Spacer(),
                      AppToggle(
                          active: context.watch<AppProvider>().allowNotification,
                          onTap: () {
                            context.read<AppProvider>().toggleNotification();
                          })
                    ],
                  ),
                  SizedBox(height: AppSize.height(0.8)),
                  Divider(
                    height: 10,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                  SizedBox(height: AppSize.height(1.8)),
                ],
              ),
              GestureDetector(
                onTap: (){
                  context.read<AccountProvider>().signout(context);
                },
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 10),
                      Text("Sign out", style: AppStyle.apply(context, color: Colors.red)),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
