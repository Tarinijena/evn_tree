import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:national_wild_animal/app/app_utils/helper.dart';
import 'package:national_wild_animal/app/app_utils/shared_preferance.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/BottomAppBarProvider.dart';
import 'package:national_wild_animal/app/module/home_screen/EventScreen.dart';
import 'package:national_wild_animal/app/module/home_screen/ProfilePage.dart';
import 'package:national_wild_animal/app/module/home_screen/provider/user_role_provider.dart';
import 'package:national_wild_animal/app/module/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';

import 'HomeScreen.dart';

class BottomAppBarPage extends StatefulWidget {
  BottomAppBarPage({super.key, required this.screens});

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
  final List<Widget> screens;
  static Widget builder(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomAppBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserRoleProvider(),
        ),
      ],
      child: BottomAppBarPage(
        screens: [HomeScreen.builder(context), EventScreen.builder(context), ProfilePage()],
      ),
    );
  }
}

class _BottomAppBarPageState extends State<BottomAppBarPage> with Helper {
  SharedPref pref = SharedPref();
  Future<void>? _userRoleFuture;

  @override
  void initState() {
    _userRoleFuture = getUserRole();
    super.initState();
  }

  Future<void> getUserRole() async {
    String? Key = await pref.getKey("roles");
    if (Key != null) {
      context.read<UserRoleProvider>().setUserRole(json.decode(Key));
    } else {
      context.read<UserRoleProvider>().setUserRole(null);
    }

    print(">>>>>>>>>>>>>${Key}");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _userRoleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the user role
          return PopScope(
             canPop: false, // Prevents default pop behavior
      onPopInvoked: (didPop) async {
        // Show the custom dialog when back button is pressed
        bool shouldClose = await showCommonPopupNew(
          "Exit",
          "Are you sure you want to exit?",
          context,
          isYesOrNoPopup: true,
          barrierDismissible: false, // Disable dismissing by tapping outside
        );

        if (shouldClose) {
           // Schedule the pop to happen after the current frame completes
          WidgetsBinding.instance.addPostFrameCallback((_) {
             SystemNavigator.pop(); // Use true to ensure the navigation is performed correctly
          });  // Close the app or the screen
        }
      },
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          return Scaffold(
            bottomNavigationBar: BottomAppBar(
              height: 60,
              color: Color(0xFF2A233D),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildIconButton(
                        icon: Icons.home,
                        index: 0,
                      ),
                      Consumer<UserRoleProvider>(
                        builder: (context, provider, child) {
                          /*if (provider.roles
                              .toString()
                              .toLowerCase()
                              .contains("super admin")) {
                            return _buildIconButton(
                              icon: Icons.theater_comedy_outlined,
                              index: 1,
                            );
                          } else {
                            return Container();
                          }*/
                          return _buildIconButton(
                              icon: Icons.theater_comedy_outlined,
                              index: 1,
                            );
                        },
                      ),
                    ],
                  ),
                  _buildIconButton(
                    icon: Icons.person,
                    index: 2,
                  ),
                ],
              ),
            ),
            body: Consumer<BottomAppBarProvider>(
              builder: (context, provider, child) {
                return widget.screens[provider.currentPageIndex];
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildIconButton(
      {required IconData icon, int? index, void Function()? onPressed}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF231D32),
      ),
      child: IconButton(
        onPressed: onPressed ??
            () {
              if (index != null) {
                context
                    .read<BottomAppBarProvider>()
                    .changePageOnClick(index: index);
              }
            },
        icon: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
