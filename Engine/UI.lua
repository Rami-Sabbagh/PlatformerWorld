--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/API--
UI = class:new()

function UI:init()
  self.unkown = love.graphics.newImage("Lib/RL4G/Messing.png")
  self.font = love.graphics.newFont("Lib/Fonts/kenvector_future.ttf",12)
end

--If the pass variable is not number it will return nil, else it return the same variable
function UI:forceNum(var)
  if type(var) ~= "number" then var = nil end
  return var
end

--If the pass variable is not boolean it will return nil, else it return the same variable
function UI:forceBol(var)
  if type(var) ~= "boolean" then var = nil end
  return var
end

--If the pass variable is not table it will return nil, else it return the same variable
function UI:forceTable(var)
  if type(var) ~= "table" then var = nil end
  return var
end

function UI:Draw(Image,X,Y,Width,Height,Rotation,Center,Flip)
  if _Loaded then
    if type(Image) ~= "userdata" and type(Image) ~= "string" then
      Image = "Messing"
    elseif type(Image) ~= "userdata" then
      Image = _Images[Image]
    end
  else
    if type(Image) ~= "userdata" then
      Image = self.unkown
    end
  end
  
  X = self:forceNum(X) or 0
  Y = self:forceNum(Y) or 0
  Width = self:forceNum(Width) or Image:getWidth()
  Height = self:forceNum(Height) or Image:getHeight()
  Rotation = self:forceNum(Rotation) or 0
  Center = self:forceBol(Center) or false
  Flip = self:forceBol(Flip) or false
  if Center then OrginX,OrginY = Image:getWidth()/2,Image:getHeight()/2 end
  OrginX = OrginX or 0
  OrginY = OrginY or 0
  Width = Width/Image:getWidth()
  Height = Height/Image:getHeight()
  Rotation = math.rad(Rotation)
  
  if Flip then
    love.graphics.draw(Image,X,Y,Rotation,-Width,Height,OrginX,OrginY)
  else
    love.graphics.draw(Image,X,Y,Rotation,Width,Height,OrginX,OrginY)
  end
  
  Image,X,Y,Width,Height,Rotation,Center,OrginX,OrginY,Flip = nil,nil,nil,nil,nil,nil,nil,nil,nil,nil
end

function UI:DrawBackground(Image)
  if _Loaded then
    if type(Image) ~= "userdata" and type(Image) ~= "string" then
      Image = "Messing"
    elseif type(Image) ~= "userdata" then
      Image = _Images[Image]
    end
  else
    if type(Image) ~= "userdata" then
      Image = self.unkown
    end
  end
  
  Width,Height = _Width, _Height
  IWidth = Image:getWidth()
  IHeight = Image:getHeight()
  ScaleX = math.floor(Width/IWidth)+2
  ScaleY = math.floor(Height/IHeight)+2
  for X=-1,ScaleX do
    for Y=-1,ScaleY do
      self:Draw(Image,(X-1)*IWidth,(Y-1)*IHeight)
    end
  end
end

function UI:DrawGuide()
  local Width,Height = _Width, _Height
  love.graphics.setColor(0,102,204,255)
  love.graphics.setLineWidth(0.1)
  if _Camera then
    local SX, SY = _Camera:worldCoords(0,0)
    local WX, WY = SX, SY
    Width, Height = _Camera:worldCoords(Width,Height)
    while WX < Width+1 do
      love.graphics.line(math.floor(WX/70+1)*70,SY,math.floor(WX/70+1)*70,Height)
      WX = WX + 70
    end
    while WY < Height+1 do
      love.graphics.line(SX,math.floor(WY/70+1)*70,Width,math.floor(WY/70+1)*70)
      WY = WY + 70
    end
  else
    for X=0,Width/70 do
      love.graphics.line(0,X*70,Width,X*70)
      love.graphics.line(X*70,0,X*70,Height)
    end
  end
end