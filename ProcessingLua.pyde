import socket
import time

server = {}

class Server():

    def __init__(self, hostname, port):
        self.hostname = hostname
        self.port = port
        self.conn, self.address = {},{}
        self.running = False
        self.rest = ''
        self.commands = []
        
    def start(self):
        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.socket.bind((self.hostname, self.port))
        self.socket.listen(1)
        
    def connect(self):
        print('Waiting for a connection ...')
        self.conn, self.address = self.socket.accept()
        print('Connected!')
        self.running = True
        
    def execute(self):
        while len(self.commands) > 0:
            command = self.commands.pop(0)
            if command == 'redraw()':
                return False
            try:
                exec(command)
            except BaseException as err:
                print('Python Error: '+str(err))
        return True
            
    def receive(self):
        try:
            data = self.rest + self.conn.recv(1500)
            self.commands = split(data,';')
            self.rest = self.commands.pop()
        except BaseException as err:
            print('Closing connection ...')
            self.running = False
        
    def run(self):
        if not self.running:
            self.connect()
        while self.running and self.execute():
            self.receive()
                    
def setup():
    fullScreen(P2D)
    global server
    server = Server('127.0.0.1',4200)
    server.start()
    
def draw():
    server.run()
        
