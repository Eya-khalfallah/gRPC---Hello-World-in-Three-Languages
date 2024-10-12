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

### Install Dependencies
#### Node.js Server

Navigate to the Node.js server directory and install the required packages:

```bash
cd node_server
npm install
```

#### Python Client

Navigate to the Python client directory and install the required packages:

```bash
cd python_client
pip install -r requirements.txt
```

#### Flutter Client

Navigate to the Flutter client directory and get the dependencies:

```bash
cd flutter_client
flutter pub get
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
