
import 'package:flutter/material.dart';
import 'package:promeal/config/size.config.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppSize.height(2)),

        Expanded(
            child: ListView.builder(
                itemCount: 25,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: AppSize.height(2),
                      top: index == 0? AppSize.height(1): 0,
                      left: AppSize.width(4),
                      right: AppSize.width(4),
                    ),
                    width: double.infinity,
                    
                  );
                }))
      ],
    );
  }
}
