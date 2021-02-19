import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  final String avatarImg =
      'https://static.wikia.nocookie.net/avatar/images/7/79/Pilot_-_Aang.png/revision/latest/top-crop/width/360/height/360?cb=20120311133235';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(100),
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 105,
          height: 105,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withAlpha(150),
            shape: BoxShape.circle,
          ),
        ),
        CircleAvatar(
          radius: 45.0,
          backgroundImage: NetworkImage(
            avatarImg,
          ),
        ),
      ],
    );
  }
}
