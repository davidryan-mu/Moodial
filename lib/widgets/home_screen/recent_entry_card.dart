import 'package:Moodial/services/api.dart';
import 'package:Moodial/models/entry.dart';
import 'package:Moodial/services/mood_props.dart';
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

  Map<String, dynamic> formState = {};
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

  showModal() {
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
                          padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(DateFormat('dd-MM-yyyy')
                                    .format(DateTime.now()) +
                                ' • ' +
                                DateFormat('H:mm').format(DateTime.now())),
                          ),
                        ),
                        UpdateEntryForm(this.formCallback, this.entry),
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
                        showModalBottomSheet(
                            backgroundColor: Color.fromRGBO(0, 0, 0, 0),
                            context: context,
                            builder: (BuildContext context) {
                              return Align(
                                alignment: Alignment.topCenter,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      color: Color.fromRGBO(0, 0, 0, 0),
                                      child: Container(
                                        height: 330,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: ListView(
                                            children: [
                                              Container(
                                                constraints: BoxConstraints(
                                                  maxHeight: 120,
                                                  maxWidth: 120,
                                                ),
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/images/sent.gif'),
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'We got it!',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    'Your updates have been successfully sent to our database. You can always come back and make changes or add information when you have time.'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SafeArea(
                                      minimum: EdgeInsets.all(15),
                                      child: SizedBox(
                                        width: double.infinity,
                                        height: 40.0,
                                        child: ElevatedButton(
                                          child: Text('OKAY'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Theme.of(context)
                                                          .primaryColor)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
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
          width: double.infinity,
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
                          color:
                              MoodProps.moodColor(entry.mood).withOpacity(0.7),
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
                        child: Container(
                          child: MoodProps.moodEmoji(entry.mood),
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
                            MoodProps.moodValueToString(entry.mood),
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
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 130),
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
