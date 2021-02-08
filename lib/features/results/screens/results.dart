import 'package:firestore_demo/core/presentation/res/routes.dart';
import 'package:firestore_demo/core/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultsPage> {
  final Color primary = Color(0xff291747);
  final Color active = Color(0xff6C48AB);
  CalendarController _calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit your result'),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.profile)),
        ],
      ),
      drawer: BuildDrawer(primary: primary, active: active),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TableCalendar(calendarController: _calendarController)],
        ),
      ),
    );
  }
}
