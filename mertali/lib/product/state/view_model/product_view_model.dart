import 'package:flutter/material.dart';
import 'package:mertaliveonurcan/product/state/base/base_cubit.dart';
import 'package:mertaliveonurcan/product/state/view_model/product_state.dart';

///ProductViewModel
class ProductViewModel extends BaseCubit<ProductState> {
  ///initialState
  ProductViewModel() : super(const ProductState());

  ///setThemeMode
  void setThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }
}
