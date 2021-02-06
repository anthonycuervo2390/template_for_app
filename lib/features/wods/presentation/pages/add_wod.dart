import 'package:firestore_demo/core/presentation/providers/providers.dart';
import 'package:firestore_demo/features/wods/data/services/models/app_wod.dart';
import 'package:firestore_demo/features/wods/data/services/wod_firestore_service.dart';
import 'package:firestore_demo/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddWodPage extends StatefulWidget {
  final DateTime selectedDate;
  final AppWod wod;

  const AddWodPage({Key key, this.selectedDate, this.wod}) : super(key: key);
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddWodPage> {
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
                FormBuilderTextField(
                  validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)]),
                  name: 'title',
                  initialValue: widget.wod?.title,
                  decoration: InputDecoration(
                    hintText: S.of(context).titleHintLabel,
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.only(left: 48.0),
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  name: 'description',
                  initialValue: widget.wod
                      ?.description, //TODO: el signo ? en esa posicion nos indica que si wod no existe la operacion es nula
                  decoration: InputDecoration(
                    hintText: S.of(context).detailsHintLabel,
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.short_text,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Divider(),
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
                      : widget.selectedDate ??
                          DateTime
                              .now(), //TODO: ESTE ES EL ARGUMENTO QUE PASAMOS Y ?? SIGNIFICA QUE SI ES NULO HACEMOS LO OTRO
                  fieldHintText: S.of(context).dateHintLabel,
                  inputType: InputType.date,
                  format: DateFormat('EEEE, dd MMMM, yyyy'),
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
