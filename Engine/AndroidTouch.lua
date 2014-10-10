--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/API--
AndroidTouch = class:new()

function AndroidTouch:init()
  self.Touches = {}
  BEGAN = 1
  MOVED = 2
  ENDED = 3
end

function AndroidTouch:touchpressed(id,x,y)
  self.Touches[id] = {}
  self.Touches[id].id = id
  self.Touches[id].state = BEGAN
  self.Touches[id].x = x
  self.Touches[id].y = y
  self.Touches[id].prevX = x
  self.Touches[id].prevY = y
  love.touch(self.Touches[id])
end

function AndroidTouch:touchmoved(id,x,y)
  self.Touches[id].state = MOVED
  self.Touches[id].prevX = self.Touches[id].x
  self.Touches[id].prevY = self.Touches[id].y
  self.Touches[id].x = x
  self.Touches[id].y = y
  love.touch(self.Touches[id])
end

function AndroidTouch:touchreleased(id,x,y)
  self.Touches[id].state = ENDED
  self.Touches[id].prevX = self.Touches[id].x
  self.Touches[id].prevY = self.Touches[id].y
  self.Touches[id].x = x
  self.Touches[id].y = y
  love.touch(self.Touches[id])
  self.Touches[id] = nil
end