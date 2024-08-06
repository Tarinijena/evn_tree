import 'package:flutter/material.dart';
import 'package:national_wild_animal/app/app_theme/colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(1), color: const Color(0xFF2A233D)),
      height: 41,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.menu_outlined,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 13,
                ),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFF1F1734), borderRadius: BorderRadius.circular(8.5)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4, right: 35, left: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: ColorsGroup.iconColor,
                        ),
                        Text(
                          "Bhubaneswar",
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
              child: Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.notifications_outlined,
                        size: 20,
                        color: ColorsGroup.iconColor,
                      )),
                  const Positioned(
                      left: 8,
                      right: 0,
                      top: -2,
                      child: Text(
                        "3",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
