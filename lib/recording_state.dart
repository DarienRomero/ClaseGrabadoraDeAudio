enum RecordingState { free, recording, blocked, paused }

extension RecordingStateExtension on RecordingState {
  bool get isRecording => (this == RecordingState.recording) || (this == RecordingState.blocked);
  bool get isBlocked => this == RecordingState.blocked;
}