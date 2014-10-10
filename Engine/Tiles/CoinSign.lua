--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/Tile-Sign--
Tile = class:new()

function Tile:init()
	self.name = "CoinSign"
  self.category = "Decor"
	self.hover = "Coin"
  self.thumbnail = "sign"..self.hover
	self.snap = 70
end

function Tile:buildbatch(marker,map,spritebatch,spritemap,mapsize)
  local X,Y = marker.x,marker.y
  self.State = ""
  
  if map[marker.x] ~= nil and map[marker.x][marker.y-self.snap] ~= nil then
    self.State = "Hanging"
  end
  
  love.graphics.setColor(marker.color or {255,255,255,255})
  local frame = spritemap["sign"..self.State..self.hover..".png"]
  local Quad = love.graphics.newQuad(frame.x,frame.y,frame.w,frame.h,mapsize.width,mapsize.height)
  spritebatch:add(Quad,X,Y)
  --UI:Draw("sign"..self.State..self.hover,X,Y,70,70)
end

function Tile:draw(marker,map)
  local X,Y = marker.x,marker.y
  self.State = ""
  
  if map[marker.x] ~= nil and map[marker.x][marker.y-self.snap] ~= nil then
    self.State = "Hanging"
  end
  
  love.graphics.setColor(marker.color or {255,255,255,255})
  UI:Draw("sign"..self.State..self.hover,X,Y,70,70)
end