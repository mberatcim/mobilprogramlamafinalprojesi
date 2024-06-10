import 'package:finalprojesi2/blocs/language_bloc.dart';
import 'package:finalprojesi2/blocs/theme_bloc.dart';
import 'package:finalprojesi2/screens/boarding_screen.dart';
import 'package:finalprojesi2/screens/contact.dart';
import 'package:finalprojesi2/screens/homescreen.dart';
import 'package:finalprojesi2/screens/loginscreen.dart';
import 'package:finalprojesi2/screens/profilescreen.dart';
import 'package:finalprojesi2/screens/registerscreen.dart';
import 'package:finalprojesi2/screens/shoppingcartscreen.dart';
import 'package:finalprojesi2/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations/app_localizations.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageBloc>(
          create: (context) => LanguageBloc(),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Yemekçim',
            theme: theme,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', ''),
              Locale('tr', ''),
            ],
            initialRoute: '/',
            routes: {
              '/': (context) => SplashScreen(),
              '/boarding': (context) => BoardingScreen(),
              '/home': (context) => HomeScreen(),
              '/login': (context) => LoginScreen(),
              '/register': (context) => RegisterScreen(),
              '/profile': (context) => ProfilePage(),
              '/contact': (context) => ContactPage(),
              '/shopping_cart': (context) => ShoppingCartScreen(),
            },
          );
        },
      ),
    );
  }
}
