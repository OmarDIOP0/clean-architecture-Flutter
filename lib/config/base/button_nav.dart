import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/services.dart';
import 'package:pharma_plus/features/pharmacy/presentation/pages/map_page.dart';
import 'package:pharma_plus/features/pharmacy/presentation/pages/pharmacie_map.dart';
import 'package:pharma_plus/features/pharmacy/presentation/pages/pharmacies.dart';
import 'package:pharma_plus/services/pharmacy/pharmacy.dart';

class ButtonNavBar extends StatefulWidget {
  const ButtonNavBar({super.key});

  @override
  State<ButtonNavBar> createState() => _State();
}

class _State extends State<ButtonNavBar> {

  final _appScreen = [
    PharmacyPage(),
    const MapPage(),
    const MapPharmacy(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      print(PharmacyService().getAllPharmacies());
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:Colors.white,
      systemNavigationBarColor: Colors.white,
    ));
    return Scaffold(
      body: _appScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(FluentIcons.home_20_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
        selectedItemColor: Colors.green[500],
      ),
    );
  }
}


