import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_logger/shared/rive_animation.dart';

import './models/sensor.dart';

class SensorCubit extends Cubit<DeviceState> {
  SensorCubit() : super(DeviceState.Loaded);

  void reload() {
    emit(DeviceState.Refreshing);
    new Timer(new Duration(seconds: 5), () {
      print('5 secs');
      emit(DeviceState.Loaded);
    });
  }
}

class LogCubit extends Cubit<Log> {
  final Log log;
  LogCubit(this.log) : super(log);

  @override
  Log get state => super.state;

  /// Increments loading bar progress by 20%
  double _increment(val) {
    val += 0.2;
    return val;
  }

  /// Sets a log's state to [LogState.Downloading] with an animation and increments [LinearProgressIndicator] to simulate a download
  void download() {
    state.progress = _increment(state.progress);
    state.logState = LogState.Downloading;
    state.icon = RiveAnimation();
    _updateState();
  }

  void complete() {
    state.progress = 0.0;
    state.logState = LogState.Downloaded;
    state.icon = Icon(Icons.done);
    _updateState();
  }

  /// Emits new changes to a log object in a new log object to refresh the UI
  void _updateState() {
    emit(Log(
        date: state.date,
        logId: state.logId,
        progress: state.progress,
        logState: state.logState,
        icon: state.icon,
      ),
    );
  }
}
