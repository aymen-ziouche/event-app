import 'package:event_app/providers/sallesProvider.dart';
import 'package:event_app/screens/salles/detailsPage.dart';
import 'package:event_app/widgets/listViewWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SallesPage extends StatefulWidget {
  const SallesPage({super.key});
  static String id = "SallesPage";

  @override
  State<SallesPage> createState() => _SallesPageState();
}

class _SallesPageState extends State<SallesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final sallesProvider = context.read<SallesProvider>();
    sallesProvider.fetchsalles();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          title: Text("Les Salles des fetes"),
          centerTitle: true,
        ),
        body: Consumer<SallesProvider>(
          builder: (context, provider, child) {
            return provider.salles.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.salles.length,
                          itemBuilder: (context, index) {
                            final salle = provider.salles[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                        uid: salle.uid,
                                        name: salle.name,
                                        location: salle.location,
                                        capacity: salle.capacity,
                                        rating: salle.rating,
                                        type: salle.type,
                                        photoUrl: salle.photoUrl,
                                      ),
                                    ));
                              },
                              child: ListViewWidget(
                                uid: salle.uid,
                                name: salle.name,
                                location: salle.location,
                                capacity: salle.capacity,
                                rating: salle.rating,
                                type: salle.type,
                                photoUrl: salle.photoUrl,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
