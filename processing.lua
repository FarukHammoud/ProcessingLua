local P = {}

local PRINT_FLAG = true

local socket = require "socket"

--local ip = '192.168.24.110'
local ip = '127.0.0.1'
local port = 4200

local unconnected = socket.udp()

local function send_command(command)
	unconnected:sendto(command,ip,port)
	if PRINT_FLAG then
		print('sending '..command..' to',ip,port)
	end
end

local function std_function(name,...)
	function pack(...)       
		return { n = select("#", ...), ... }     
	end
	par = pack(...)
	command = name..'('
	for i=1,#par-1 do
		command = command..par[i]..','
	end
	if #par ~= 0 then
		command = command..par[#par]..')'
	else 
		command = command..')'
	end
	send_command(command)
end

function P.ip()
	return assert(socket.dns.toip('localhost'))
end
function P.ellipse(...)
	std_function('ellipse',...)
end
function P.background(...)
	std_function('background',...)
end
function P.stroke(...)
	std_function('stroke',...)
end
function P.rect(...)
	std_function('rect',...)
end
function P.fill(...)
	std_function('fill',...)
end
function P.scale(...)
	std_function('scale',...)
end
function P.translate(...)
	std_function('translate',...)
end
function P.pushMatrix(...)
	std_function('pushMatrix',...)
end
function P.popMatrix(...)
	std_function('popMatrix',...)
end
function P.redraw(...)
	std_function('redraw',...)
end
function P.strokeWeight(...)
	std_function('strokeWeight',...)
end
function P.text(text,x,y)
	send_command('text(\''..tostring(text)..'\','..x..','..y..')')
end
function P.textWidth(...)
	std_function('textWidth',...)
end
function P.textSize(...)
	std_function('textSize',...)
end
function P.point(...)
	std_function('point',...)
end
function P.rotateX(...)
	std_function('rotateX',...)
end
function P.rotateY(...)
	std_function('rotateY',...)
end
function P.rotateZ(...)
	std_function('rotateX',...)
end
function P.triangle(...)
	std_function('triangle',...)
end
function P.beginShape(...)
	std_function('beginShape',...)
end
function P.endShape(...)
	std_function('endShape',...)
end
function P.vertex(...)
	std_function('vertex',...)
end
function P.line(...)
	std_function('line',...)
end

--unconnected:close()

return P
