--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/Screen--
--Imports--
require 'Modes.LevelEditor'

Loading = class:new()

function Loading:init()
  --self.LOGO = love.graphics.newImage("assets/textures/gui/SSHWorld-LOGO.png")
  --self.BG = love.graphics.newImage("assets/textures/gui/Loading-Background.png")
  
  self.alpha = 255
  self.stage = 1
  self.done = false
  self.prog = 0
  self.speed = 25
  
  Loader:init({_Images,_Sounds,_Fonts,_ImageDatas,_rawJData,_rawINIData})
  
  local files = love.filesystem.getDirectoryItems("Lib/Themes/")
  for k, folder in ipairs(files) do
    if love.filesystem.isDirectory("Lib/Themes/"..folder) then
      Loader:LoadDirectory("Lib/Themes/"..folder.."/")
    end
  end
  Loader:LoadFolder("Lib/RL4G/")
  
  self.progbar = loveframes.Create("progressbar")
  self.progbar:SetPos(_Width/2-250,_Height/2+25):SetLerp(false):SetLerpRate(10)
  self.progbar:SetWidth(500):SetMinMax(0,100):SetText("0%")
  self.progbar.OnComplete = function(object)
    self.done = true
    _Loaded = true
    _TilesList = {}
    local files = loveframes.util.GetDirectoryContents("Engine/Tiles/")
    for k, v in ipairs(files) do
      if v.extension == "lua" then
        require(v.requirepath)
        Tile = Tile:new()
        _TilesList[Tile.name] = Tile
        Tile = nil
      end
    end
  end
end

function Loading:update()
  Loader:Update()
  self.prog = math.floor(Loader:getProgress()*100)
  self.progbar:SetValue(self.prog):SetText(tostring(self.prog).."%")
end

function Loading:draw()
  if self.stage == 4 then
    self.progbar:Remove()
    return LevelEditor:new()
  end
  --love.graphics.setColor(255,255,255,255)
  --love.graphics.draw(self.BG,0,0,0,_Width/self.BG:getWidth(),_Height/self.BG:getHeight())
  --love.graphics.draw(self.LOGO,_Width/2,_Height/2-25,0,0.5,0.5,self.LOGO:getWidth()/2,self.LOGO:getHeight()/2)
end

function Loading:fade()
  love.graphics.setColor(0,0,0,self.alpha)
  love.graphics.rectangle("fill",0,0,_Width,_Height)
  if self.stage == 1 then
    self.alpha = self.alpha - self.speed
    if self.alpha <= 0 then
      self.stage = 2
      self.alpha = 0
    end
  elseif self.stage == 2 then
    if self.done then self.stage = 3 end
  elseif self.stage == 3 then
    self.alpha = self.alpha + self.speed
    if self.alpha >= 255 then
      self.stage = 4
      self.alpha = 255
    end
  end
end