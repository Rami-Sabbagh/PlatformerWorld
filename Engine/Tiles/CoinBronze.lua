--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/Tile-liquid--
Tile = class:new()

function Tile:init()
	self.name = "CoinBronze"
  self.category = "Decor"
	self.hover = "Bronze"
  self.thumbnail = "coin"..self.hover
	self.snap = 70
end

function Tile:create(marker,map)
  self.active = 1
  self.rayCall = function(fixture, x, y, xn, yn, fraction)
    local data = tostring(fixture:getUserData())
    if data:len() >= 8 and data:sub(1,6) == "Player" then
      local pN = tonumber(data:sub(8))
      if _HUD then _HUD:addScore(1,pN) end
      self.active = 2
      return 0
    else
      return -1
    end
  end
end

function Tile:update(marker,map,players,dt)
  --[[if self.active == 1 then
    local X,Y
    for pN,player in pairs(players) do
      X,Y = player.object.body:getPosition()
      if X >= marker.x-18+35 and X <= marker.x+18+35 and Y >= marker.y-18+35 and Y <= marker.y+18+35 then
        if _HUD then _HUD:addScore(1,pN) end
        self.active = 2
        return
      end
    end
  end]]--
  if self.active == 1 then
    _World:rayCast( marker.x+23, marker.y+23, marker.x+self.snap-23, marker.y+self.snap-23, self.rayCall )
    _World:rayCast( marker.x+self.snap-23, marker.y+23, marker.x+23, marker.y+self.snap-23, self.rayCall )
  end
end

function Tile:draw(marker,map)
  if self.active == 1 or not self.active then
    local X,Y = marker.x,marker.y
    love.graphics.setColor(marker.color or {255,255,255,255})
    UI:Draw("coin"..self.hover,X,Y,70,70)
  end
end