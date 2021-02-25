import 'dart:math';

import 'package:Moodial/models/entry.dart';

class DummyEntries {
  final List<Entry> list;

  DummyEntries({this.list});

  factory DummyEntries.getList() {
    List<Entry> dummyEntries = [];
    final _random = new Random();

    List<String> foodValues = [
      'Chicken',
      'Veg',
      'Pasta',
      'Chocolate',
      'Sweets',
      'Fruit',
      'Nothing',
    ];

    for (int i = 1; i < 15; i++) {
      dummyEntries.add(
        Entry(
          id: i,
          date: '2021-02-0' + i.toString(),
          time: '20:45:20',
          mood: _random.nextInt(7) + 1,
          sleep: _random.nextInt(10),
          iritability: _random.nextInt(10),
          medication: Medication(
            name: 'Meds',
            dose: '10mg',
          ),
          diet: Diet(
            food: foodValues[_random.nextInt(7)],
            amount: '100g',
          ),
          exercise: 'run',
          notes: 'some notes',
        ),
      );
    }

    return DummyEntries(list: dummyEntries);
  }
}
