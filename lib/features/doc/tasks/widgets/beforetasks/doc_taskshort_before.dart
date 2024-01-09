import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../../services/entities/data/neuromodels.dart';

import '../../../../../l10n/locale_keys.g.dart';
import '../../../../../services/entities/2_beforetask.dart';
import '../../../../../services/entities/data/model/neuromodel.dart';
import '../../../patient/controllers/patient_controller.dart';
import '../../controllers/before_task_controller.dart';
import '../../../../../core/router/route_names.dart';

class DocTaskShortBefore extends StatefulWidget {
  const DocTaskShortBefore({super.key});

  @override
  State<DocTaskShortBefore> createState() => _DocTaskShortBeforeState();
}

class _DocTaskShortBeforeState extends State<DocTaskShortBefore> {
  final _formkey = GlobalKey<FormState>();
  final beforeTaskController = Get.find<BeforeTaskController>();

  final _beforeprogramCtrl = TextEditingController();
  final _electrodesCtrl = TextEditingController();

  final _beforeampCtrl = TextEditingController();
  final _beforefreqCtrl = TextEditingController();
  final _beforedurCtrl = TextEditingController();
  final _beforeprimCtrl = TextEditingController();
  final requiredvalidator =
      RequiredValidator(errorText: LocaleKeys.requiredfield.tr() + '*');
  // electrodes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.beforeprog.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: GetBuilder(
        builder: (BeforeTaskController beforeTaskController) {
          return SingleChildScrollView(
            child: GetBuilder(builder: (PatientController patientController) {
              Iterable<Neuro> liststimul = neuromodels.where((neuromodel) =>
                  neuromodel.model
                      .contains(patientController.patients[0].modelneuro));
              return Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.always,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(children: [
                    TextFormField(
                      controller: _beforeprogramCtrl,
                      textCapitalization: TextCapitalization.sentences,
                      validator: MultiValidator([
                        requiredvalidator,
                      ]),
                      minLines: 1,
                      maxLines: 1,
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          labelText: LocaleKeys.program.tr(),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _electrodesCtrl,
                      validator: MultiValidator([
                        requiredvalidator,
                      ]),
                      minLines: 1,
                      maxLines: 1,
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          labelText: LocaleKeys.electrodeformula.tr(),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _beforeampCtrl,
                      validator: MultiValidator([
                        requiredvalidator,
                        RangeValidator(
                            min: liststimul
                                .map((neumodel) => neumodel.minampl)
                                .toList()
                                .first,
                            max: liststimul
                                .map((neumodel) => neumodel.maxampl)
                                .toList()
                                .first,
                            errorText: LocaleKeys.wrongdate.tr())
                      ]),
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          labelText: LocaleKeys.amp.tr(),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    Text(
                        '${liststimul.map((neumodel) => neumodel.minampl).toList().first} - ${liststimul.map((neumodel) => neumodel.maxampl).toList().first}',
                        style: Theme.of(context).textTheme.displayLarge),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _beforefreqCtrl,
                      validator: MultiValidator([
                        requiredvalidator,
                        RangeValidator(
                            min: liststimul
                                .map((neumodel) => neumodel.minfreq)
                                .toList()
                                .first,
                            max: liststimul
                                .map((neumodel) => neumodel.maxfreq)
                                .toList()
                                .first,
                            errorText: LocaleKeys.wrongdate.tr())
                      ]),
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          labelText: LocaleKeys.freq.tr(),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    Text(
                        '${liststimul.map((neumodel) => neumodel.minfreq).toList().first} - ${liststimul.map((neumodel) => neumodel.maxfreq).toList().first}',
                        style: Theme.of(context).textTheme.displayLarge),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _beforedurCtrl,
                      validator: MultiValidator([
                        requiredvalidator,
                        RangeValidator(
                            min: liststimul
                                .map((neumodel) => neumodel.mindur)
                                .toList()
                                .first,
                            max: liststimul
                                .map((neumodel) => neumodel.maxdur)
                                .toList()
                                .first,
                            errorText: LocaleKeys.wrongdate.tr())
                      ]),
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          labelText: LocaleKeys.dur.tr(),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    Text(
                        '${liststimul.map((neumodel) => neumodel.mindur).toList().first} - ${liststimul.map((neumodel) => neumodel.maxdur).toList().first}',
                        style: Theme.of(context).textTheme.displayLarge),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _beforeprimCtrl,
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          labelText: LocaleKeys.note.tr(),
                          focusColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        child: Text(
                          LocaleKeys.save.tr(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        onPressed: () {
                          _formkey.currentState?.save();
                          if (_formkey.currentState != null &&
                              _formkey.currentState!.validate()) {
                            beforeTaskController.addBeforeTasks(BeforeTask(
                                beforeprogram: _beforeprogramCtrl.text,
                                beforelectrode: _electrodesCtrl.text,
                                beforeamp: double.parse(_beforeampCtrl.text),
                                beforefreq: int.parse(_beforefreqCtrl.text),
                                beforedur: int.parse(_beforedurCtrl.text),
                                beforeprim: _beforeprimCtrl.text));
                            context.pushNamed(RouteNames.doctasks);
                          }
                        })
                  ]),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}