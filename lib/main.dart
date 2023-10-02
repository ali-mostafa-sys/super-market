import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supermarket/features/launcher/repositories/pages/launcher_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supermarket/features/products/presentations/blocs/products_bloc.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();


  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application. Create an invoice
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=>di.sl<ProductsBloc>()..add(GetAllProductEvent())),
    ],
        child: MaterialApp(
          title: 'Flutter Demo',

          theme: ThemeData(
// This is the theme of your application.
//
// Try running your application with "flutter run". You'll see the
// application has a blue toolbar. Then, without quitting the app, try
// changing the primarySwatch below to Colors.green and then invoke
// "hot reload" (press "r" in the console where you ran "flutter run",
// or simply save your changes to "hot reload" in a Flutter IDE).
// Notice that the counter didn't reset back to zero; the application
// is not restarted.
            primarySwatch: Colors.blue,
          ),
          home:Directionality(
            textDirection: TextDirection.rtl,
            child: const LauncherPage(),
          ),

          debugShowCheckedModeBanner: false,

        )

    );
  }
}




