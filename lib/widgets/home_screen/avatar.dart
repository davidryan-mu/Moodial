import 'package:Moodial/models/user.dart';
import 'package:flutter/material.dart';

class Avatar extends StatefulWidget {
  final User user;

  Avatar({this.user});

  @override
  _AvatarState createState() => _AvatarState(user: this.user);
}

class _AvatarState extends State<Avatar> {
  User user;

  _AvatarState({this.user});

  final String defaultAvatarLink =
      'https://static.wikia.nocookie.net/avatar/images/7/79/Pilot_-_Aang.png/revision/latest/top-crop/width/360/height/360?cb=20120311133235';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(100),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 115,
            height: 115,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withAlpha(150),
              shape: BoxShape.circle,
            ),
          ),
          user.avatarLink == null
              ? CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                    defaultAvatarLink,
                  ),
                )
              : CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                    user.avatarLink,
                  ),
                ),
        ],
      ),
    );
  }
}
