import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'video_call_event.dart';
part 'video_call_state.dart';

class VideoCallBloc extends Bloc<VideoCallEvent, VideoCallState> {
  VideoCallBloc() : super(VideoCallInitial());

  @override
  Stream<VideoCallState> mapEventToState(
    VideoCallEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
