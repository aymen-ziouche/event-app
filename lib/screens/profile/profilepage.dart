import 'package:event_app/providers/userProvider.dart';
import 'package:event_app/screens/auth/login.dart';
import 'package:event_app/services/auth.dart';
import 'package:event_app/widgets/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  static String id = "ProfilePage";
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      try {
        await _auth.logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        debugPrint('logout error: $e');
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          title: const Text("Mon Profile"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Consumer<UserProvider>(
            builder: (context, provider, child) {
              return provider.user!.name.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.network(
                              'https://img.freepik.com/premium-vector/hand-drawn-flat-design-adhd-illustration_52683-83885.jpg?w=900'),
                          Padding(
                            padding:
                                const EdgeInsets.all(10.0).copyWith(bottom: 30),
                            child: const Text(
                              "mes données",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "Nom:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    provider.user!.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "Email:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    provider.user!.email,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "Address:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    provider.user!.address,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "City:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Annaba",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Text(
                                      "Pays:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "DZ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  print("This user wants to become a partner");
                                },
                                child: const Text(
                                  "Devenir un partenaire",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MainButton(
                              text: 'Déconnecter',
                              hasCircularBorder: true,
                              onTap: () {
                                _logout();
                              })
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
