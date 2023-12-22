
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/provider/account.provider.dart';
import 'package:promeal/utils/email_to_name.utils.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class AdminTransfersScreen extends StatelessWidget {
  const AdminTransfersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    AccountProvider accountListener = context.watch<AccountProvider>();
    return Column(
      children: [
        SizedBox(height: AppSize.height(2)),

        Expanded(
            child: accountListener.adminfoodHistory.isEmpty ?  Container(
              child: Center(child: Text("No transfers yet for today", style: AppStyle.apply(context),))
            
            ): ListView.builder(
                itemCount: accountListener.admintransferHistory.length,
                itemBuilder: (BuildContext context, index) {
                  return BounceInRight(
                    delay: Duration(milliseconds: index*100),
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: AppSize.height(2),
                        top: index == 0? AppSize.height(1): 0,
                        left: AppSize.width(4),
                        right: AppSize.width(4),
                      ),
                      width: double.infinity,
                      child: Extrude(
                        pressed: true,
                        onPress: (){
                          print(accountListener.admintransferHistory[index].toJson());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(2),
                            vertical: AppSize.height(1.3),
                          ),
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(AppAsset.food),
                                height: 30,
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(FormatUtil.capitalize(accountListener.admintransferHistory[index].meal ?? ""), style: AppStyle.apply(context, fontWeight: FontWeight.w500, size: 20)),
                                  const SizedBox(height: 7),
                                  Text("From: ${ FormatUtil.emailToName(accountListener.admintransferHistory[index].sender ?? "" )}", style: AppStyle.apply(context)),
                                 
                                ],
                              ),

                              const Spacer(),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(FormatUtil.formatTime(accountListener.admintransferHistory[index].createdAt!), style: AppStyle.apply(context),),
                                  const SizedBox(height: 7),
                                   Text(DateFormat("MMM d, yyyy").format(accountListener.admintransferHistory[index].createdAt!),  style: AppStyle.apply(context),)
                                ],
                              )
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


