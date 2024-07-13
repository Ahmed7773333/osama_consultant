import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorder {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  late String _filePath;

  Future<void> init() async {
    await requestMicrophonePermission();
    await _recorder.openRecorder();
    final dir = await getApplicationDocumentsDirectory();
    _filePath = '${dir.path}/audio_message_${DateTime.now()}.aac';
  }

  Future<void> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
  }

  Future<void> startRecording() async {
    await _recorder.startRecorder(toFile: _filePath);
  }

  Future<String> stopRecording() async {
    await _recorder.stopRecorder();
    return _filePath;
  }

  void dispose() {
    _recorder.closeRecorder();
  }
}
