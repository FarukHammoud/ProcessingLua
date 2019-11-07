setmetatable(_G,{__index=require "processing"})

background(255,100,100)
fill(100,255,100)
for i = 1, 500 do
	rect(i,300,200,200)
	redraw()
end

