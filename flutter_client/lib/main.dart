import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'dart:async';
import 'src/generated/service.pbgrpc.dart'; // Ensure this is generated from the updated .proto file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter gRPC Streaming Demo',
      home: Scaffold(
        appBar: AppBar(title: Text('gRPC Streaming Example')),
        body: Center(child: HelloWorldWidget()),
      ),
    );
  }
}

class HelloWorldWidget extends StatefulWidget {
  @override
  _HelloWorldWidgetState createState() => _HelloWorldWidgetState();
}

class _HelloWorldWidgetState extends State<HelloWorldWidget> {
  String _greeting = 'Press a button to say hello';
  List<String> _streamMessages = [];
  Stream<HelloReply>? _stream;
  ClientChannel? _channel;
  GreeterClient? _stub;
  bool _isStreaming = false;
  StreamSubscription<HelloReply>? _streamSubscription;
  String _lastLanguage = 'en'; // Default language is English

  Future<void> _sayHello(String language) async {
    final channel = ClientChannel(
      'x.x.x.x', // gRPC server host
      port: 50051, // gRPC server port
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    final stub = GreeterClient(channel);

    try {
      final response = await stub.sayHello(HelloRequest()..language = language);
      setState(() {
        _greeting = response.message;
        _lastLanguage = language; // Save the last chosen language
      });
    } catch (e) {
      setState(() {
        _greeting = 'Caught error: $e';
      });
    } finally {
      await channel.shutdown();
    }
  }

  Future<void> _startStream() async {
    _channel = ClientChannel(
      'x.x.x.x', // gRPC server host
      port: 50051, // gRPC server port
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _stub = GreeterClient(_channel!);

    try {
      // Start streaming with the last chosen language
      _stream = _stub!.getServerStream(HelloRequest()..language = _lastLanguage);

      // Subscribe to the stream and listen for data
      _streamSubscription = _stream!.listen((response) {
        setState(() {
          _streamMessages.add(response.message);
          _isStreaming = true;
        });
      }, onError: (e) {
        setState(() {
          _greeting = 'Stream error: $e';
        });
      }, onDone: () {
        setState(() {
          _greeting = 'Stream completed';
          _isStreaming = false;
        });
      });
    } catch (e) {
      setState(() {
        _greeting = 'Caught error: $e';
      });
    }
  }

  Future<void> _stopStream() async {
    if (_isStreaming) {
      await _streamSubscription?.cancel();
      await _channel?.shutdown();
      setState(() {
        _greeting = 'Stream stopped';
        _isStreaming = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_greeting),
        ElevatedButton(
          onPressed: () => _sayHello('fr'),
          child: Text('En français'),
        ),
        ElevatedButton(
          onPressed: () => _sayHello('en'),
          child: Text('In english'),
        ),
        ElevatedButton(
          onPressed: () => _sayHello('ar'),
          child: Text('بالعربية'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _isStreaming ? null : _startStream, // Disable button if streaming
          child: Text('Start Streaming'),
        ),
        ElevatedButton(
          onPressed: _isStreaming ? _stopStream : null, // Disable button if not streaming
          child: Text('Stop Streaming'),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _streamMessages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_streamMessages[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}