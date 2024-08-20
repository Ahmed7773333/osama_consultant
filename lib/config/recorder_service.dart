import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioRecorderr {
  final AudioRecorder _recorder = AudioRecorder();
  late String _filePath;

  Future<void> init() async {
    await requestMicrophonePermission();
    final dir = await getApplicationDocumentsDirectory();
    _filePath = '${dir.path}/audio_message_${DateTime.now()}.aac';
  }

  Future<void> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw Exception('Microphone permission not granted');
    }
  }

  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      await _recorder.start(const RecordConfig(), path: _filePath);
    }
  }

  Future<String> stopRecording() async {
    await _recorder.stop();
    return _filePath;
  }

  void dispose() {
    _recorder.dispose();
  }
}
