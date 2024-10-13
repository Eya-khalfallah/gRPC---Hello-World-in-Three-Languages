import grpc
import time
import threading
import service_pb2_grpc, service_pb2  # Ensure you generate Python gRPC stubs

class GRPCClient:
    ip_address = 'x.x.x.x'
    def __init__(self):
        self.channel = grpc.insecure_channel(f'{self.ip_address}:50051')  # Replace with your gRPC server's IP and port
        self.stub = service_pb2_grpc.GreeterStub(self.channel)
        self.last_language = 'en'  # Default language

    def say_hello(self, language: str):
        try:
            request = service_pb2.HelloRequest(language=language)
            response = self.stub.SayHello(request)
            print(f"Response: {response.message}")
            self.last_language = language  # Update last chosen language
        except grpc.RpcError as e:
            print(f"Error during say_hello: {e.details()}")

    def start_stream(self):
        try:
            request = service_pb2.HelloRequest(language=self.last_language)
            response_stream = self.stub.GetServerStream(request)
            
            for response in response_stream:
                print(f"Streamed message: {response.message}")
        except grpc.RpcError as e:
            print(f"Error during stream: {e.details()}")

    def stop_stream(self, stream_thread):
        if stream_thread and stream_thread.is_alive():
            # If the thread is running, stop it by killing the thread
            print("Stopping the stream...")
            stream_thread.do_run = False
            stream_thread.join()  # Wait for the thread to finish
            print("Stream stopped.")

def main():
    client = GRPCClient()

    while True:
        print("\n1. Say Hello in French")
        print("2. Say Hello in English")
        print("3. Say Hello in Arabic")
        print("4. Start Streaming")
        print("5. Stop Streaming")
        print("6. Exit")
        choice = input("Choose an option: ")

        if choice == '1':
            client.say_hello('fr')
        elif choice == '2':
            client.say_hello('en')
        elif choice == '3':
            client.say_hello('ar')
        elif choice == '4':
            stream_thread = threading.Thread(target=client.start_stream)
            stream_thread.do_run = True  # Control flag to stop the thread
            stream_thread.start()
        elif choice == '5':
            client.stop_stream(stream_thread)
        elif choice == '6':
            print("Exiting...")
            break
        else:
            print("Invalid option, please try again.")

if __name__ == '__main__':
    main()
