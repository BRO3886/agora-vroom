import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/presentation/styles.dart';
import '../../widgets/icon_button.dart';
import '../meeting.dart';

class HomeScreen extends StatefulWidget {
  static const routename = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        title: Text('Meet & Chat'),
        leading: IconButton(
          icon: Icon(Icons.star),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            color: Theme.of(context).canvasColor,
            child: ClipRRect(
              borderRadius: borderRadius10,
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                  ),
                  hintText: 'Search',
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[300],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomIconButton(
                  color: Colors.orange,
                  icon: Icons.video_call,
                  onPressed: () {},
                  heading: 'New Meeting',
                ),
                SizedBox(
                  width: 10,
                ),
                CustomIconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.add_box,
                  heading: 'Join',
                  onPressed: _openOverlay,
                ),
                SizedBox(
                  width: 10,
                ),
                CustomIconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.calendar_today,
                  onPressed: () {},
                  heading: 'Schedule',
                ),
                SizedBox(
                  width: 10,
                ),
                CustomIconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icons.screen_share,
                  onPressed: () {},
                  heading: 'Share Screen',
                ),
              ],
            ),
            Divider(
              thickness: 10,
              color: Colors.grey[300],
            )
          ],
        ),
      ),
    );
  }
}
