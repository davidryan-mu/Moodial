import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/entry.dart';
import 'package:Moodial/models/mood.dart';
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

  Mood getMood(double value) {
    int valueToInt = value.round();
    switch (valueToInt) {
      case 1:
        return Mood(
          name: 'Happy',
          color: Color(0xFFFBDE60),
          emote: '🙂',
        );
        break;
      case 2:
        return Mood(
          name: 'Sad',
          color: Color(0xFF5C8FC1),
          emote: '🙁',
        );
        break;
      case 3:
        return Mood(
          name: 'Surprised',
          color: Color(0xFF3FA5C0),
          emote: '😮',
        );
        break;
      case 4:
        return Mood(
          name: 'Disgusted',
          color: Color(0xFF9F78BA),
          emote: '🤢',
        );
        break;
      case 5:
        return Mood(
          name: 'Angry',
          color: Color(0xFFE84A6A),
          emote: '😡',
        );
      case 6:
        return Mood(
          name: 'Fearful',
          color: Color(0xFF46C365),
          emote: '😨',
        );
        break;
      case 7:
        return Mood(
          name: 'Bad',
          color: Color(0xFF96C895),
          emote: '😔',
        );
    }

    return Mood(name: 'error');
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
                          DateFormat('dd-MM-yyyy')
                                  .format(dateFormat.parse(entry.date)) +
                              ' • ' +
                              entry.time.substring(0, 5),
                        ),
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
          height: 150,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 15.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: getMood(entry.mood.toDouble()).color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                        child: Text(
                          getMood(entry.mood.toDouble()).emote,
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    )
                  ],
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
                            getMood(entry.mood.toDouble()).name,
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
