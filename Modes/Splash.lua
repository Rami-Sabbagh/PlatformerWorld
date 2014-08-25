--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/Screen--
--Imports--
require 'Modes.Loading'

Splash = class:new()

function Splash:init()
  self.LOGO = love.graphics.newImage("Lib/RL4G/RL4G_LOGO.png")
  
  self.alpha = 255
  self.stage = 1
  self.timer = 50
  self.speed = 25
  
  love.graphics.setBackgroundColor(255,255,255)
end

function Splash:draw()
  if self.stage == 4 then return Loading:new() end
  love.graphics.setColor(255,255,255,255)
  UI:Draw(self.LOGO,_Width/2,_Height/2,nil,nil,nil,true)
end

function Splash:fade()
  love.graphics.setColor(0,0,0,self.alpha)
  love.graphics.rectangle("fill",0,0,_Width,_Height)
  if self.stage == 1 then
    self.alpha = self.alpha - self.speed
    if self.alpha <= 0 then
      self.stage = 2
      self.alpha = 0
    end
  elseif self.stage == 2 then
    self.timer = self.timer - 1
    if self.timer <= 0 then
      self.timer = 50
      self.stage = 3
    end
  elseif self.stage == 3 then
    self.alpha = self.alpha + self.speed
    if self.alpha >= 255 then
      self.stage = 4
      self.alpha = 255
    end
  end
end