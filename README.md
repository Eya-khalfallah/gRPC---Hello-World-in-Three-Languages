# gRPC - Hello World in Three Languages

This project demonstrates a simple gRPC implementation with a "Hello World" service, allowing clients to request greetings in three different languages: English, French, and Arabic. It includes a Node.js gRPC server, a Python client, and a Flutter (Dart) mobile client.

## Table of Contents

- [Technologies Used](#technologies-used)
- [Setup Instructions](#setup-instructions)
- [Running the Server](#running-the-server)
- [Running the Clients](#running-the-clients)
- [Usage](#usage)

## Technologies Used

- **Node.js** - for the gRPC server
- **Python** - for the Python client
- **Flutter (Dart)** - for the mobile client
- **gRPC** - for remote procedure calls
- **Protocol Buffers** - for defining the service and messages

## Setup Instructions

### Clone the Repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/Eya-khalfallah/gRPC---Hello-World-in-Three-Languages.git
cd gRPC---Hello-World-in-Three-Languages
```

### Node Server Setup

Navigate to the Node.js server directory and install the required packages:

```bash
cd node_server
npm install
```

### Python Client Setup

#### 1. Navigate to the Python client directory:

```bash
cd python_client
```

#### 2. Create a virtual environment:

```bash
python -m venv venv
```

#### 3. Activate the virtual environment:

- Windows:

```bash
.\venv\Scripts\activate
```

- Linux:

```bash
source ./venv/bin/activate
```

#### 4. Install the dependencies:

```bash
pip install grpcio grpcio-tools
```

#### 5. Compile the protobuf file

- Windows:

```bash
python -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. --proto_path=..\proto service.proto
```

- Linux:

```bash
python -m grpc_tools.protoc -I. --python_out=. --grpc_python_out=. --proto_path=../proto service.proto
```

#### 5. Set The Server IP Address

Update the `ip_address` variable in the `client.py` file to match the IP address of your server.

```python
ip_address = 'x.x.x.x'
```

### Flutter Client Setup

#### 1. Install dependencies

Navigate to the Flutter client directory and get the dependencies:

```bash
cd flutter_client
flutter pub get
```

#### 2. Set The Server IP Address

Update the `_ipAddress` variable in the `main.dart` file to match the IP address of your server.

```dart
String _ipAddress = 'x.x.x.x'
```

## Running the Server

To start the gRPC server, navigate to the Node.js server directory and run:

```bash
cd node_server
node server.js
```

## Running the Clients

### Python Client

To run the Python client, navigate to the Python client directory and execute:

```bash
cd python_client
python client.py
```

### Flutter Client

To run the Flutter client, navigate to the Flutter client directory and execute:

```bash
cd flutter_client
flutter run
```

## Usage

1. **Start the Node.js server** to listen for gRPC calls.
2. **Run the Python client** and specify the desired language (e.g., 'en' for English, 'fr' for French, 'ar' for Arabic). It will print the "Hello World" message in the chosen language.
3. **Run the Flutter client** to interact with the server. It can send requests to receive "Hello World" in different languages and also support streaming.
