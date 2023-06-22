import 'package:event_app/providers/reservationsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationsPage extends StatefulWidget {
  const ReservationsPage({super.key});
  static String id = "ReservationsPage";

  @override
  State<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final reservationsProvider = context.read<ReservationsProvider>();
    reservationsProvider.fetchReservations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("Mes Résarvation"),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<ReservationsProvider>(
          builder: (context, provider, child) {
            return provider.reservations.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Image.network(
                          'https://img.freepik.com/free-vector/appointment-booking-calendar-design_23-2148573174.jpg?w=2000',
                          height: 300),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.reservations.length,
                        itemBuilder: (context, index) {
                          final reservation = provider.reservations[index];
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 70,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(2, 3),
                                        blurRadius: 7,
                                        spreadRadius: 3)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FittedBox(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.celebration,
                                            size: 32,
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                reservation.salleName,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              Text(
                                                reservation.salleLocation,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                reservation.date,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(Icons.access_time),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    reservation.startTime,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    reservation.endTime,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
          },
        ),
      ),
    ));
  }
}
