import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shoea_flutter/constants.dart';
import 'package:shoea_flutter/models/PlaceOrderItem.dart';
import 'package:shoea_flutter/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(PlaceOrderItemAdapter());

  await Hive.openBox(AppConstants.appHiveBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoea',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppConstants.kPrimaryColor1,
      ),
      initialRoute: null,
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
    );
  }
}
