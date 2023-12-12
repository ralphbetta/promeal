
import 'package:flutter/material.dart';
import 'package:promeal/components/extrude.component.dart';
import 'package:promeal/config/size.config.dart';
import 'package:promeal/constants.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        hintText: "Make your search...",
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
        
        SizedBox(height:AppSize.height(1)),
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
