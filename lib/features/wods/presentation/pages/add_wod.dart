import 'package:firestore_demo/core/presentation/providers/providers.dart';
import 'package:firestore_demo/features/wods/data/services/models/app_wod.dart';
import 'package:firestore_demo/features/wods/data/services/wod_firestore_service.dart';
import 'package:firestore_demo/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddWodPage extends StatefulWidget {
  final DateTime selectedDate;
  final AppWod wod;

  const AddWodPage({
    Key key,
    this.selectedDate,
    this.wod,
  }) : super(key: key);
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddWodPage> {
  final movements = [
    'Back Squat',
    'Front Squat',
    'Bulgarian Squat',
    'Deadlift',
    'Sumo Deadlift',
    'Sumo Deadlift High Pull',
    'Single Leg Deadlift',
    'Bench Press',
    'Shoulder Press',
    'Push Press',
    'Push Jerk',
    'Split Jerk',
    'Farmer Carry',
    'Power Clean',
    'Squat Clean',
    'Hang Squat Clean',
    'Hang Power Clean',
    'Clean and Jerk',
    'Power Snatch',
    'Squat Snatch',
    'Hang Squat Snatch',
    'Hang Power Snatch',
    'Snatch Balance',
    'Overhead Squat',
    'Thruster',
    'Lunges',
  ];

  bool visibleWeightlifting = false;
  bool visibleExtra = false;
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).addNewWODTitleText),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                bool validated = _formKey.currentState.validate();
                if (validated) {
                  _formKey.currentState.save();
                  final data =
                      Map<String, dynamic>.from(_formKey.currentState.value);
                  data['date'] =
                      (data['date'] as DateTime).millisecondsSinceEpoch;
                  //TODO: debemos verificar si el wod es nuevo o se va a editar un wod ya creado
                  if (widget.wod == null) {
                    data['user_id'] = context
                        .read(userRepoProvider)
                        .user
                        .id; //TODO: esto nos sirve para obtener el ID del usuario y podemos usarlo para mostrar informacion solo para este usuario.!!
                    await wodDBS.create(
                        data); //TODO: pasando esta funcion estamos subiendo toda la informacion a firestore
                  } else {
                    //edit and update
                    await wodDBS.updateData(widget.wod.id, data);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(S.of(context).saveButtonLabel),
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text(
                    'Weightlifting Section',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  value: visibleWeightlifting,
                  onChanged: (bool value) {
                    setState(() {
                      visibleWeightlifting = value;
                    });
                  },
                  secondary: const Icon(
                    Icons.line_weight,
                    color: Colors.red,
                  ),
                ),
                if (visibleWeightlifting) ...[
                  SizedBox(height: 20),
                  FormBuilderDropdown(
                    dropdownColor: Colors.black38,
                    clearIcon: Icon(Icons.close, color: Colors.grey),
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    name: 'weightliftingMovement',
                    initialValue: widget.wod?.weightliftingMovement,
                    decoration: InputDecoration(
                        labelText: 'movement',
                        labelStyle: TextStyle(color: Colors.red)),
                    allowClear: true,
                    hint: Text(
                      'Select a movement',
                      style: TextStyle(color: Colors.grey),
                    ),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: movements
                        .map((movement) => DropdownMenuItem(
                              value: movement,
                              child: Text('$movement'),
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FormBuilderTextField(
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          name: 'rounds',
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialValue: widget.wod?.rounds,
                          decoration: InputDecoration(
                            hintText: 'Rounds',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.only(left: 30.0),
                          ),
                        ),
                      ),
                      Flexible(
                          child: Text(
                        'X',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                      Flexible(
                        child: FormBuilderTextField(
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                          validator: FormBuilderValidators.compose(
                              [FormBuilderValidators.required(context)]),
                          name: 'reps',
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialValue: widget.wod?.reps,
                          decoration: InputDecoration(
                            hintText: 'Reps',
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding: EdgeInsets.only(left: 28.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  FormBuilderTextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    name: 'weightliftingDescription',
                    initialValue: widget.wod
                        ?.weightliftingDescription, //TODO: el signo ? en esa posicion nos indica que si wod no existe la operacion es nula
                    decoration: InputDecoration(
                      hintText: S.of(context).detailsHintLabel,
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.short_text,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 50),
                Center(
                  child: Text(
                    'WOD',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
                SizedBox(height: 30),
                FormBuilderTextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  name: 'wodDescription',
                  initialValue: widget.wod
                      ?.wodDescription, //TODO: el signo ? en esa posicion nos indica que si wod no existe la operacion es nula
                  decoration: InputDecoration(
                    hintText: S.of(context).detailsHintLabel,
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.short_text,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                FormBuilderChoiceChip(
                    alignment: WrapAlignment.spaceEvenly,
                    name: 'scoring',
                    decoration: InputDecoration(
                        labelText: 'type of scoring?',
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 18)),
                    options: [
                      FormBuilderFieldOption(value: 'amrap'),
                      FormBuilderFieldOption(value: 'time')
                    ]),
                SizedBox(height: 50),
                SwitchListTile(
                  title: const Text(
                    'Extra Exercises Section',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  value: visibleExtra,
                  onChanged: (bool value) {
                    setState(() {
                      visibleExtra = value;
                    });
                  },
                  secondary: const Icon(
                    Icons.line_weight,
                    color: Colors.red,
                  ),
                ),
                if (visibleExtra) ...[
                  SizedBox(height: 30),
                  FormBuilderTextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    name: 'extrasDescription',
                    initialValue: widget.wod
                        ?.extrasDescription, //TODO: el signo ? en esa posicion nos indica que si wod no existe la operacion es nula
                    decoration: InputDecoration(
                      hintText: S.of(context).detailsHintLabel,
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.short_text,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Divider(),
                ],
                Card(
                  child: FormBuilderDateTimePicker(
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    resetIcon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                    style: TextStyle(color: Colors.grey),
                    name: 'date',
                    initialValue: widget.wod != null
                        ? widget.wod.date
                        : widget.selectedDate ??
                            DateTime
                                .now(), //TODO: ESTE ES EL ARGUMENTO QUE PASAMOS Y ?? SIGNIFICA QUE SI ES NULO HACEMOS LO OTRO
                    fieldHintText: S.of(context).dateHintLabel,
                    inputType: InputType.date,
                    format: DateFormat('EEEE, dd MMMM, yyyy'),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.red,
                    )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
