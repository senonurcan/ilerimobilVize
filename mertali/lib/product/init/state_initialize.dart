import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mertaliveonurcan/product/state/view_model/product_view_model.dart';

class StateInitialize extends StatelessWidget {
  const StateInitialize({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductViewModel>(
          create: (_) => ProductViewModel(),
        ),
      ],
      child: child,
    );
  }
}
