import 'package:event_app/providers/sallesProvider.dart';
import 'package:event_app/providers/userProvider.dart';
import 'package:event_app/screens/salles/sallesPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userProvider = context.read<UserProvider>();
    userProvider.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.0, vertical: 20),
                child: Consumer<UserProvider>(
                  builder: (context, provider, child) {
                    if (provider.user == null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.indigo,
                          strokeWidth: 5,
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Location',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                            color: Colors.indigo.withOpacity(0.4),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.locationDot,
                              color: Colors.indigo,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Annaba,",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "DZ",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 22.0,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text(
                    "Nos services:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
              HomePageWidget(
                title: "Les Pâtisseries",
                onTap: () {},
              ),
              HomePageWidget(
                title: "Les fleuristes",
                onTap: () {},
              ),
              HomePageWidget(
                title: "Les Salles des fetes",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (_) => SallesProvider(),
                            child: const SallesPage()),
                      ));
                },
              ),
              HomePageWidget(
                title: "Les Photographes",
                onTap: () {},
              ),
              HomePageWidget(
                title: "Les chef cuisiniers",
                onTap: () {},
              ),
              HomePageWidget(
                title: "Les coiffeuses",
                onTap: () {},
              ),
              HomePageWidget(
                title: "Les Decoratrices",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const HomePageWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  colors: [Colors.blue.shade300, Colors.pink.shade50]),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 3),
                    blurRadius: 7,
                    spreadRadius: 3)
              ]),
          child: Center(
              child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          )),
        ),
      ),
    );
  }
}
