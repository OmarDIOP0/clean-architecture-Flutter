import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_plus/config/base/button_nav.dart';
import 'package:pharma_plus/config/base/onBoarding.dart';
import 'package:pharma_plus/features/pharmacy/presentation/bloc/localisation_bloc.dart';
import 'package:pharma_plus/features/pharmacy/presentation/bloc/pharmacy_bloc.dart';
import 'package:pharma_plus/features/pharmacy/presentation/pages/pharmacies.dart';
import 'package:pharma_plus/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();  // Initialisation des dépendances
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider pour PharmacyBloc
        BlocProvider(
          create: (_) => di.sl<PharmacyBloc>()..add(GetPharmaciesEvent()),  // Lancement de l'événement au démarrage
        ),
        BlocProvider(
            create: (_)=>di.sl<LocationBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pharma +',
        theme: ThemeData(
          // Couleur principale verte
          primaryColor: Colors.green.shade50,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green.shade50,  // Couleur principale de votre app
            primary: Colors.green.shade50,
            secondary: Colors.green.shade400,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.shade50,
            foregroundColor: Colors.white,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.green.shade700,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade700,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.green.shade700,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.green.shade50,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green.shade700),
            ),
          ),
        ),
        home: const OnBoardingPage(),
      ),
    );
  }
}
