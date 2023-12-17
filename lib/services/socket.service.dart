import 'dart:async';
import 'dart:developer' as dev;
import 'package:promeal/services/path.api.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  late Socket socket;
  static String url = APIRoute.base;

  /*--------------------------------------------------------
  create a singleton instance of this class service,
  in other to manage the shared service.
  prevent repeatitive attempt to initialize socket.
  cannot be initiated directly except through getInstance()
  --------------------------------------------------------- */

  SocketService._();
  
  static final instance = SocketService._();

  initialize({required String userId}) async {

    socket = io(url, {
      "transports": ['websocket'],
      "query": {"userId": userId}
    });

    socket.onConnect((data) {
      dev.log("Client $userId Socket Connected! $data");
    });

    socket.onConnectError((error) {
      dev.log("Connection Error: $error");
    });

    socket.connect();
  }

   clearInstance() {
    instance.socket.disconnect();
    instance.socket.destroy();
    instance.socket.dispose();
    instance.dispose();
    socket.disconnect();
    socket.destroy();
    socket.dispose();
  }


  Future<void> reconnect({required String newCallerId}) async {
    if (socket.connected) {
     // await clearInstance();
    }

    socket = io(url, {
      "transports": ['websocket'],
      "query": {"userId": newCallerId},
    });

    socket.onConnect((data) {
      dev.log("new Client $newCallerId Socket re-Connected!");
    });

    socket.onConnectError((error) {
      dev.log("Connection Error: $error");
    });

    socket.connect();
  }


  dispose() {
    socket.disconnect();
  }
}
