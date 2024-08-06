import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/BottomAppBarProvider.dart';
import 'package:national_wild_animal/app/module/home_screen/EventScreen.dart';
import 'package:national_wild_animal/app/module/home_screen/ProfilePage.dart';
import 'package:national_wild_animal/app/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import 'HomeScreen.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({super.key, required this.screens});

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
  final List<Widget> screens;
  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomAppBarProvider(),
      child: BottomAppBarPage(
        screens: [HomeScreen.builder(context), EventScreen(), ProfilePage()],
      ),
    );
  }
}

class _BottomAppBarPageState extends State<BottomAppBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Color(0xFF2A233D),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF231D32)),
                    child: IconButton(
                        isSelected: true,
                        onPressed: () {
                          context.read<BottomAppBarProvider>().changePageOnClick(index: 0);
                        },
                        icon: Icon(
                          Icons.home,
                          size: 20,
                          color: Colors.white,
                        ))),
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF231D32)),
                    child: IconButton(
                        onPressed: () {
                          context.read<BottomAppBarProvider>().changePageOnClick(index: 1);
                        },
                        icon: Icon(
                          Icons.theater_comedy_outlined,
                          size: 20,
                          color: Colors.white,
                        )))
              ],
            ),
            Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF231D32)),
                child: IconButton(
                    onPressed: () {
                      context.read<BottomAppBarProvider>().changePageOnClick(index: 2);
                    },
                    icon: Icon(
                      Icons.person,
                      size: 20,
                      color: Colors.white,
                    )))
          ],
        ),
      ),
      body: Consumer<BottomAppBarProvider>(
        builder: (context, provider, child) {
          return Container(child: widget.screens[context.read<BottomAppBarProvider>().currentPageIndex]);
        },
      ),
    );
  }
}
