import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  static const routeName = '/detail';
  static const _viewType = 'detail-h5-iframe';

  static bool _registered = false;

  static void _registerIframe() {
    if (_registered) {
      return;
    }

    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      return web.HTMLIFrameElement()
        ..src = 'assets/assets/html/detail.html'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = '0'
        ..style.display = 'block'
        ..style.backgroundColor = '#ffffff';
    });
    _registered = true;
  }

  @override
  Widget build(BuildContext context) {
    _registerIframe();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('功能详情'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E2432),
        elevation: 0,
      ),
      body: const HtmlElementView(viewType: _viewType),
    );
  }
}
