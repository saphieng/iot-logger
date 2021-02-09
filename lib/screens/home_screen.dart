import 'package:flutter/material.dart';

import '../models/sensor.dart';
import '../shared/layout.dart';
import '../widgets/sensor_item.dart';
import '../shared/refresh_button.dart';

class HomeScreen extends StatelessWidget {
  final List<Sensor> sensors = [
    Sensor(
        id: '1',
        name: 'Water Tank',
        status: Status.Connected,
        iconPath: 'plug',
        logs: [
          Log(
            date: DateTime.now(),
            logId: '1',
            progress: 0.0,
            logState: LogState.Loaded,
          ),
          Log(
            date: DateTime.now(),
            logId: '2',
            progress: 0.0,
            logState: LogState.Loaded,
          ),
        ]),
    // Sensor(
    //   id: '2',
    //   name: 'Sewerage',
    //   status: Status.Idle,
    //   iconPath: 'plug',
    // ),
    Sensor(
      id: '3',
      name: 'Pump',
      status: Status.Disconnected,
      iconPath: 'plug',
      state: DeviceState.Refreshing,
    ),
    Sensor(
      id: '4',
      name: 'Air Con',
      status: Status.Connected,
      iconPath: 'download-light',
      // state: DeviceState.Downloading,
    ),
  ];

  void refresh() {
    print('homepage refresh');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Your Sensor',
              style: Theme.of(context).textTheme.headline1,
            ),
            Column(
              children: sensors.map((sensor) => SensorItem(sensor)).toList(),
            ),
            RefreshButton(refresh),
          ],
        ),
      ),
    );
  }
}
