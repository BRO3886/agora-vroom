part of 'video_call_bloc.dart';

abstract class VideoCallState extends Equatable {
  const VideoCallState();
}

class VideoCallInitial extends VideoCallState {
  @override
  List<Object> get props => [];
}

class VideoCallConnecting extends VideoCallState {
  @override
  List<Object> get props => [];
}



class VideoCallEnd extends VideoCallState {
  @override
  List<Object> get props => [];
}

class VideoCallError extends VideoCallState {
  @override
  List<Object> get props => [];
}
