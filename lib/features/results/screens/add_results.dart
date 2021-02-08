import 'package:firestore_demo/core/presentation/providers/providers.dart';
import 'package:firestore_demo/features/results/data/model/user_result_model.dart';
import 'package:firestore_demo/features/results/data/services/user_results_db_service.dart';
import 'package:firestore_demo/features/wods/data/services/models/app_wod.dart';
import 'package:firestore_demo/features/wods/data/services/wod_firestore_service.dart';
import 'package:firestore_demo/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///////////////////////////////////////////=================================//////////////////////////////////
class AddResultPage extends StatefulWidget {
  final DateTime selectedDate;
  final AppWod wod;

  const AddResultPage({Key key, this.wod, this.selectedDate}) : super(key: key);
  @override
  _AddResultPageState createState() => _AddResultPageState();
}

class _AddResultPageState extends State<AddResultPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add your score'),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {},
              // onPressed: () async {
              //   bool validated = _formKey.currentState.validate();
              //   if (validated) {
              //     _formKey.currentState.save();
              //     final data =
              //         Map<String, dynamic>.from(_formKey.currentState.value);
              //     data['date'] =
              //         (data['date'] as DateTime).millisecondsSinceEpoch;
              //     //TODO: debemos verificar si el wod es nuevo o se va a editar un wod ya creado
              //     if (widget.result == null) {
              //       data['user_id'] = context
              //           .read(userRepoProvider)
              //           .user
              //           .email; //TODO: esto nos sirve para obtener el ID del usuario y podemos usarlo para mostrar informacion solo para este usuario.!!
              //       await resultsDBS.create(
              //           data); //TODO: pasando esta funcion estamos subiendo toda la informacion a firestore
              //     } else {
              //       //edit and update
              //       await resultsDBS.updateData(widget.result.id, data);
              //     }
              //     // Navigator.pop(context);
              //   }
              // },
              child: Text(S.of(context).saveButtonLabel),
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: wodDBS.streamList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final results = snapshot.data;
              return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: results.length,
                  itemBuilder: (BuildContext context, int index) {
                    AppWod wod = results[index];
                    // padding: EdgeInsets.all(16.0),
                    // SizedBox(height: 30),
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (wod.scoring == 'amrap') ...[
                              Text(
                                'Your AMRAP results',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Icon(
                                  Icons.timer,
                                  size: 35,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                            Text(
                              'Your Time',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Icon(
                                Icons.timer,
                                size: 35,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50.0, right: 50.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: FormBuilderTextField(
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 45),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        maxLines: 1,
                                        name: 'minutes',
                                        decoration: InputDecoration(
                                            hintText: 'minutes',
                                            hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16),
                                            contentPadding:
                                                EdgeInsets.only(left: 10)),
                                      ),
                                    ),
                                    Flexible(
                                        child: Text(
                                      ':',
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    )),
                                    Flexible(
                                      child: FormBuilderTextField(
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 45,
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        maxLines: 1,
                                        name: 'seconds',
                                        decoration: InputDecoration(
                                          hintText: 'seconds',
                                          hintStyle: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 50),
                              FormBuilderTextField(
                                style:
                                    TextStyle(fontSize: 24, color: Colors.grey),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                name: 'time_comment',
                                decoration: InputDecoration(
                                  hintText: wod.scoring,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.short_text,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              SizedBox(height: 50),
                              FormBuilderDateTimePicker(
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                resetIcon: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                ),
                                style: TextStyle(color: Colors.grey),
                                //TODO CHANGE DATE LANGUAGE
                                name: 'date',
                                initialValue: widget.wod != null
                                    ? widget.wod.date
                                    : widget.selectedDate ?? DateTime.now(),
                                //TODO: ESTE ES EL ARGUMENTO QUE PASAMOS Y ?? SIGNIFICA QUE SI ES NULO HACEMOS LO OTRO
                                fieldHintText: S.of(context).dateHintLabel,
                                inputType: InputType.date,
                                format: DateFormat('EEEE, dd MMMM, yyyy'),
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                )),
                              ),
                              FlatButton(
                                  child: Text('PRESS'),
                                  onPressed: () {
                                    print(snapshot.data);
                                  })
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
