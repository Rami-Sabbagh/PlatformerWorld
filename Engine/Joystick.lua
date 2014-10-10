--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/API--
Joystick = class:new()

function Joystick:init(x,y,modenum)
  self.x = x
  self.y = y
  self.mode = modenum
end

function Joystick:draw()
  if self.mode == 1 then
    UI:Draw("Joystick"..self.mode,self.x,self.y)
  else
    UI:Draw("Joystick"..self.mode,self.x,self.y,60,60)
  end
end

function Joystick:touch(touch)
  if self.mode == 1 then
    if not self.tid and touch.x >= self.x and touch.x <= self.x + 160 and touch.y >= self.y and touch.y <= self.y + 61 then self.tid = touch.id end
    if self.tid == touch.id then
      if touch.state ~= ENDED then
        if touch.x > self.x + 80 then
          _Keys["joyright"] = 0
          _Keys["joyleft"] = nil
        elseif touch.x < self.x + 80 then
          _Keys["joyleft"] = 0
          _Keys["joyright"] = nil
        end
      else
        _Keys["joyleft"] = nil
        _Keys["joyright"] = nil
        self.tid = nil
      end
    end
  elseif self.mode > 1 then
    if not self.tid and touch.x >= self.x and touch.x <= self.x + 60 and touch.y >= self.y and touch.y <= self.y + 60 then self.tid = touch.id end
    if self.tid == touch.id then
      if touch.state == BEGAN then
        if self.mode == 2 then _Keys["joyup"] = 0 end
        if self.mode == 3 then _Keys["joydown"] = 0 end
      elseif touch.state == ENDED then
        if self.mode == 2 then _Keys["joyup"] = nil end
        if self.mode == 3 then _Keys["joydown"] = nil end
        self.tid = nil
      end
    end
  end
end