import '../models/sensor.dart';

class DownloadService {
  LogStatus status;
  double progress = 0.0;

  DownloadService();

  double _increment(double val) {
    return val + 0.2;
  }

  downloadLog() {
    this.status = LogStatus.Downloading;
    this.progress = _increment(this.progress);
    if (this.progress == 1) print('Download via service complete');
  }

  LogStatus getStatus() {
    return this.status;
  }

  double getProgress() {
    return this.progress;
  }
}
