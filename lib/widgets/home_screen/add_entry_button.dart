import 'package:Moodial/widgets/home_screen/add_entry_dial.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_entry_form.dart';

class AddEntryButton extends StatefulWidget {
  final int dialState;
  final UniqueKey key;

  AddEntryButton({this.dialState, this.key});

  @override
  _AddEntryButtonState createState() => _AddEntryButtonState(
        dialState: this.dialState,
        key: this.key,
      );
}

class _AddEntryButtonState extends State<AddEntryButton> {
  int dialState;
  UniqueKey key;
  Map<String, dynamic> formState;

  _AddEntryButtonState({this.dialState, this.key});

  sliderCallback(sliderValue) {
    setState(() {
      this.dialState = sliderValue;
    });
  }

  formCallback(formData) {
    setState(() {
      this.formState = formData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50.0,
        vertical: 10.0,
      ),
      child: ElevatedButton(
        child: Text('Add Entry'),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0),
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                color: Color.fromRGBO(0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                      child: IconButton(
                          icon: Icon(FeatherIcons.x),
                          color: Colors.white,
                          iconSize: 40.0,
                          onPressed: () => Navigator.pop(context)),
                    ),
                    Container(
                      height: 660,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          AddEntryDial(
                            sliderValue: dialState.toDouble(),
                            callback: this.sliderCallback,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(DateFormat('dd-MM-yyyy')
                                      .format(DateTime.now()) +
                                  ' • ' +
                                  DateFormat('H:mm').format(DateTime.now())),
                            ),
                          ),
                          AddEntryForm(this.formCallback),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 40.0,
                            child: ElevatedButton(
                              child: Text('SAVE'),
                              onPressed: () {
                                formState['mood'] = dialState;
                                print(formState);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Theme.of(context).primaryColor)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
