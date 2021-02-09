import 'package:firestore_demo/core/presentation/res/colors.dart';
import 'package:firestore_demo/core/presentation/res/routes.dart';
import 'package:firestore_demo/features/wods/data/services/models/app_wod.dart';
import 'package:firestore_demo/features/wods/data/services/wod_firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WodDetails extends StatelessWidget {
  final AppWod wod;

  const WodDetails({Key key, this.wod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.pushReplacementNamed(
                  context, AppRoutes.editWod,
                  arguments: wod)),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                //TODO: puedo usar esta logica para mostrar una alerta cuando quieran cancelar o reservar una clase
                final confirm = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Warning!'),
                        content: Text('Are you sure you want to delete?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Delete')),
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(
                                'Cancel',
                                style: TextStyle(color: Colors.grey.shade700),
                              ))
                        ],
                      ),
                    ) ??
                    false;
                if (confirm) {
                  //delete and pop
                  wodDBS.removeItem(wod.id);
                  Navigator.pop(context);
                }
              }),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            DateFormat('EEEE, d MMM yyyy').format(wod.date),
            style: TextStyle(fontSize: 24, color: AppColors.labelColor),
          ),
          if (wod.weightliftingMovement != null &&
              wod.weightliftingDescription != null &&
              wod.rounds != null &&
              wod.reps != null) ...[
            Card(
              color: Colors.grey,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    title: Center(
                      child: Text(
                        'WEIGHTLIFTING',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        wod.weightliftingDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Card(
            color: Colors.grey,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      'WOD',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      wod.wodDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (wod.extrasDescription != null) ...[
            Card(
              color: Colors.grey,
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    title: Center(
                      child: Text(
                        'EXTRAS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        wod.extrasDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
