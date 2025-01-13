import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:pharma_plus/config/base/button_nav.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const ButtonNavBar()),
    );
  }

  // Widget pour afficher l'image
  Widget _buildImage(String assetName, [double width = 200]) {
    return Image.asset(
      'assets/images/$assetName',
      width: width,
      fit: BoxFit.cover,
    );
  }

  // Widget pour afficher l'animation Lottie
  Widget _buildLottie(String assetName, [double width = 250]) {
    return Lottie.asset(
      'assets/animation/$assetName',  // Référence du fichier JSON
      width: width,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
      bodyTextStyle: TextStyle(fontSize: 18.0, color: Colors.black54),
      bodyPadding: EdgeInsets.all(16.0),
      imagePadding: EdgeInsets.only(top: 40),
      pageColor: Colors.white,
    );

    return Scaffold(
      body: IntroductionScreen(
        pages: [
          // Première page avec image et Lottie
          PageViewModel(
            title: "Bienvenue dans PharmaPlus",
            body: "Votre solution complète pour accéder rapidement à vos médicaments préférés.",
            image: _buildLottie("animation.json"),
            decoration: pageDecoration,
          ),
          // Autres pages peuvent suivre la même logique
          PageViewModel(
            title: "Commandez en toute simplicité",
            body: "Trouvez et commandez vos médicaments directement depuis l'application.",
            image: _buildImage("image2.png"),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Suivez vos commandes",
            body: "Restez informé du statut de vos commandes en temps réel.",
            image: _buildImage("image3.png"),  // Image uniquement ici
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Notifications intelligentes",
            body: "Recevez des rappels pour vos commandes et prescriptions.",
            image: _buildImage("image.png"),  // Lottie uniquement ici
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context),
        showSkipButton: true,
        skip: const Text(
          'Passer',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
        next: const Icon(Icons.arrow_forward, color: Colors.green),
        done: const Text(
          'Commencer',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
        ),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.grey,
          activeSize: Size(22.0, 10.0),
          activeColor: Colors.green,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
