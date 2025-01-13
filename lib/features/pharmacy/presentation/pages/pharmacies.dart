import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_plus/config/base/onBoarding.dart';
import 'package:pharma_plus/features/pharmacy/presentation/bloc/pharmacy_bloc.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  void _onBackToIntro(context){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=> const OnBoardingPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pharma +',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_outlined, color: Colors.black),
            tooltip: 'QR Code',
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            tooltip: 'Notifications',
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: ()=> _onBackToIntro(context), child: const Text("Back")),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Rechercher une pharmacie...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.green.shade400),
                ),
              ),
            ),
          ),
          // Contenu principal
          Expanded(
            child: BlocBuilder<PharmacyBloc, PharmacyState>(
              builder: (context, state) {
                if (state is PharmacyInitial) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<PharmacyBloc>().add(GetPharmaciesEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Charger les pharmacies'),
                    ),
                  );
                }

                if (state is PharmacyLoading) {
                  return Center(child: CircularProgressIndicator(color: Colors.green.shade700,));
                }

                if (state is PharmacyLoaded) {
                  final filteredPharmacies = state.pharmacies
                      .where((pharmacy) =>
                  pharmacy.title?.toLowerCase().contains(_searchQuery) ?? false)
                      .toList();

                  if (filteredPharmacies.isEmpty) {
                    return const Center(
                      child: Text(
                        'Aucune pharmacie trouvée',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return RefreshIndicator(
                    color: Colors.green.shade700,
                    onRefresh: () async {
                      context.read<PharmacyBloc>().add(GetPharmaciesEvent());
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredPharmacies.length,
                      itemBuilder: (context, index) {
                        final pharmacy = filteredPharmacies[index];
                        return Card(
                          color: Colors.white,
                          elevation: 3,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.green.shade100,
                                  child: Icon(
                                    Icons.local_pharmacy,
                                    color: Colors.green.shade700,
                                    size: 24,
                                  ),
                                ),
                                title: Text(
                                  pharmacy.title ?? 'Pharmacie sans titre',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      pharmacy.location ?? 'Adresse non disponible',
                                      style: TextStyle(color: Colors.grey[600]),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tél: ${pharmacy.phone ?? "Non disponible"}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.green.shade700,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '${pharmacy.region ?? "Région inconnue"} (${pharmacy.comune ?? "Commune inconnue"})',
                                        style: TextStyle(
                                          color: Colors.green.shade800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                if (state is PharmacyError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.warning, color: Colors.red, size: 32),
                            const SizedBox(width: 8),
                            Text(
                              state.message,
                              style: const TextStyle(color: Colors.red, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<PharmacyBloc>().add(GetPharmaciesEvent());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  );
                }

                return Container();
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(0), topLeft: Radius.circular(0))),
        width: 250,
        child: Container(
          color: Colors.white,  // Couleur de fond du Drawer
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              // Header
              UserAccountsDrawerHeader(
                margin: const EdgeInsets.only(left: 10),
                accountName: const Text(
                  'Pharma +',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: const Text('contact@pharma.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.local_pharmacy,
                    color: Colors.green.shade700,
                    size: 40,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home, color: Colors.green.shade700),
                title: const Text('Accueil'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.green.shade700),
                title: const Text('Paramètres'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.green.shade700),
                title: const Text('Aide'),
                onTap: () {
                  Navigator.pop(context); // Fermer le drawer
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.share, color: Colors.green.shade700),
                title: const Text('Partagez'),
                onTap: (){},
              )
            ],
          ),
        ),
      ),
    );
  }
}

