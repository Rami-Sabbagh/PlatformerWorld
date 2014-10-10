--Platformer World By RamiLego4Game--
--Imports--
Loader = require "Engine.Loader"
JSON = require "Engine.JSON"

require "Engine.loveframes"
require "Engine.Class"
require "Engine.TableSerializer"
require "Engine.AndroidTouch"
  
--Classess Importes--
require "Engine.UI"
require "Engine.HUD"
require "Engine.B2Object"
require "Engine.Player"
require "Engine.Joystick"
require "Engine.LevelLoader"
require "Engine.Camera"
require "Modes.Splash"

_Images,_Sounds,_Fonts,_ImageDatas,_rawJData,_rawINIData,_ImageQualities,_TEXTUREQUALITY = {},{},{},{},{},{},{},"High"
_SaveDir = love.filesystem.getSaveDirectory().."/"
_Keys = {}

function love.load(arg)
  if arg[3] == "-debug" then _LoveBird = require "Engine.lovebird" end
  if arg[2] == "-android" then _AndroidDebug = true end
  _Width, _Height = love.graphics.getWidth(), love.graphics.getHeight()
  
  if not love.filesystem.exists("/Levels/") then
    love.filesystem.createDirectory("/Levels/")
    local copyLevels = function(filename)
      local content = love.filesystem.read( "/EmbededLevels/"..filename )
      love.filesystem.write( "/Levels/"..filename , content )
    end
    love.filesystem.getDirectoryItems( "/EmbededLevels/", copyLevels )
  end
  
  DroidTouch = AndroidTouch:new()
  
  UI = UI:new()
  mode = Splash:new()
end

function love.draw()
  if mode.draw then
    switch = mode:draw()
    if switch then mode = switch end
  end
  loveframes.draw()
  if mode.fade then
    switch = mode:fade()
    if switch then mode = switch end
  end
end

function love.update(dt) 
  if _AndroidDebug and DroidTouch.Touches[1] then
    local x,y = love.mouse.getPosition()
    DroidTouch:touchmoved(1,x,y)
  end
  
	if mode.update then
    switch = mode:update(dt)
    if switch then mode = switch end
  end
  loveframes.update(dt)
  if _LoveBird then _LoveBird.update() end
end

function love.mousefocus( focus )
  if mode.mousefocus then
    switch = mode:mousefocus( focus )
    if switch then mode = switch end
  end
end

function love.mousepressed( x, y, button )
  if mode.mousepressed and love.system.getOS() ~= "Android" and not _AndroidDebug then
    switch = mode:mousepressed( x, y, button )
    if switch then mode = switch end
  end
  if _AndroidDebug then DroidTouch:touchpressed( 1, x, y ) end
  
  loveframes.mousepressed(x, y, button)
end

function love.mousereleased( x, y, button )
  if mode.mousereleased and love.system.getOS() ~= "Android" and not _AndroidDebug then
    switch = mode:mousereleased( x, y, button )
    if switch then mode = switch end
  end
  if _AndroidDebug then DroidTouch:touchreleased( 1, x, y ) end
  
  loveframes.mousereleased(x, y, button)
end

function love.touchpressed( id, x, y )
  x = math.floor(_Width*x)
  y = math.floor(_Height*y)
  DroidTouch:touchpressed( id, x, y )
end

function love.touchmoved( id, x, y )
  x = math.floor(_Width*x)
  y = math.floor(_Height*y)
  DroidTouch:touchmoved( id, x, y )
end

function love.touchreleased( id, x, y )
  x = math.floor(_Width*x)
  y = math.floor(_Height*y)
  DroidTouch:touchreleased( id, x, y )
end

function love.touch(touch)
  if mode.touch then
    switch = mode:touch(touch)
    if switch then mode = switch end
  end
end

function love.keypressed(key, isrepeat)
  if _Keys[key] == nil then _Keys[key] = 0 end
  
  if mode.keypressed then
    switch = mode:keypressed(key, isrepeat)
    if switch then mode = switch end
  end
  
  loveframes.keypressed(key, isrepeat)
end
 
function love.keyreleased(key)
  _Keys[key] = nil
  
  if mode.keyreleased then
    switch = mode:keyreleased(key)
    if switch then mode = switch end
  end
  
  loveframes.keyreleased(key)
end

function love.textinput(text)
  if mode.textinput then
    switch = mode:textinput(text)
    if switch then mode = switch end
  end
  
  loveframes.textinput(text)
end

function round(num, idp)
  if idp and idp>0 then
    local mult = 10^idp
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
end