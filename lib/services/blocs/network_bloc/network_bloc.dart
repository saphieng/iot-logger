import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_logger/services/blocs/network_bloc/network_event.dart';
import 'package:iot_logger/services/blocs/network_bloc/network_state.dart';
import 'package:connectivity/connectivity.dart';
import 'package:wifi_info_flutter/wifi_info_flutter.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(WifiDisconnected());

  StreamSubscription _subscription;
  final Connectivity _connectivity = Connectivity();
  String wifiName, wifiIP;
  bool isConnectedToWifi = false;

  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event) async* {
    if (event is ListenConnection) {
      _subscription = _connectivity.onConnectivityChanged.listen(
        (status) async {
          var connectivityResult = await (Connectivity().checkConnectivity());
          print('Connection Change Detected: $connectivityResult');
          try {
            wifiName = await WifiInfo().getWifiName();
            wifiIP = await WifiInfo().getWifiIP();
            if (wifiIP == null) {
              isConnectedToWifi = false;
              print('Could not find IP (most likely cellular network)');
              add(ConnectionChanged(WifiDisconnected()));
            } else {
              isConnectedToWifi = true;
              print('Wifi Connected: $wifiName $wifiIP');
              add(ConnectionChanged(WifiConnected()));
            }
          } on PlatformException catch (e) {
            isConnectedToWifi = false;
            print(e.toString());
            add(ConnectionChanged(WifiDisconnected()));
            print('Error Connecting to Wifi Network');
          } catch (e) {
            isConnectedToWifi = false;
            print(e.toString());
            print('Error Connecting to Wifi Network');
            add(ConnectionChanged(WifiDisconnected()));
          }
        },
      );
    }
    if (event is ConnectionChanged) yield event.connection;
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}