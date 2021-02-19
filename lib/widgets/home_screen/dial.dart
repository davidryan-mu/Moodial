import 'package:flutter/material.dart';

class Dial extends StatefulWidget {
  final Function callback;

  Dial({this.callback});

  @override
  _DialState createState() => _DialState(
        callback: this.callback,
      );
}

class _DialState extends State<Dial> {
  double _currentSliderValue = 1;
  Function callback;

  _DialState({this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 10.0,
              right: 20.0,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SliderIndicator(
                  value: '🙂',
                  color: Color(0xFFFBDE60),
                ),
                SliderIndicator(
                  value: '🙁',
                  color: Color(0xFF5C8FC1),
                ),
                SliderIndicator(
                  value: '😮',
                  color: Color(0xFF3FA5C0),
                ),
                SliderIndicator(
                  value: '🤢',
                  color: Color(0xFF9F78BA),
                ),
                SliderIndicator(
                  value: '😡',
                  color: Color(0xFFE84A6A),
                ),
                SliderIndicator(
                  value: '😨',
                  color: Color(0xFF46C365),
                ),
                SliderIndicator(
                  value: '😔',
                  color: Color(0xFF96C895),
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
                min: 1,
                max: 7,
                divisions: 6,
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });

                  this.callback(value.round());
                }),
          ),
          Text(
            toMood(_currentSliderValue),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
            ),
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            width: double.infinity,
            height: 20.0,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 25.0,
            ),
          )
        ],
      ),
    );
  }
}

String toMood(double value) {
  int valueToInt = value.round();
  switch (valueToInt) {
    case 1:
      return 'Happy';
      break;
    case 2:
      return 'Sad';
      break;
    case 3:
      return 'Surprised';
      break;
    case 4:
      return 'Disgusted';
      break;
    case 5:
      return 'Angry';
    case 6:
      return 'Fearful';
    case 7:
      return 'Bad';
  }

  return 'Error';
}
