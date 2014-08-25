--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/Interface--
TileBase = class:new()

function TileBase:init(name,hover,thumbnail)
	self.name = name;
	self.thumbnail = thumbnail;
	self.hover = hover;
	self.snap = 70;
end

function TileBase:create(marker,map)
  
end

function TileBase:destroy()
  
end

function TileBase:restart()
	
end

function TileBase:onActivate()
	
end

function TileBase:onDeactivate()
	
end

function TileBase:update(dt,marker,map)
	
end

function TileBase:draw(marker,map)
  
end