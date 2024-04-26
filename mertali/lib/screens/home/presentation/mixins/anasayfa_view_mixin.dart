import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mertaliveonurcan/product/cache/product_cache_manager.dart';
import 'package:mertaliveonurcan/product/models/oneri.dart';
import 'package:mertaliveonurcan/product/state/view_model/product_view_model.dart';
import 'package:mertaliveonurcan/screens/home/presentation/anasayfa_view.dart';
import 'package:mertaliveonurcan/screens/home/presentation/controller/anasayfa_list.dart';

mixin AnasayfaViewMixin on State<AnasayfaView> {
  ScrollController scrollController = ScrollController();
  bool switchValue = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController oneriController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void add(String title, String oneri, WidgetRef ref) {
    ref
        .watch(anasayfaListProvider.notifier)
        .addOneri(
          Oneri(
            id: UniqueKey().hashCode,
            title: title,
            oneri: oneri,
          ),
        )
        .whenComplete(
          () => scrollController.animateTo(
            scrollController.position.maxScrollExtent + 150.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
          ),
        );
  }

  changeTheme() {
    setState(() {
      switchValue = !switchValue;
    });

    ProductStorageManager.setTheme(theme: switchValue ? 'dark' : 'light');

    BlocProvider.of<ProductViewModel>(context, listen: false).setThemeMode(
      switchValue ? ThemeMode.dark : ThemeMode.light,
    );

    log(context.read<ProductViewModel>().state.themeMode.toString());
  }
}
