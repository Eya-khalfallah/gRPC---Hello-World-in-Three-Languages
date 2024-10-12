const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');
const path = require('path');

// Load the protobuf file
const PROTO_PATH = path.join(__dirname, '../proto/service.proto');
const packageDefinition = protoLoader.loadSync(PROTO_PATH, {
  keepCase: true,
  longs: String,
  enums: String,
  defaults: true,
  oneofs: true
});
const greeterProto = grpc.loadPackageDefinition(packageDefinition).example;

// Define "Hello World" translations for different languages
const helloWorldTranslations = {
  'fr': 'Bonjour le monde',  // French
  'en': 'Hello World',       // English
  'ar': 'مرحبا بالعالم'       // Arabic
  // Add more languages if needed
};

// Function for unary gRPC call
function sayHello(call, callback) {
  const helloWorldMessage = helloWorldTranslations[call.request.language] || 'Hello World';
  const reply = { message: helloWorldMessage };
  callback(null, reply);
}

// Function for streaming gRPC call
function getServerStream(call) {
  const language = call.request.language;
  let count = 0;

  // Get the translation for the selected language, default to English if not found
  const helloWorldMessage = helloWorldTranslations[language] || 'Hello World';

  // Stream messages with some delay
  const intervalId = setInterval(() => {
    if (count < 5) {
      const message = `${helloWorldMessage}, message ${count}`;
      call.write({ message });
      count++;
    } else {
      clearInterval(intervalId);
      call.end(); // End the stream after 5 messages
    }
  }, 1000); // Send a message every second
}

// Start the gRPC server
function startServer() {
  const server = new grpc.Server();
  
  server.addService(greeterProto.Greeter.service, {
    sayHello: sayHello,
    getServerStream: getServerStream
  });

  server.bindAsync('0.0.0.0:50051', grpc.ServerCredentials.createInsecure(), (err, port) => {
    if (err) {
      console.error(err);
      return;
    }
    console.log(`gRPC server running on port ${port}`);
    server.start();
  });
}

// Start the server
startServer();
