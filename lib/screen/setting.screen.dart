import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/components/toggle.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/route.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/provider/theme.provider.dart';
import 'package:promeal/screen/changepassword.screen.dart';
import 'package:promeal/screen/mealcalender.screen.dart';
import 'package:promeal/screen/history.screen.dart';
import 'package:promeal/screen/statistics.screen.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AccountProvider appAccount = context.watch<AccountProvider>();

    int thisDelay = 100;

    return Column(
      children: [
        SizedBox(height: AppSize.height(2)),
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              JelloIn(
                delay: Duration(milliseconds: thisDelay),
                child: Center(
                    child: Image(
                  image:  ThemeClass.themeNotifier.value != ThemeMode.dark ? AssetImage(AppAsset.profile): AssetImage(AppAsset.profilelight),
                  width: AppSize.width(15),
                )),
              ),
              SizedBox(height: AppSize.height(2)),
              FadeInLeft(child: Text("${appAccount.accountModel!.name}", style: AppStyle.apply(context, fontWeight: FontWeight.w500, size: 24))),
              SizedBox(height: AppSize.height(0.5)),
              FadeInRight(child: Text("${appAccount.accountModel!.email}", style: AppStyle.apply(context))),
              SizedBox(height: AppSize.height(5)),
              GestureDetector(
                onTap: () {
                  AppRoutes.push(context, ChangePasswordScreen());
                },
                child: FadeInUp(
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
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
                  ),
                ),
              ),
                GestureDetector(
                onTap: () {
                  AppRoutes.push(context, MealCalenderScreen());
                },
                child: FadeInUp(
                  child: Visibility(
                    visible: context.read<AccountProvider>().accountModel!.role != 'user' ? false : true,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.food_bank_outlined,
                                color: Theme.of(context).textTheme.bodyLarge!.color,
                              ),
                              const SizedBox(width: 10),
                              Text("Update Meal", style: AppStyle.apply(context)),
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
                    ),
                  ),
                ),
              ),

               GestureDetector(
                onTap: () {
                  AppRoutes.push(context, MealStatistics());
                },
                child: FadeInUp(
                  child: Visibility(
                    visible: context.read<AccountProvider>().accountModel!.role != 'user' ? false : true,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.add_chart_outlined,
                                color: Theme.of(context).textTheme.bodyLarge!.color,
                              ),
                              const SizedBox(width: 10),
                              Text("Statistics", style: AppStyle.apply(context)),
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
                    ),
                  ),
                ),
              ),

                    GestureDetector(
                onTap: () {
                  AppRoutes.push(context, MealHistory());
                },
                child: FadeInUp(
                  child: Visibility(
                    visible: context.read<AccountProvider>().accountModel!.role != 'user' ? false : true,
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.history,
                                color: Theme.of(context).textTheme.bodyLarge!.color,
                              ),
                              const SizedBox(width: 10),
                              Text("Histories & Reviews", style: AppStyle.apply(context)),
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
                    ),
                  ),
                ),
              ),

              FadeInUp(
                delay: Duration(milliseconds: thisDelay),
                child: Column(
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
                            active: context.watch<AccountProvider>().allowNotification,
                            onTap: () {
                              context.read<AccountProvider>().toggleNotification();
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
              ),


               FadeInUp(
                delay: Duration(milliseconds: thisDelay),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                        const SizedBox(width: 10),
                        Text("Indicate to claim", style: AppStyle.apply(context)),
                        const Spacer(),
                        AppToggle(
                            active: context.watch<AccountProvider>().allowNotification,
                            onTap: () {
                              context.read<AccountProvider>().toggleNotification();
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
              ),
              GestureDetector(
                onTap: () {
                  context.read<AccountProvider>().signout(context);
                },
                child: FadeInUp(
                    delay: Duration(milliseconds: thisDelay * 2),

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

                        Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                      borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          //top region
                          BoxShadow(
                            offset: -Offset(4, 4),
                            color: Theme.of(context).secondaryHeaderColor,
                            blurRadius: 10,
                          ),
                          //bottom region
                          BoxShadow(
                            offset: Offset(4, 4),
                            color: Theme.of(context).shadowColor,
                            blurRadius: 10,
                          ),
                        ]),
                    child:SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: Colors.white,
                                    ))
                  ),
                      ],
                    ),
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
