import 'package:Moodial/api_service/api.dart';
import 'package:Moodial/models/user.dart';
import 'package:Moodial/widgets/settings_screen/avatar.dart';
import 'package:Moodial/widgets/navbar.dart';
import 'package:Moodial/widgets/settings_screen/settings_button.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final User user;
  final Function navPosCallback;
  final Function logOutCallback;
  final Function avatarChangeCallback;

  SettingsScreen({
    this.user,
    this.navPosCallback,
    this.logOutCallback,
    this.avatarChangeCallback,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState(
        user: this.user,
        navPosCallback: this.navPosCallback,
        logOutCallback: this.logOutCallback,
        avatarChangeCallback: this.avatarChangeCallback,
      );
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _currentTab = 3;
  User user;
  Function navPosCallback;
  Function logOutCallback;
  Function avatarChangeCallback;

  final avatarLinkController = TextEditingController();

  _SettingsScreenState({
    this.user,
    this.navPosCallback,
    this.logOutCallback,
    this.avatarChangeCallback,
  });

  showDeleteModal() {
    showModalBottomSheet(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Color.fromRGBO(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: IconButton(
                    icon: Icon(FeatherIcons.x),
                    color: Colors.white,
                    iconSize: 40.0,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Icon(FeatherIcons.alertOctagon, size: 40.0),
                        Text(
                          'WARNING',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                          child: Text(
                              'Pressing the Delete button will permanently delete your user data from our database.\n\nIf this data is important to you, we strongly recommend backing it up or not deleting your account. You can press the X icon above to leave this screen and preserve your data.'),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text('DELETE'),
                        onPressed: () {
                          ApiService.deleteUser(user.userToken, user.username)
                              .then((response) {
                            if (response == 'User and entries deleted') {
                              this.logOutCallback();
                            }
                            Navigator.pop(context);
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFE84A6A))),
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

  showAvatarChangeModal() {
    showModalBottomSheet(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Color.fromRGBO(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: IconButton(
                    icon: Icon(FeatherIcons.x),
                    color: Colors.white,
                    iconSize: 40.0,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Avatar(
                          user: user,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                          child: Form(
                            child: TextFormField(
                              controller: avatarLinkController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a valid image URL';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Link',
                              ),
                              enableSuggestions: false,
                              autocorrect: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40.0,
                      child: ElevatedButton(
                        child: Text('UPDATE'),
                        onPressed: () {
                          avatarChangeCallback(avatarLinkController.text);
                          Navigator.pop(context);
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
  void dispose() {
    // Clean up the controller when the widget is disposed.
    avatarLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  FeatherIcons.bell,
                  color: Colors.white,
                ),
                onPressed: () => print('notif pressed'),
              )
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0,
                        ),
                      ),
                      Avatar(
                        user: user,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: [
                    SettingsButton(
                      color: Color(0xFF3FA5C0),
                      callback: () => showAvatarChangeModal(),
                      icon: Icon(FeatherIcons.user, size: 40.0),
                      label: 'Avatar',
                      subtext: 'Use a valid image URL as your avatar!',
                    ),
                    SettingsButton(
                      color: Color(0xFFFBDE60),
                      callback: () {
                        this.logOutCallback();
                        this.navPosCallback(0);
                      },
                      icon: Icon(FeatherIcons.logOut, size: 40.0),
                      label: 'Log out',
                      subtext: 'See you soon!',
                    ),
                    SettingsButton(
                      color: Color(0xFFE84A6A),
                      callback: showDeleteModal,
                      icon: Icon(FeatherIcons.alertOctagon, size: 40.0),
                      label: 'Delete',
                      subtext:
                          'Remove this user and it\'s entries from our database',
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: NavBar(
        currentTab: _currentTab,
        callback: navPosCallback,
      ),
    );
  }
}
