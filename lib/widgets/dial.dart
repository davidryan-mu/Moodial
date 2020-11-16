import 'package:flutter/material.dart';

class Dial extends StatefulWidget {
  @override
  _DialState createState() => _DialState();
}

class _DialState extends State<Dial> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 20.0,
              right: 20.0,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SliderIndicator(
                  value: ': \u0028',
                  color: Colors.red,
                ),
                SliderIndicator(
                  value: ': \u002F',
                  color: Colors.pink,
                ),
                SliderIndicator(
                  value: ': \u007C',
                  color: Colors.blue,
                ),
                SliderIndicator(
                  value: ': \u0029',
                  color: Colors.yellow,
                ),
                SliderIndicator(
                  value: ':D',
                  color: Colors.green,
                ),
              ],
            ),
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveTrackColor: Colors.grey[400],
              thumbColor: Theme.of(context).primaryColor,
              overlayColor: Theme.of(context).primaryColor.withAlpha(32),
              inactiveTickMarkColor: Theme.of(context).primaryColor,
            ),
            child: Slider(
                value: _currentSliderValue,
                min: 0,
                max: 4,
                divisions: 4,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                }),
          ),
          Text(
            toMood(_currentSliderValue),
          ),
        ],
      ),
    );
  }
}

class SliderIndicator extends StatelessWidget {
  SliderIndicator({Key key, this.value, this.color}) : super(key: key);
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        child: Center(
          child: Text(
            value,
            style: TextStyle(),
          ),
        ),
      ),
    );
  }
}

String toMood(double value) {
  int valueToInt = value.round();
  switch (valueToInt) {
    case 0:
      return 'Awful';
      break;
    case 1:
      return 'Poor';
      break;
    case 2:
      return 'Okay';
      break;
    case 3:
      return 'Good';
      break;
    case 4:
      return 'Great';
  }

  return 'Error';
}
