--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/Tile-liquid--
Tile = class:new()

function Tile:init()
	self.name = "Water"
  self.category = "Ground"
	self.hover = "Water"
  self.thumbnail = "liquid"..self.hover.."Top"
	self.snap = 70
end

function Tile:create(marker,map)
  self.rayCall = function(fixture, x, y, xn, yn, fraction)
    local body = fixture:getBody()
    body:applyForce( 0, -2500 )
    return 1
  end
end

function Tile:update(marker,map,players,dt)
  _World:rayCast( marker.x+3, marker.y+3, marker.x+self.snap-3, marker.y+self.snap-3, self.rayCall )
  _World:rayCast( marker.x+self.snap-3, marker.y+3, marker.x+3, marker.y+self.snap-3, self.rayCall )
end

function Tile:draw(marker,map)
  local X,Y = marker.x,marker.y
  self.State = "Top_mid"
  
  if map[marker.x] ~= nil and map[marker.x][marker.y-self.snap] ~= nil then
    self.State = ""
  end
  
  love.graphics.setColor(marker.color or {255,255,255,255})
  UI:Draw("liquid"..self.hover..self.State,X,Y,70,70)
end