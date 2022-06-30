// import 'dart:async';
// import 'package:audio_session/audio_session.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import '../../../../json_schema_ui/models/widget_data.dart';
// import 'widget_ui.dart';
//
// typedef _Fn = void Function();
//
// const theSource = AudioSource.microphone;
//
// /// Example app.
// class AudioWidget extends StatefulWidget {
//   const AudioWidget({Key? key, required this.widgetData}) : super(key: key);
//
//   final WidgetData widgetData;
//
//   @override
//   _AudioWidgetState createState() => _AudioWidgetState();
// }
//
// class _AudioWidgetState extends State<AudioWidget> {
//   Codec _codec = Codec.aacMP4;
//   String _mPath = 'tau_file.mp4';
//   FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
//   FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
//   bool _mPlayerIsInited = false;
//   bool _mRecorderIsInited = false;
//   bool _mplaybackReady = false;
//   String title = '';
//   String description = '';
//
//   @override
//   void initState() {
//     _mPlayer!.openPlayer().then((value) {
//       setState(() {
//         _mPlayerIsInited = true;
//         title = widget.widgetData.schema['title'] ?? '';
//         description = widget.widgetData.schema['description'] ?? '';
//       });
//     });
//
//     openTheRecorder().then((value) {
//       setState(() {
//         _mRecorderIsInited = true;
//       });
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _mPlayer!.closePlayer();
//     _mPlayer = null;
//
//     _mRecorder!.closeRecorder();
//     _mRecorder = null;
//     super.dispose();
//   }
//
//   Future<void> openTheRecorder() async {
//     if (!kIsWeb) {
//       var status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         throw RecordingPermissionException('Microphone permission not granted');
//       }
//     }
//     await _mRecorder!.openRecorder();
//     if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
//       _codec = Codec.opusWebM;
//       _mPath = 'tau_file.webm';
//       if (!await _mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
//         _mRecorderIsInited = true;
//         return;
//       }
//     }
//     final session = await AudioSession.instance;
//     await session.configure(AudioSessionConfiguration(
//       avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
//       avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth |
//           AVAudioSessionCategoryOptions.defaultToSpeaker,
//       avAudioSessionMode: AVAudioSessionMode.spokenAudio,
//       avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
//       avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
//       androidAudioAttributes: const AndroidAudioAttributes(
//         contentType: AndroidAudioContentType.speech,
//         flags: AndroidAudioFlags.none,
//         usage: AndroidAudioUsage.voiceCommunication,
//       ),
//       androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
//       androidWillPauseWhenDucked: true,
//     ));
//
//     _mRecorderIsInited = true;
//   }
//
//   // ----------------------  Here is the code for recording and playback -------
//
//   void record() {
//     _mRecorder!
//         .startRecorder(
//       toFile: _mPath,
//       codec: _codec,
//       audioSource: theSource,
//     )
//         .then((value) {
//       setState(() {});
//     });
//   }
//
//   void stopRecorder() async {
//     await _mRecorder!.stopRecorder().then((value) {
//       setState(() {
//         //var url = value;
//         _mplaybackReady = true;
//       });
//     });
//   }
//
//   void play() {
//     assert(_mPlayerIsInited && _mplaybackReady && _mRecorder!.isStopped && _mPlayer!.isStopped);
//     _mPlayer!
//         .startPlayer(
//             fromURI: _mPath,
//             //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
//             whenFinished: () {
//               setState(() {});
//             })
//         .then((value) {
//       setState(() {});
//     });
//   }
//
//   void stopPlayer() {
//     _mPlayer!.stopPlayer().then((value) {
//       setState(() {});
//     });
//   }
//
// // ----------------------------- UI --------------------------------------------
//
//   _Fn? getRecorderFn() {
//     if (!_mRecorderIsInited || !_mPlayer!.isStopped) {
//       return null;
//     }
//     return _mRecorder!.isStopped ? record : stopRecorder;
//   }
//
//   _Fn? getPlaybackFn() {
//     if (!_mPlayerIsInited || !_mplaybackReady || !_mRecorder!.isStopped) {
//       return null;
//     }
//     return _mPlayer!.isStopped ? play : stopPlayer;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WidgetUI(
//       title: title,
//       description: description,
//       child: Row(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: getRecorderFn(),
//                 icon: Icon(
//                   _mRecorder!.isRecording ? Icons.stop_circle_outlined : Icons.mic,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(_mRecorder!.isRecording ? 'Recording in progress' : 'Recorder is stopped')
//             ],
//           ),
//           const SizedBox(width: 8),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: getPlaybackFn(),
//                 icon: Icon(
//                   _mPlayer!.isPlaying ? Icons.stop_circle_outlined : Icons.play_arrow,
//                   color: Colors.black,
//                 ),
//               ),
//               Text(_mPlayer!.isPlaying ? 'Playback in progress' : 'Player is stopped'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
