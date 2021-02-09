import 'package:firestore_demo/core/presentation/providers/providers.dart';
import 'package:firestore_demo/core/presentation/res/colors.dart';
import 'package:firestore_demo/core/widgets/drawer.dart';
import 'package:firestore_demo/features/wods/data/services/models/app_wod.dart';
import 'package:firestore_demo/features/wods/data/services/wod_firestore_service.dart';
import 'package:firestore_demo/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firestore_demo/core/presentation/res/routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _calendarController = CalendarController();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  //TODO: para poder pasar eventos dinamicamente necesitamos convertir la lista de wods de firestore a MAP
  Map<DateTime, List<AppWod>> _groupedWods;
  @override
  void didChangeDependencies() {
    context.read(pnProvider).init();
    super.didChangeDependencies();
  }

//TODO: esto crea un grupo de wods en formato MAP
  _groupWods(List<AppWod> wods) {
    _groupedWods = {};
    wods.forEach((wod) {
      DateTime date =
          DateTime.utc(wod.date.year, wod.date.month, wod.date.day, 12);
      if (_groupedWods[date] == null) _groupedWods[date] = [];
      _groupedWods[date].add(wod);
    });
  }

//TODO: NOTA! desde firestore recibimos una LISTA de los wods no es MAP
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      final user = watch(userRepoProvider).user;
      return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(S.of(context).appName),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              _key.currentState.openDrawer();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
            )
          ],
        ),
        drawer: BuildDrawer(),
        body: SingleChildScrollView(
          child: StreamBuilder(
            //========SI QUISIERAMOS QUE EL USUARIO VEA SOLO EL EVENTO QUE EL CREO Y QUE NADIE MAS LO VEA======//
            //stream: wodDBS.streamQueryList( args:[
            // QueryArgsV2('user_id', isEqualTo: context.read(userRepoProvider).user.id),
            // ],
            //),
            stream: wodDBS.streamList(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                final wods = snapshot.data;
                _groupWods(wods);
                //TODO: aqui hacemos que al seleccionar un dia nos muestre el wod del dia seleccionado y si no hay wod que nos muestre una lista vacia
                DateTime selectedDate = _calendarController.selectedDay;
                final _selectedWods = _groupedWods[selectedDate] ?? [];
                return Column(
                  children: [
                    Card(
                      color: AppColors.scaffoldBackgroundColor,
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.all(8.0),
                      child: TableCalendar(
                        events: _groupedWods,
                        onDaySelected: (date, wods, holidays) {
                          setState(() {});
                        },
                        initialCalendarFormat: CalendarFormat.week,
                        calendarController: _calendarController,
                        locale: Localizations.localeOf(context).languageCode,
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.6),
                          ),
                          headerMargin: EdgeInsets.only(bottom: 8.0),
                          titleTextStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          formatButtonVisible: false,
                          leftChevronIcon:
                              Icon(Icons.chevron_left, color: Colors.white),
                          rightChevronIcon:
                              Icon(Icons.chevron_right, color: Colors.white),
                        ),
                        calendarStyle: CalendarStyle(
                          todayColor: Colors.grey,
                          markersColor: Colors.blue,
                          selectedColor: AppColors.primaryColor,
                          weekdayStyle:
                              TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.addResult,
                            arguments: selectedDate,
                          );
                        },
                        icon: Icon(Icons.description),
                        label: Text('Add Results')),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _selectedWods.length,
                      itemBuilder: (BuildContext context, int index) {
                        AppWod wod = _selectedWods[index];
                        return Column(
                          children: [
                            Text(
                              DateFormat('EEEE, d MMM yyyy').format(wod.date),
                              style: TextStyle(
                                  fontSize: 24, color: AppColors.labelColor),
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
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      trailing: user.admin == false
                                          ? null
                                          : IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  AppRoutes.viewWod,
                                                  arguments: wod,
                                                );
                                              },
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
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold),
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
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
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
                        );
                      },
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
        floatingActionButton: user.admin == false
            ? Container()
            : FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.addWod,
                      arguments: _calendarController
                          .selectedDay); //TODO: AQUI PASAMOS EL ARGUMENTO DEL DIA SELECCIONADO PARA QUE LO MUESTRE EN LA SIGUIENTE PAGINA
                },
              ),
      );
    });
  }
}
