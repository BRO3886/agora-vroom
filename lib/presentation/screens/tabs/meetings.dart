import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_vroom/presentation/screens/meeting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/presentation/styles.dart';

class MeetingsScreen extends StatefulWidget {
  static const routename = "/meetings";

  @override
  _MeetingsScreenState createState() => _MeetingsScreenState();
}

class _MeetingsScreenState extends State<MeetingsScreen> {
  TextEditingController _channelController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  _getPermissions() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }

  _joinChannel(ClientRole role) async {
    if (_formKey.currentState.validate()) {
      await _getPermissions();
      await Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          maintainState: false,
          builder: (context) => MeetingScreen(
            channelName: _channelController.text,
            role: role,
          ),
        ),
      );
    }
  }

  _openOverlay() {
    ClientRole _role = ClientRole.Broadcaster;
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setNewState) => AlertDialog(
          title: Text('Enter Channel Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _channelController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: borderRadius10,
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey[200],
                    filled: true,
                    hintText: 'Enter Channel Name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'channel name is required';
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RadioListTile<ClientRole>(
                title: Text('Broadcaster'),
                groupValue: _role,
                value: ClientRole.Broadcaster,
                onChanged: (value) {
                  setNewState(() {
                    _role = value;
                  });
                },
              ),
              RadioListTile<ClientRole>(
                title: Text('Audience'),
                groupValue: _role,
                value: ClientRole.Audience,
                onChanged: (value) {
                  setNewState(() {
                    _role = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'JOIN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onPressed: () => _joinChannel(_role),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Meetings'),
        // leading: IconButton(
        //   icon: Icon(Icons.star),
        //   onPressed: () {},
        // ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                elevation: 0,
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Personal Meeting ID',
                        style: SmallTextStyle.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '651-10292-7827',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          OutlineButton(
                            textColor: Theme.of(context).primaryColor,
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('START'),
                            onPressed: _openOverlay,
                          ),
                          OutlineButton(
                            textColor: Theme.of(context).primaryColor,
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('SEND INVITATION'),
                            onPressed: () {},
                          ),
                          OutlineButton(
                            textColor: Theme.of(context).primaryColor,
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('EDIT'),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
