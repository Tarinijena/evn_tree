

import 'package:flutter/material.dart';

import '../common_widgets/custome_tab_view.dart';

class DemoTwo extends StatefulWidget {
  const DemoTwo({super.key});

  @override
  State<DemoTwo> createState() => _DemoTwoState();
}

class _DemoTwoState extends State<DemoTwo> {

  List<String> headerTab = ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5", "Week 6", "Week 7"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          flex: 7,
          child: CustomTabView(
            itemCount: headerTab.length,
            initPosition: 4,
            tabBuilder: (BuildContext context, int index) {
              return Tab(
                text: headerTab[index],
                height: 32,
              );
            },
            pageBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("$index"),
                  ),
                ],
              );
            },
            onPositionChange: (index) {},
            onScroll: (position) => debugPrint("On Scrolled Called>>>>${position.toString()}"),
          ),
        ),
      ),
    );
  }
}