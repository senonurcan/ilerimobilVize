// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mertaliveonurcan/product/funcs.dart';
import 'package:mertaliveonurcan/product/init/language/locale_keys.g.dart';
import 'package:mertaliveonurcan/product/init/product_localization.dart';
import 'package:mertaliveonurcan/product/models/oneri.dart';
import 'package:mertaliveonurcan/product/navigator.dart';
import 'package:mertaliveonurcan/product/permission/product_notification_permission.dart';
import 'package:mertaliveonurcan/product/utility/locales.dart';
import 'package:mertaliveonurcan/screens/auth/presentation/login_view.dart';
import 'package:mertaliveonurcan/screens/home/presentation/controller/anasayfa_list.dart';
import 'package:mertaliveonurcan/screens/home/presentation/mixins/anasayfa_view_mixin.dart';
import 'package:mertaliveonurcan/screens/home/presentation/profile_view.dart';

part './widgets/home_page_drawer.dart';

class AnasayfaView extends StatefulWidget {
  const AnasayfaView({Key? key}) : super(key: key);

  @override
  _AnasayfaViewState createState() => _AnasayfaViewState();
}

class _AnasayfaViewState extends State<AnasayfaView> with AnasayfaViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocaleKeys.home).tr(),
        actions: [
          Switch(
            value: switchValue,
            onChanged: (value) {
              switchValue = value;
              changeTheme();
              setState(() {
                switchValue = value;
              });
            },
          ),
        ],
      ),
      drawer: const _HomePageDrawer(),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.welcome.tr(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                LocaleKeys.home_page_content,
                style: TextStyle(fontSize: 16),
              ).tr(),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  final list = ref.watch(anasayfaListProvider);
                  return Expanded(
                    child: list.when(
                      data: (data) {
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return _buildListItem(
                              data[index],
                              context,
                            );
                          },
                        );
                      },
                      error: (error, stackTrace) => Center(
                        child: Text(error.toString()),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${LocaleKeys.title.tr()}:',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: TextField(
                    controller: titleController,
                    onChanged: (value) =>
                        titleController.text = value.toString(),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.title.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  LocaleKeys.home_page_suggestion,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ).tr(),
                Expanded(
                  child: TextField(
                    controller: oneriController,
                    onChanged: (value) =>
                        oneriController.text = value.toString(),
                    decoration: InputDecoration(
                      hintText: LocaleKeys.home_page_suggestion.tr(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () {
                      add(titleController.text, oneriController.text, ref);
                      titleController.clear();
                      oneriController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Buton rengi
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        LocaleKeys.home_page_add,
                        style: TextStyle(fontSize: 16),
                      ).tr(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildListItem(Oneri oneri, BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(oneri.title.toString()),
        subtitle: Text(oneri.oneri.toString()),
        leading: const Icon(Icons.lightbulb),
        onTap: () {
          Funcs.showSnackBar(context, 'Öneriye tıklandı: ${oneri.id}');
        },
      ),
    );
  }
}
