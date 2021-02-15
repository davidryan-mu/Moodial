import 'package:Moodial/api_service/api.dart';
import 'package:Moodial/models/entry.dart';
import 'package:Moodial/widgets/home_screen/add_entry_dial.dart';
import 'package:Moodial/widgets/home_screen/update_entry_form.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentEntryCard extends StatefulWidget {
  final Entry entry;
  final String userToken;
  final Function callback;

  RecentEntryCard({
    this.entry,
    this.userToken,
    this.callback,
  });

  @override
  _RecentEntryCardState createState() => _RecentEntryCardState(
        entry: this.entry,
        userToken: this.userToken,
        callback: this.callback,
      );
}

class _RecentEntryCardState extends State<RecentEntryCard> {
  Entry entry;
  String userToken;
  Function callback;

  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  _RecentEntryCardState({
    this.entry,
    this.userToken,
    this.callback,
  });

  Map<String, dynamic> formState;
  int dialState;
  bool _overwritten = false;

  sliderCallback(sliderValue) {
    setState(() {
      print(dialState);
      this.dialState = sliderValue;
    });
  }

  formCallback(formData) {
    setState(() {
      this.formState = formData;
    });
  }

  void overwriteDialState() {
    if (!_overwritten) {
      setState(() {
        dialState = entry.mood;
      });
      _overwritten = !_overwritten;
    }
  }

  showModal() {
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
                    onPressed: () {
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
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    AddEntryDial(
                      sliderValue: entry.mood.toDouble(),
                      callback: this.sliderCallback,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            DateFormat('dd-MM-yyyy').format(DateTime.now()) +
                                ' • ' +
                                DateFormat('H:mm').format(DateTime.now())),
                      ),
                    ),
                    UpdateEntryForm(this.formCallback, this.entry),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text('UPDATE'),
                        onPressed: () {
                          print(dialState);
                          formState['mood'] = dialState;
                          if (formState['valid'] == true) {
                            ApiService.updateEntry(
                              userToken,
                              formState,
                              entry.id,
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
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    overwriteDialState();

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: InkWell(
        onTap: () => showModal(),
        child: Container(
          width: 300,
          height: 130,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mood ' + entry.mood.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                          ),
                          Text(
                            DateFormat('dd-MM-yyyy')
                                .format(dateFormat.parse(entry.date)),
                          ),
                          SizedBox(height: 20.0),
                          TextButton.icon(
                            onPressed: () {
                              showModal();
                            },
                            label: Text(
                              'View/Edit',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            icon: Icon(
                              FeatherIcons.edit,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Medication:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(entry.medication.name +
                              ' - ' +
                              entry.medication.dose),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            'Diet:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(entry.diet.food + ' - ' + entry.diet.amount),
                        ],
                      ),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
