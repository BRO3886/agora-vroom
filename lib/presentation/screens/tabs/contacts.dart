import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  static const routename = "/contacts";

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('Contacts and Channels'),
        actions: <Widget>[
          PopupMenuButton(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            icon: Icon(Icons.add),
            color: Theme.of(context).canvasColor,
            offset: Offset(0, 100),
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text('Add Contact'),
                  value: 'Add Contact',
                ),
                PopupMenuItem(
                  child: Text('Create New Channel'),
                  value: 'Create New Channel',
                ),
                PopupMenuItem(
                  child: Text('Join Public Channel'),
                  value: 'Join Public Channel',
                ),
                PopupMenuItem(
                  child: Text('Add an App'),
                  value: 'Add an App',
                ),
              ];
            },
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.blue[200],
          controller: _controller,
          tabs: <Widget>[
            Tab(
              text: 'Contacts',
            ),
            Tab(
              text: 'Channels',
            ),
          ],
        ),
      ),
      body: TabBarView(
        physics: ClampingScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          Container(
            child: Center(child: Text('Contacts')),
          ),
          Container(
            child: Center(child: Text('Channels')),
          ),
        ],
      ),
    );
  }
}
