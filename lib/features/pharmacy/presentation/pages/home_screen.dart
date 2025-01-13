// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:pharma_plus/models/pharmacy/pharmacy.dart';
import 'package:pharma_plus/services/pharmacy/pharmacy.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: [
    //     Container(
    //       padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         mainAxisSize: MainAxisSize.max,
    //         children: [
    //           const Icon(FluentIcons.navigation_24_filled),
    //           const Text('Pharma+',
    //               style: TextStyle(
    //                 fontSize: 20,
    //                 fontWeight: FontWeight.bold,
    //               )),
    //           Container(
    //             child: const Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Icon(FluentIcons.barcode_scanner_24_filled),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     Container(
    //       child: Column(
    //         children: [
    //           const SizedBox( height: 10),
    //           Container(
    //               padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    //               margin:  const EdgeInsets.fromLTRB(20, 20, 20, 0),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 color: Colors.white,
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 mainAxisSize: MainAxisSize.max,
    //                 children: [
    //                   Container(
    //                     width: 50,
    //                     height: 50,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(10),
    //                       image: const DecorationImage(
    //                         image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPFx3KC5jdbckm-Pmwu3Gug7zs3tddW7m_Tg&s'),
    //                         fit: BoxFit.cover,
    //                       ),
    //                     ),
    //                   ),
    //                   Container(
    //                     padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
    //                     child: Column(
    //                       children: [
    //                         const SizedBox( height: 5),
    //                         const Text('Pharmacie Serigne Fallou',
    //                             style: TextStyle(
    //                               fontSize: 15,
    //                               fontWeight: FontWeight.bold,
    //                             )),
    //                         const Text('Pikine Nord',
    //                             style: TextStyle(
    //                               fontSize: 13,
    //                             )),
    //                         const Text('45 km away',
    //                             style: TextStyle(
    //                               fontSize: 13,
    //                               fontWeight: FontWeight.bold,
    //                             )),
    //                       ],
    //                     ),
    //                   ),
    //                   Container(
    //                     margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(10),
    //                       color: Colors.grey[200],
    //                     ),
    //                     child: TextButton(
    //                       onPressed: () {},
    //                       child: const Text('Open', style: TextStyle(color: Colors.green, fontSize: 17)),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //           ),
    //         ]
    //       ),
    //     )
    //   ],
    // );
     return FutureBuilder(
          future: PharmacyService().getAllPharmacies(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error fetching pharmacy Data"),
              );
            }

            if (snapshot.hasData) {
              var data = snapshot.data as List<Pharmacy>;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPFx3KC5jdbckm-Pmwu3Gug7zs3tddW7m_Tg&s'),
                      ),
                      title: Text(
                          "${data[index].title}"),
                      subtitle: Text(data[index].location!),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          });
  }
}
