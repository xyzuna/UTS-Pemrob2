import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/order_cubit.dart';
import 'pages/order_home_page.dart';
import 'pages/category_stack_page.dart';
import 'pages/order_summary_page.dart';

void main() {
  runApp(const UtsApp());
}

class UtsApp extends StatelessWidget {
  const UtsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderCubit>(create: (_) => OrderCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UTS Kasir App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        home: const OrderHomePage(),

        routes: {
          '/home': (_) => const OrderHomePage(),
          '/categories': (_) => const CategoryStackPage(),
          '/summary': (_) => const OrderSummaryPage(),
        },
      ),
    );
  }
}
