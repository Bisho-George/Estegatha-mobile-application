import 'package:socket_io_client/socket_io_client.dart' as IO;

class TrackApi {
  Future<void> trackEvent({
    required String name,
    required int orgId,
    required void Function(dynamic) callback,
  }) async {
    final options = IO.OptionBuilder()
        .setTransports(['websocket'])
        .setQuery({'orgId': orgId})
        .build();
    final socket = IO.io('http://192.168.1.38:9000/', options);
    socket.on(name, callback);
    socket.connect();

  }
  Future<void> shareLocation({
    required String name,
    required int orgId,
    dynamic data
  }) async {
    final options = IO.OptionBuilder()
        .setTransports(['websocket'])
        .setQuery({'orgId': orgId})
        .build();
    final socket = IO.io('http://192.168.1.38:9000/', options);
    socket.on(name, data);
    socket.connect();
  }

}
