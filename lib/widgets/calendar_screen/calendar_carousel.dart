import 'package:Moodial/models/entry.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:google_fonts/google_fonts.dart';

class Calendar extends StatefulWidget {
  final List<Entry> entryList;

  Calendar(this.entryList);

  @override
  _CalendarState createState() => _CalendarState(entryList);
}

class _CalendarState extends State<Calendar> {
  List<Entry> entryList;

  _CalendarState(this.entryList);

  DateTime _currentDate = DateTime.now();
  EventList<Event> _markedDateMap = EventList();
  bool _runOnceFlag = false;

  @override
  Widget build(BuildContext context) {
    if (!_runOnceFlag && entryList != null) {
      setState(() {
        _markedDateMap = entryListToEventList(_markedDateMap, entryList);
        _runOnceFlag = !_runOnceFlag;
      });
    }

    return Container(
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() => _currentDate = date);
        },
        weekendTextStyle: GoogleFonts.montserrat(color: Colors.black),
        thisMonthDayBorderColor: Colors.transparent,
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        height: 390.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true,
        todayBorderColor: Colors.black.withOpacity(0.5),
        todayButtonColor: Colors.white,
        todayTextStyle: GoogleFonts.montserrat(color: Colors.black),
        headerTextStyle:
            GoogleFonts.montserrat(color: Colors.black, fontSize: 22),
        leftButtonIcon: Icon(
          FeatherIcons.chevronLeft,
          color: Theme.of(context).primaryColor,
        ),
        rightButtonIcon: Icon(
          FeatherIcons.chevronRight,
          color: Theme.of(context).primaryColor,
        ),
        selectedDayButtonColor: Theme.of(context).primaryColor.withOpacity(0.5),
        selectedDayBorderColor: Colors.transparent,
        daysTextStyle: GoogleFonts.montserrat(color: Colors.black),
        nextDaysTextStyle: GoogleFonts.montserrat(color: Colors.grey),
        prevDaysTextStyle: GoogleFonts.montserrat(color: Colors.grey),
        weekDayFormat: WeekdayFormat.narrow,
        weekdayTextStyle: GoogleFonts.montserrat(
            color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  EventList<Event> entryListToEventList(_markedDateMap, entryList) {
    entryList.forEach((entry) {
      _markedDateMap.add(
          DateTime.parse(entry.date),
          Event(
            id: entry.id,
            date: DateTime.parse(entry.date),
            dot: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: moodColor(entry.mood),
                shape: BoxShape.circle,
              ),
            ),
          ));
    });

    return _markedDateMap;
  }

  Color moodColor(mood) {
    switch (mood) {
      case 1:
        return Color(0xFFFBDE60);
      case 2:
        return Color(0xFF5C8FC1);
      case 3:
        return Color(0xFF3FA5C0);
      case 4:
        return Color(0xFF9F78BA);
      case 5:
        return Color(0xFFE84A6A);
      case 6:
        return Color(0xFF46C365);
      case 7:
        return Color(0xFF96C895);
    }

    return null;
  }
}
