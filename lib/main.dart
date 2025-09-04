import 'package:flutter/material.dart';
import 'package:laudry_app/view/login_screen.dart';
import 'package:laudry_app/view/post_screen.dart';

void main() {
  runApp(const LoginScreen());
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          ),
      home: LoginAPIScreen(),
      routes: {
        //"/bottomNav": (context) => const buttomnavigation(),
        LoginAPIScreen.id: (context) => const LoginAPIScreen(),
        PostApiScreen.id: (context) => const PostApiScreen(),
        // OrderSingle.id: (context) => const OrderSingle(),
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:laudry_app/view/dashboard.dart';
// import 'package:laudry_app/view/layanan/single_order.dart';
// import 'package:laudry_app/view/login_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(375, 812),
//       builder: (context, child) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: "Flutter Laundry UI",
//         theme: ThemeData(
//           scaffoldBackgroundColor: Color(0xFFF8FAB4),
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           // textTheme: GoogleFonts.poppinsTextTheme(),
//         ),
//         initialRoute: "/",
//         onGenerateRoute: _onGenerateRoute,
//       ),
//     );
//   }
// }

// Route<dynamic> _onGenerateRoute(RouteSettings settings) {
//   switch (settings.name) {
//     // case "/splashscreen":
//     //   return MaterialPageRoute(builder: (BuildContext context) {
//     //     return SplashScreen();
//     //   });
//     case "/login":
//       return MaterialPageRoute(builder: (BuildContext context) {
//         return LoginAPIScreen();
//       });
//     case "/dashboard":
//       return MaterialPageRoute(builder: (BuildContext context) {
//         return Dashboard();
//       });
//     case "/single-order":
//       return MaterialPageRoute(builder: (BuildContext context) {
//         return OrderSingle();
//       });
//     default:
//       return MaterialPageRoute(builder: (BuildContext context) {
//         return Dashboard();
//       });
//   }
// }
