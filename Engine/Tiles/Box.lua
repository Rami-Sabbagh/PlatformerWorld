--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/Tile--
Tile = class:new()

function Tile:init()
	self.name = "Box"
  self.category = "Decor"
	self.thumbnail = nil
	self.hover = "box"
	self.snap = 70
  self.dynamic = true
end

function Tile:create(marker,map)
  self.object = B2Object:newBox(marker.x,marker.y,70,70,"dynamic")
end

function Tile:destroy()
  self.object.body:destroy()
  self.object = nil
end

function Tile:draw(marker,map)
  local X,Y,Rotation = 0,0,0
  if self.object then
    X,Y = self.object.body:getPosition()
    Rotation = math.deg(self.object.body:getAngle())
  else
    X,Y = marker.x,marker.y
  end
  
  
  love.graphics.setColor(marker.color or {255,255,255,255})
  UI:Draw(self.hover,X,Y,70,70,Rotation)
end