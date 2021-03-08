import 'package:Moodial/services/api.dart';
import 'package:Moodial/widgets/home_screen/add_entry_dial.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_entry_form.dart';

class AddEntryButton extends StatefulWidget {
  final int dialState;
  final UniqueKey key;
  final String userToken;
  final Function callback;

  AddEntryButton({
    this.dialState,
    this.key,
    this.userToken,
    this.callback,
  });

  @override
  _AddEntryButtonState createState() => _AddEntryButtonState(
        dialState: this.dialState,
        key: this.key,
        userToken: this.userToken,
        callback: this.callback,
      );
}

class _AddEntryButtonState extends State<AddEntryButton> {
  int dialState;
  UniqueKey key;
  String userToken;
  Function callback;

  Map<String, dynamic> formState;

  _AddEntryButtonState({
    this.dialState,
    this.key,
    this.userToken,
    this.callback,
  });

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
        child: Text('Add Entry',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            )),
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: Color.fromRGBO(0, 0, 0, 0),
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    color: Color.fromRGBO(0, 0, 0, 0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                              icon: Icon(FeatherIcons.x),
                              color: Colors.white,
                              iconSize: 40.0,
                              onPressed: () {
                                this.callback(false);
                                Navigator.pop(context);
                              }),
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
                          child: Column(
                            children: [
                              AddEntryDial(
                                sliderValue: dialState.toDouble(),
                                callback: this.sliderCallback,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(DateFormat('dd-MM-yyyy')
                                          .format(DateTime.now()) +
                                      ' • ' +
                                      DateFormat('H:mm')
                                          .format(DateTime.now())),
                                ),
                              ),
                              AddEntryForm(this.formCallback),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    minimum: EdgeInsets.all(15),
                    child: SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text('SAVE'),
                        onPressed: () {
                          formState['mood'] = dialState;
                          if (formState['valid'] == true) {
                            ApiService.postEntry(
                              userToken,
                              formState,
                            ).then((response) {
                              this.callback(false);
                              Navigator.pop(context);
                            });
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Theme.of(context).primaryColor)),
                      ),
                    ),
                  )
                ],
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
