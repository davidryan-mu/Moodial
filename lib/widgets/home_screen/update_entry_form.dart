import 'package:Moodial/models/entry.dart';
import 'package:flutter/material.dart';

class UpdateEntryForm extends StatefulWidget {
  final Function callback;
  final Entry entry;

  UpdateEntryForm(this.callback, this.entry);

  @override
  _UpdateEntryFormState createState() =>
      _UpdateEntryFormState(this.callback, this.entry);
}

class _UpdateEntryFormState extends State<UpdateEntryForm> {
  Function callback;
  Entry entry;

  _UpdateEntryFormState(this.callback, this.entry);
  final _formKey = GlobalKey<FormState>();

  final sleepController = TextEditingController();
  final medNameController = TextEditingController();
  final medDoseController = TextEditingController();
  final dietFoodController = TextEditingController();
  final dietAmountController = TextEditingController();
  final exerciseController = TextEditingController();
  final notesController = TextEditingController();

  final List<int> iritabilityOptions = new List<int>.generate(10, (i) => i + 1);
  int _iritabilityDropdownValue = 1;
  bool _overwritten = false;

  Map<String, dynamic> formData = {
    'valid': false,
    'sleep': '',
    'iritability': 1,
    'medName': '',
    'medDose': '',
    'dietFood': '',
    'dietAmount': '',
    'exercise': '',
    'notes': '',
  };

  void overwriteTextControllers() {
    if (!_overwritten) {
      sleepController.text = entry.sleep.toString();
      medNameController.text = entry.medication.name;
      medDoseController.text = entry.medication.dose;
      dietFoodController.text = entry.diet.food;
      dietAmountController.text = entry.diet.amount;
      exerciseController.text = entry.exercise;
      notesController.text = entry.notes;
      _overwritten = !_overwritten;

      setState(() {
        _iritabilityDropdownValue = entry.iritability.toInt();
        formData['sleep'] = entry.sleep.toString();
        formData['medName'] = entry.medication.name;
        formData['medDose'] = entry.medication.dose;
        formData['dietFood'] = entry.diet.food;
        formData['dietAmount'] = entry.diet.amount;
        formData['exercise'] = entry.exercise;
        formData['notes'] = entry.notes;
      });
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    sleepController.dispose();
    medNameController.dispose();
    medDoseController.dispose();
    dietFoodController.dispose();
    dietAmountController.dispose();
    exerciseController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    overwriteTextControllers();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: sleepController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else if (double.tryParse(value) == null) {
                        return 'Must be a numerical value';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Sleep',
                        hintText: 'Hours',
                        labelStyle: TextStyle(fontSize: 14.0)),
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          formData['valid'] = true;
                          formData['sleep'] = sleepController.text;
                        });
                        this.callback(formData);
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _iritabilityDropdownValue,
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          _iritabilityDropdownValue = value;
                          formData['valid'] = true;
                          formData['iritability'] = _iritabilityDropdownValue;
                        });
                        this.callback(formData);
                      }
                    },
                    validator: (int value) {
                      if (value == null) {
                        return 'Required field';
                      }
                      return null;
                    },
                    items: iritabilityOptions
                        .map((int item) => DropdownMenuItem<int>(
                            child: Text(item.toString()), value: item))
                        .toList(),
                    decoration: InputDecoration(
                      labelText: 'Iritability',
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Medication',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: medNameController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            formData['valid'] = true;
                            formData['medName'] = medNameController.text;
                          });
                          this.callback(formData);
                        }
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextFormField(
                    controller: medDoseController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          formData['valid'] = true;
                          formData['medDose'] = medDoseController.text;
                        });
                        this.callback(formData);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Dose',
                        labelStyle: TextStyle(fontSize: 14.0)),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Diet',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: dietFoodController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          formData['valid'] = true;
                          formData['dietFood'] = dietFoodController.text;
                        });
                        this.callback(formData);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Food',
                        labelStyle: TextStyle(fontSize: 14.0)),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: TextFormField(
                    controller: dietAmountController,
                    validator: (value) {
                      if (value == null) {
                        return 'Required field';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          formData['valid'] = true;
                          formData['dietAmount'] = dietAmountController.text;
                        });
                        this.callback(formData);
                      }
                    },
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(fontSize: 14.0)),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            TextFormField(
              controller: exerciseController,
              onChanged: (value) {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    formData['valid'] = true;
                    formData['exercise'] = exerciseController.text;
                  });
                  this.callback(formData);
                }
              },
              decoration: InputDecoration(
                  labelText: 'Exercise', labelStyle: TextStyle(fontSize: 14.0)),
            ),
            TextFormField(
              controller: notesController,
              maxLines: 4,
              onChanged: (value) {
                if (_formKey.currentState.validate()) {
                  setState(() {
                    formData['valid'] = true;
                    formData['notes'] = notesController.text;
                  });
                  this.callback(formData);
                }
              },
              decoration: InputDecoration(
                  labelText: 'Notes', labelStyle: TextStyle(fontSize: 14.0)),
            ),
          ],
        ),
      ),
    );
  }
}
