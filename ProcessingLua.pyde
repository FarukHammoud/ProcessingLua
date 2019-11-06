import socket

sock = {}
ip = "192.168.24.182"
port = 5990
data = ''
def returnConfirmation(addr):
    sock.sendto('Command Received!',addr)
    #println('sending to '+addr[0]+':'+str(addr[1]))
def setup():
    global sock
    sock = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
    #'192.168.24.110'
    sock.bind(('127.0.0.1',4200))
    fullScreen(P2D)
    println('inicialized')
def mousePressed():
    print('mousePressed')

def draw():
    global sock,data
    data = ''
    while data != 'redraw()':
        data,addr = sock.recvfrom(8192) #buffer size
        #println('command: '+data)
        #println('address[0]: '+str(addr[0]))
        #println('address[1]: '+str(addr[1]))
        try:
            exec(data)
        except BaseException as err:
            print('error: '+str(err))
        returnConfirmation(addr)
    
        
