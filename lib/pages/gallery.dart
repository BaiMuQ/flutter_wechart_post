/*
 * @Author: Bai YanShuo
 * @Date: 2023-04-23 13:16:20
 * @LastEditors: Bai YanShuo
 * @LastEditTime: 2023-04-26 16:21:20
 * @FilePath: /flutter_wechart/lib/pages/gallery.dart
 * @Description: 
 */
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechart/widgets/appbar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class GalleryWidget extends StatefulWidget {
  // 初始图片位置
  final int initialIndex;
  // 图片列表
  final List<AssetEntity> items;
  // 是否显示 bar
  final bool? isBarVisible;

  const GalleryWidget({
    super.key,
    required this.initialIndex,
    required this.items,
    this.isBarVisible,
  });

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget>
    with SingleTickerProviderStateMixin {
  bool visible = true;

  // 动画控制器
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    visible = widget.isBarVisible ?? true;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  Widget _buildImageView() {
    return ExtendedImageGesturePageView.builder(
      controller: ExtendedPageController(
        initialPage: widget.initialIndex,
      ),
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        final AssetEntity item = widget.items[index];
        return ExtendedImage(
          image: AssetEntityImageProvider(
            item,
            isOriginal: true,
          ),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: ((state) {
            return GestureConfig(
              minScale: 0.9,
              animationMinScale: 0.7,
              maxScale: 3.0,
              animationMaxScale: 3.5,
              speed: 1.0,
              inertialSpeed: 100.0,
              initialScale: 1.0,
              inPageView: true, // 是否使用 ExtendedImageGesturePageView 展示图片
            );
          }),
        );
      },
    );
  }

  Widget _mainView() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          visible = !visible;
        });
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        appBar: SlideAppBarWidget(
          visible: visible,
          controller: controller,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        body: _buildImageView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }
}
