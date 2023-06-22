import 'package:event_app/models/events.dart';
import 'package:event_app/services/database.dart';
import 'package:event_app/widgets/mainbutton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatefulWidget {
  final String uid;
  final String name;
  final String location;
  final String capacity;
  final String rating;
  final String type;
  final String photoUrl;
  const DetailsPage({
    super.key,
    required this.uid,
    required this.name,
    required this.location,
    required this.capacity,
    required this.rating,
    required this.type,
    required this.photoUrl,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

String? event = '';
final List<String> events = eventsList
    .map((event) => event['event'].toString())
    .toList(); // events list
final _date = TextEditingController(); // date of booking

DateTime? _getDOBDate() {
  if (_date.text.isEmpty) {
    return null;
  }
  return DateFormat.yMd().parse(_date.text);
}

Future<String?> _pickDate(BuildContext context, DateTime firstDate,
    DateTime initDate, DateTime lastDate) async {
  final locale = Localizations.localeOf(context);
  final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: initDate,
      lastDate: lastDate,
      locale: locale);

  if (picked != null) {
    return DateFormat.yMd().format(picked);
  }
  return null;
}

TimeOfDay? start = TimeOfDay.fromDateTime(DateTime.now());
TimeOfDay? end = TimeOfDay.fromDateTime(DateTime.now());

final TextEditingController timeRangeController = TextEditingController();

class _DetailsPageState extends State<DetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _date.clear();
    timeRangeController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    widget.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "A propos de la salle :",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(
                    child: Row(
                      children: [
                        const Text(
                          "la salle : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0).copyWith(top: 0),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Localisation : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.location,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0).copyWith(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Capacité d’invités : ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.capacity} personnes",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.rating,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.star,
                            size: 22,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "La réservation :",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButtonFormField<String>(
                    items: events.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? selected) {
                      event = selected;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Type d'événement",
                      fillColor: Colors.white,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Sélectionnez votre Type d'événement";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                      controller: _date,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'La date',
                        fillColor: Colors.white,
                      ),
                      autofocus: false,
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Sélectionnez votre date';
                        }
                        return null;
                      },
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final now = DateTime.now();
                        final firstDate =
                            DateTime(now.year, now.month, now.day);
                        final lastDate =
                            DateTime(now.year + 10, now.month, now.day);
                        final initDate = _getDOBDate();
                        final date = await _pickDate(
                            context, firstDate, initDate ?? lastDate, lastDate);
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (date != null) {
                          _date.text = date;
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    readOnly: true,
                    controller: timeRangeController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Select Time Range',
                      fillColor: Colors.white,
                    ),
                    autofocus: false,
                    onTap: pickTimeRange,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return 'Sélectionnez votre heure';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 300,
                      child: MainButton(
                        text: "Reserver",
                        hasCircularBorder: true,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await Database().addReservation(
                                date: _date.text,
                                salleName: widget.name,
                                salleLocation: widget.location,
                                startTime: '${start?.hour}:${start?.minute}',
                                endTime: '${end?.hour}:${end?.minute}',
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "Reserved",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              Navigator.pop(context);
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickTimeRange() async {
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTime == null) return;

    TimeOfDay? endTime = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (endTime == null) return;

    setState(() {
      start = startTime;
      end = endTime;
      timeRangeController.text =
          'From: ${start?.hour}:${start?.minute} To: ${end?.hour}:${end?.minute}';
    });
  }
}
