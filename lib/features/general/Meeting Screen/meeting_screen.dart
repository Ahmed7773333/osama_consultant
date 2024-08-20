import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osama_consul/core/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen(this.userId, this.token, this.channel, {super.key});
  final String token;
  final String channel;
  final int userId;

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool _isMuted = false;
  bool _isCameraOff = false;
  bool _remoteVideoEnabled = true;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // Retrieve permissions
    await _handlePermissions();

    // Create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: Constants.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
        onRemoteVideoStateChanged: (RtcConnection connection,
            int uid,
            RemoteVideoState state,
            RemoteVideoStateReason reason,
            int elapsed) {
          if (uid == _remoteUid) {
            setState(() {
              _remoteVideoEnabled =
                  state == RemoteVideoState.remoteVideoStateDecoding ||
                      state == RemoteVideoState.remoteVideoStateStarting;
            });
          }
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: widget.token,
      channelId: widget.channel,
      uid: widget.userId,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _handlePermissions() async {
    final status = await [Permission.microphone, Permission.camera].request();
    final allGranted = status.values.every((status) => status.isGranted);
    if (!allGranted) {
      throw Exception("Microphone and camera permissions are required.");
    }
  }

  void _onToggleMute() {
    setState(() {
      _isMuted = !_isMuted;
    });
    _engine.muteLocalAudioStream(_isMuted);
  }

  void _onToggleCamera() {
    setState(() {
      _isCameraOff = !_isCameraOff;
    });
    _engine.muteLocalVideoStream(_isCameraOff);
  }

  void _onLeaveChannel() {
    _dispose();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100.w,
              height: 150.h,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _onToggleMute,
                    icon: Icon(
                      _isMuted ? Icons.mic_off : Icons.mic,
                    ),
                    color: _isMuted ? Colors.red : Colors.blue,
                    iconSize: 36.w,
                  ),
                  IconButton(
                    onPressed: _onToggleCamera,
                    icon: Icon(
                      _isCameraOff ? Icons.videocam_off : Icons.videocam,
                    ),
                    color: _isCameraOff ? Colors.red : Colors.blue,
                    iconSize: 36.w,
                  ),
                  IconButton(
                    onPressed: _onLeaveChannel,
                    icon: Icon(
                      Icons.call_end,
                      color: Colors.red,
                    ),
                    iconSize: 36.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    final localizations = AppLocalizations.of(context)!;

    if (_remoteUid != null) {
      return _remoteVideoEnabled
          ? AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: _engine,
                canvas: VideoCanvas(uid: _remoteUid),
                connection: RtcConnection(channelId: widget.channel),
              ),
            )
          : Text(
              localizations.remoteUserDisabledCamera,
              textAlign: TextAlign.center,
            );
    } else {
      return Text(
        localizations.pleaseWaitForRemoteUser,
        textAlign: TextAlign.center,
      );
    }
  }
}
