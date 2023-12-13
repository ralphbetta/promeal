import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/assets.config.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/config/style.config.dart';
import 'package:promeal/constants.dart';
import 'package:promeal/provider/app.provider.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appListener = context.watch<AppProvider>();

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
                itemCount: 25,
                itemBuilder: (BuildContext context, index) {
                  return Container(
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("John Doe", style: AppStyle.apply(context)),
                                  Text("You transferred Breakfast to Williams",  style: AppStyle.apply(context, size: 11, fontWeight: FontWeight.w300))
                                ],
                              ),
                            ],
                          ),
                          Text("9:20am", style: AppStyle.apply(context, size: 11, fontWeight: FontWeight.w300),)
                        ],
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
