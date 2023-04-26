/*
 * @Author: Bai YanShuo
 * @Date: 2023-04-20 17:42:33
 * @LastEditors: Bai YanShuo
 * @LastEditTime: 2023-04-26 16:22:28
 * @FilePath: /flutter_wechart/lib/pages/post.dart
 * @Description: 
 */

import 'package:flutter/material.dart';
import 'package:flutter_wechart/utils/config.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'gallery.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  // 选取的图片
  List<AssetEntity> selectedAssets = [];
  // 图片列表
  Widget _buildPhotoList() {
    return Padding(
      padding: const EdgeInsets.all(spacing),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double width = (constraints.maxWidth - spacing * 2) / 3;
          return Wrap(
            spacing: spacing,
            runSpacing: spacing,
            children: [
              for (final AssetEntity asset in selectedAssets)
                _buildPhotoItem(asset, width),
              // 选择图片按钮
              if (selectedAssets.length < maxAssets)
                _buildAddBtn(context, width),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddBtn(BuildContext context, double width) {
    return GestureDetector(
      onTap: () async {
        final List<AssetEntity>? result = await AssetPicker.pickAssets(
          context,
          pickerConfig: AssetPickerConfig(
            selectedAssets: selectedAssets,
            maxAssets: maxAssets,
          ),
        );
        if (result == null) return;

        setState(() {
          selectedAssets = result;
        });
      },
      child: Container(
        color: Colors.black12,
        width: width,
        height: width,
        child: const Icon(
          Icons.add,
          color: Colors.grey,
        ),
      ),
    );
  }

  // 图片项
  Widget _buildPhotoItem(AssetEntity asset, double width) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GalleryWidget(
              initialIndex: selectedAssets.indexOf(asset),
              items: selectedAssets,
            ),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: AssetEntityImage(
          isOriginal: false,
          asset,
          width: width,
          height: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 主视图
  Widget _mainView() {
    return Column(
      children: [
        _buildPhotoList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发布动态'),
      ),
      body: _mainView(),
    );
  }
}
