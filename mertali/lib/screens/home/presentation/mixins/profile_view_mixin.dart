import 'package:flutter/material.dart';
import 'package:mertaliveonurcan/product/models/user.dart';
import 'package:mertaliveonurcan/screens/home/presentation/controller/home_manager.dart';
import 'package:mertaliveonurcan/screens/home/presentation/profile_view.dart';

mixin ProfileViewMixin on State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

  HomeManager get homeManager => HomeManager();

  Future<User> getProfileItems() {
    return homeManager.getProfile();
  }
}
