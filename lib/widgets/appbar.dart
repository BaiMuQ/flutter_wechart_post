/*
 * @Author: Bai YanShuo
 * @Date: 2023-04-26 15:37:30
 * @LastEditors: Bai YanShuo
 * @LastEditTime: 2023-04-26 16:19:19
 * @FilePath: /flutter_wechart/lib/widgets/appbar.dart
 * @Description: 
 */

import 'package:flutter/material.dart';

class SlideAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const SlideAppBarWidget({
    super.key,
    required this.child,
    required this.controller,
    required this.visible,
  });

  final PreferredSizeWidget child;
  final AnimationController controller;
  final bool visible;

  @override
  Size get preferredSize => child.preferredSize;

  @override
  Widget build(BuildContext context) {
    visible ? controller.forward() : controller.reverse();
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset.zero,
        end: const Offset(0.0, -1.0),
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.fastOutSlowIn,
        ),
      ),
      child: child,
    );
  }
}
