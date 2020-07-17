import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_vroom/utils/presentation/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/settings.dart';

class MeetingScreen extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// non-modifiable client role of the page
  final ClientRole role;

  /// Creates a call page with given channel name.
  const MeetingScreen({
    Key key,
    @required this.channelName,
    @required this.role,
  }) : super(key: key);

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool videoMuted = false;
  bool hideOverlay = false;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (AppID.isEmpty) {
      setState(() {
        _updateInfoStrings(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        // _infoStrings.add(
        //   'APP_ID missing, please provide your APP_ID in settings.dart',
        // );
        // _infoStrings.add('Agora Engine is not starting');
        _updateInfoStrings('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = Size(1920, 1080);
    await AgoraRtcEngine.setVideoEncoderConfiguration(configuration);
    await AgoraRtcEngine.joinChannel(null, widget.channelName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(AppID);
    await AgoraRtcEngine.enableVideo();
    await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await AgoraRtcEngine.setClientRole(widget.role);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        // _infoStrings.add(info);
        _updateInfoStrings(info);
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        // _infoStrings.add(info);
        _updateInfoStrings(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        // _infoStrings.add('onLeaveChannel');
        _updateInfoStrings('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        // _infoStrings.add(info);
        _updateInfoStrings(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      setState(() {
        final info = 'userOffline: $uid';
        // _infoStrings.add(info);
        _updateInfoStrings(info);
        _users.remove(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        // _infoStrings.add(info);
        _updateInfoStrings(info);
      });
    };
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(AgoraRenderWidget(0, local: true, preview: true));
    }
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar() {
    if (widget.role == ClientRole.Audience) return Container();
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      color: Colors.black.withOpacity(0.75),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              MaterialButton(
                onPressed: _onVideoStreamClose,
                child: Icon(
                  videoMuted ? Icons.videocam_off : Icons.videocam,
                  color: videoMuted ? Colors.red : Colors.white,
                  size: 30.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                padding: EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 12,
                ),
              ),
              Text(
                'Video',
                style:
                    SmallTextStyle.copyWith(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              RawMaterialButton(
                onPressed: _onToggleMute,
                child: Icon(
                  muted ? Icons.mic_off : Icons.mic,
                  color: muted ? Colors.red : Colors.white,
                  size: 30.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 12,
                ),
              ),
              Text(
                'Audio',
                style:
                    SmallTextStyle.copyWith(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              RawMaterialButton(
                onPressed: _onSwitchCamera,
                child: Icon(
                  Icons.switch_video,
                  color: Colors.white,
                  size: 30.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 12,
                ),
              ),
              Text(
                'Switch Video',
                style:
                    SmallTextStyle.copyWith(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {},
                // onPressed: _onSwitchCamera,
                child: Icon(
                  Icons.message,
                  color: Colors.white,
                  size: 30.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                // fillColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                  vertical: 12,
                ),
              ),
              Text(
                'Chat',
                style:
                    SmallTextStyle.copyWith(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return null;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _updateInfoStrings(String string) {
    setState(() {
      _infoStrings.add(string);
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _infoStrings.removeLast();
        print(_infoStrings);
      });
    });
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onVideoStreamClose() {
    setState(() {
      videoMuted = !videoMuted;
    });
    AgoraRtcEngine.muteLocalVideoStream(videoMuted);
    if (videoMuted) {
      _updateInfoStrings("Your video is not being streamed");
      // _infoStrings.add("Your video is not being streamed");
    } else {
      _updateInfoStrings("Your video is now being streamed to all");
      // _infoStrings.add("Your video is now being streamed to all");
    }
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  _hideToolbar() {
    setState(() {
      hideOverlay = !hideOverlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            // color: Colors.redAccent,
            onPressed: () => _onCallEnd(context),
          ),
        ],
        title: Text('Meeting: ${widget.channelName}'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: _hideToolbar,
          onDoubleTap: _onSwitchCamera,
          child: Stack(
            children: <Widget>[
              _viewRows(),
              _panel(),
              Positioned(
                bottom: 0,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: hideOverlay ? 0 : 1,
                  child: _toolbar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
