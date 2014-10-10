--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/Screen--
--Imports--
require "Modes.DGame"
LevelEditor = class:new()

function LevelEditor:init(map)
  _Camera = camera:new()
  self.fadeScreen, self.alpha, self.speed, self.guide, self.checkhover = true, 255, 25, true, true
  
  self.map = map or {meta={ver="V1.5"}}
  self.encodedMap, self.LevelLoader = {}, LevelLoader:new()
  self.encodedMap = self.LevelLoader:encodeMap(self.map)
  self.touchdata = {}
  self:createTopBar()
  
  self:FillTilesList("Ground")
  self:FillTilesList("Decor")
end

function LevelEditor:update(dt)
  if self.checkhover then self.hover = loveframes.util.GetHover() end
  if not self.hover then
    if love.mouse.isDown("l") and self.selected then
      local X, Y = _Camera:mousepos()--love.mouse.getPosition()
      X, Y = math.floor(X/70)*70, math.floor(Y/70)*70
      if self.map[X] == nil then self.map[X] = {} end
      if self.map[X][Y] == nil then self.map[X][Y] = {} end
      if #self.map[X][Y] == 0 then self.map[X][Y][self.selected] = {} end
      self.encodedMap = LevelLoader:encodeMap(self.map)
    elseif love.mouse.isDown("m") then
      local X, Y = _Camera:mousepos()--love.mouse.getPosition()
      X, Y = math.floor(X/70)*70, math.floor(Y/70)*70
      if self.map[X] ~= nil and self.map[X][Y] ~= nil then self.map[X][Y] = {} end
      self.encodedMap = LevelLoader:encodeMap(self.map)
    elseif love.mouse.isDown("r") then
      local X, Y = love.mouse.getPosition()
      if self.MPX ~= nil and self.MPY ~= nil and self.MPX ~= X and self.MPY ~= Y then
        X, Y = _Camera:mousepos()
        local MPX, MPY = _Camera:worldCoords(self.MPX, self.MPY)
        _Camera:lookAt(self.CMX-(X-MPX),self.CMY-(Y-MPY))
      end
    end
  end
end

function LevelEditor:draw()
  love.graphics.setColor(255,255,255,255)
  UI:DrawBackground("Background")
  _Camera:attach()
  if self.guide then UI:DrawGuide() end
  if self.selected and not self.hover then
    local X, Y = _Camera:mousepos()--love.mouse.getPosition()
    X, Y = math.floor(X/70), math.floor(Y/70)
    local marker = {}
    marker.x = X*70
    marker.y = Y*70
    marker.color = {255,255,255,150}
    _TilesList[self.selected]:draw(marker,self.encodedMap)
  end
  self.encodedMap = self.LevelLoader:drawEditorMap(self.encodedMap)
  _Camera:detach()
end

function LevelEditor:fade()
  if self.fadeScreen then
    love.graphics.setColor(0,0,0,self.alpha)
    love.graphics.rectangle("fill",0,0,_Width,_Height)
    self.alpha = self.alpha - self.speed
    if self.alpha <= 0 then
      self.fadeScreen = false
      self.alpha = 255
    end
    love.graphics.setColor(255,255,255,255)
  end
end

function LevelEditor:createTopBar()
  if self.fr == nil then self.fr = {} end
  self.fr.topBar = {}
  
  self.fr.topBar.Test = loveframes.Create("button")
  self.fr.topBar.Test:SetPos(3,3):SetSize(64,24):SetText("Test")
  self.fr.topBar.Test.OnClick = function(object)
    self:Destroy()
    mode = DGame:new(self.map)
  end
  
  self.fr.topBar.Load = loveframes.Create("button")
  self.fr.topBar.Load:SetPos(70,3):SetSize(64,24):SetText("Load")
  self.fr.topBar.Load.OnClick = function(object)
    self:createLoad()
  end
  
  self.fr.topBar.Save = loveframes.Create("button")
  self.fr.topBar.Save:SetPos(137,3):SetSize(64,24):SetText("Save")
  self.fr.topBar.Save.OnClick = function(object)
    self:createSave()
  end
  
  self.fr.topBar.Modes = loveframes.Create("panel")
  --self.fr.topBar.Modes:SetDraggable(false):ShowCloseButton(false)
  self.fr.topBar.Modes:SetSize(75,50):SetPos(_Width-75,0)
  self.fr.topBar.Modes.Draw = function(object)
    local X,Y = object:GetPos()
    love.graphics.setColor(255,255,255,255)
    UI:Draw("Editor-Modes-Panel-Dev",X,Y)
  end
  
  self.fr.topBar.Menu = loveframes.Create("panel")
  --self.fr.topBar.Menu:SetDraggable(false):ShowCloseButton(false)
  self.fr.topBar.Menu:SetSize(50,300):SetPos(_Width-50,50)
  self.fr.topBar.Menu.Draw = function(object)
    local X,Y = object:GetPos()
    love.graphics.setColor(255,255,255,255)
    UI:Draw("Editor-Tiles-Panel-2",X,Y)
  end
  
  self.fr.topBar.TilesGround = loveframes.Create("frame")
  self.fr.topBar.TilesGround:SetDraggable(false):ShowCloseButton(false)
  self.fr.topBar.TilesGround:SetSize(800,90):SetPos(_Width-34,62)
  self.fr.topBar.TilesGround.Draw = function(object)
    local X,Y = object:GetPos()
    love.graphics.setColor(255,255,255,255)
    UI:Draw("Editor-Tiles-Bar-Ground",X,Y)
  end
  self.fr.topBar.TilesGround.Update = function(object)
    local X,Y = object:GetPos()
    local Width,Height = object:GetSize()
    if object.BarData == nil then
      object.BarData = {}
      object.BarData.OldX, object.BarData.OldY = object:GetPos()
      object.BarData.Speed = 100
      object.BarData.OrginX = 0
      object.BarData.Hover = false
    end
    local hover = object:GetHover()
    if object.BarData.Hover then
      if object.BarData.OrginX < 350 then
        object.BarData.OrginX = object.BarData.OrginX + object.BarData.Speed
        if object.BarData.OrginX > 350 then object.BarData.OrginX = 350 end
      end
      object:SetX(object.BarData.OldX-object.BarData.OrginX)
    end
    if hover then
      if object.BarData.OrginX < 350 then
        object.BarData.OrginX = object.BarData.OrginX + object.BarData.Speed
        if object.BarData.OrginX > 350 then object.BarData.OrginX = 350 end
      end
      object:SetX(object.BarData.OldX-object.BarData.OrginX)
      object.BarData.Hover = true
    else
      if object.BarData.Hover and love.mouse.getX() >= X and love.mouse.getX() <= X+Width and love.mouse.getY() >= Y and love.mouse.getY() <= Y+Height then return else object.BarData.Hover = false end
      if object.BarData.OrginX > 0 then
        object.BarData.OrginX = object.BarData.OrginX - object.BarData.Speed
        if object.BarData.OrginX < 0 then object.BarData.OrginX = 0 end
      end
      object:SetX(object.BarData.OldX-object.BarData.OrginX)
    end
  end
  self.fr.topBar.TilesGroundList = loveframes.Create("list",self.fr.topBar.TilesGround)
  self.fr.topBar.TilesGroundList:SetPos(34,10):SetSize(350,90):SetDisplayType("horizontal")
  self.fr.topBar.TilesGroundList:SetPadding(0):SetSpacing(10)
  self.fr.topBar.TilesGroundList:SetSkin("Invisible")
  self.fr.topBar.TilesGroundList.Update = function(object)
    local vbar = object.vbar
    local hbar = object.hbar
    local internals  = object.internals
    
    if (vbar or hbar) and not(love.system.getOS() == "Android" or _AndroidDebug) then
      local scrollbody = internals[1]
      local scrollbutton1 = scrollbody.internals[2]
      local scrollbutton2 = scrollbody.internals[3]
      local scrollarea = scrollbody.internals[1]
      local scrollbar = scrollarea.internals[1]
      scrollbutton1.Draw = function(object) end
      scrollbutton2.Draw = function(object) end
      scrollbody.Draw = function(object) end
      scrollarea.Draw = function(object) end
      scrollbar.Draw = function(object) end
    end
  end
  
  self.fr.topBar.TilesDecor = loveframes.Create("frame")
  self.fr.topBar.TilesDecor:SetDraggable(false):ShowCloseButton(false)
  self.fr.topBar.TilesDecor:SetSize(800,90):SetPos(_Width-34,154)
  self.fr.topBar.TilesDecor.Draw = function(object)
    local X,Y = object:GetPos()
    love.graphics.setColor(255,255,255,255)
    UI:Draw("Editor-Tiles-Bar-Decor",X,Y)
  end
  self.fr.topBar.TilesDecor.Update = function(object)
    local X,Y = object:GetPos()
    local Width,Height = object:GetSize()
    if object.BarData == nil then
      object.BarData = {}
      object.BarData.OldX, object.BarData.OldY = object:GetPos()
      object.BarData.Speed = 100
      object.BarData.OrginX = 0
      object.BarData.Hover = false
    end
    local hover = object:GetHover()
    if object.BarData.Hover then
      if object.BarData.OrginX < 350 then
        object.BarData.OrginX = object.BarData.OrginX + object.BarData.Speed
        if object.BarData.OrginX > 350 then object.BarData.OrginX = 350 end
      end
      object:SetX(object.BarData.OldX-object.BarData.OrginX)
    end
    if hover then
      if object.BarData.OrginX < 350 then
        object.BarData.OrginX = object.BarData.OrginX + object.BarData.Speed
        if object.BarData.OrginX > 350 then object.BarData.OrginX = 350 end
      end
      object:SetX(object.BarData.OldX-object.BarData.OrginX)
      object.BarData.Hover = true
    else
      if object.BarData.Hover and love.mouse.getX() >= X and love.mouse.getX() <= X+Width and love.mouse.getY() >= Y and love.mouse.getY() <= Y+Height then return else object.BarData.Hover = false end
      if object.BarData.OrginX > 0 then
        object.BarData.OrginX = object.BarData.OrginX - object.BarData.Speed
        if object.BarData.OrginX < 0 then object.BarData.OrginX = 0 end
      end
      object:SetX(object.BarData.OldX-object.BarData.OrginX)
    end
  end
  self.fr.topBar.TilesDecorList = loveframes.Create("list",self.fr.topBar.TilesDecor)
  self.fr.topBar.TilesDecorList:SetPos(34,10):SetSize(350,90):SetDisplayType("horizontal")
  self.fr.topBar.TilesDecorList:SetPadding(0):SetSpacing(10)
  self.fr.topBar.TilesDecorList:SetSkin("Invisible")
  self.fr.topBar.TilesDecorList.Update = function(object)
    local vbar = object.vbar
    local hbar = object.hbar
    local internals  = object.internals
    
    if (vbar or hbar) and not(love.system.getOS() == "Android" or _AndroidDebug) then
      local scrollbody = internals[1]
      local scrollbutton1 = scrollbody.internals[2]
      local scrollbutton2 = scrollbody.internals[3]
      local scrollarea = scrollbody.internals[1]
      local scrollbar = scrollarea.internals[1]
      scrollbutton1.Draw = function(object) end
      scrollbutton2.Draw = function(object) end
      scrollbody.Draw = function(object) end
      scrollarea.Draw = function(object) end
      scrollbar.Draw = function(object) end
    end
  end
  
  if not(love.system.getOS() == "Android" or _AndroidDebug) then return end
  self.fr.zoomIN = loveframes.Create("imagebutton")
  self.fr.zoomIN:SetImage(_Images["ZoomIN"])
  self.fr.zoomIN:SizeToImage()
  self.fr.zoomIN:SetText("")
  self.fr.zoomIN:SetPos(_Width-137,2)
  self.fr.zoomIN.OnClick = function(object,x,y)
    if _Camera.scale < 1 then _Camera:zoomTo(_Camera.scale+0.1) end
  end
  
  self.fr.zoomOUT = loveframes.Create("imagebutton")
  self.fr.zoomOUT:SetImage(_Images["ZoomOUT"])
  self.fr.zoomOUT:SizeToImage()
  self.fr.zoomOUT:SetText("")
  self.fr.zoomOUT:SetPos(_Width-194,2)
  self.fr.zoomOUT.OnClick = function(object,x,y)
    if _Camera.scale > 0.2 then _Camera:zoomTo(_Camera.scale-0.1) end
  end
end

function LevelEditor:FillTilesList(cat)
  for k,v in pairs(_TilesList) do
    if v.category == cat then
      local button = loveframes.Create("imagebutton")
      button:SetImage(_Images[v.thumbnail or v.hover]):SizeToImage():SetText("")
      button.OnClick = function(object)
        self.selected = v.name
        self.fr.topBar["Tiles"..cat].BarData.OrginX = 0
        self.fr.topBar["Tiles"..cat].BarData.Hover = false
      end
    
      --local X = 0--button:GetX()+button:GetWidth()-10
      --local Y = 43--button:GetY()+button:GetHeight()-10
    
      --[[local tooltip = loveframes.Create("tooltip")
      tooltip:SetObject(button):SetOffsets(X,Y):SetText(v.name or "Unkown")]]--
    
      self.fr.topBar["Tiles"..cat.."List"]:AddItem(button)
    
      button, tooltip = nil, nil
    end
  end
end

function LevelEditor:createLoad()
  if self.fr.loadFrame then
    self.fr.loadFrame:Remove()
    self.fr.loadFrame = nil
  end
  self.fr.loadFrame = loveframes.Create("frame")
  self.fr.loadFrame:SetSize(200,300):SetPos(_Width/2,_Height/2,true):SetName("Load Level")
  
  self.fr.loadList = loveframes.Create("columnlist",self.fr.loadFrame)
  self.fr.loadList:SetPos(5,30):SetSize(190,265):AddColumn("Level Name")
  self:fillLevels(self.fr.loadList)
  self.fr.loadList.OnRowSelected = function(parent, row, data)
    self:loadLevel(data[1])
    if self.fr.loadFrame then
      self.fr.loadFrame:Remove()
      self.fr.loadFrame = nil
    end
  end
end

function LevelEditor:createSave()
  if self.fr.saveFrame then
    self.fr.saveFrame:Remove()
    self.fr.saveFrame = nil
  end
  self.fr.saveFrame = loveframes.Create("frame")
  self.fr.saveFrame:SetSize(200,300):SetPos(_Width/2,_Height/2,true):SetName("Save Level")
  
  self.fr.saveList = loveframes.Create("columnlist",self.fr.saveFrame)
  self.fr.saveList:SetPos(5,30):SetSize(190,211):AddColumn("Level Name")
  self:fillLevels(self.fr.saveList)
  self.fr.saveList.OnRowSelected = function(parent, row, data)
    self:saveLevel(data[1])
    if self.fr.saveFrame then
      self.fr.saveFrame:Remove()
      self.fr.saveFrame = nil
    end
  end
  
  self.fr.saveText = loveframes.Create("textinput",self.fr.saveFrame)
  self.fr.saveText:SetPos(5,243):SetSize(190,25):SetPlaceholderText("Level Name")
  self.fr.saveText.OnEnter = function(object, text)
    self:saveLevel(text)
    if self.fr.saveFrame then
      self.fr.saveFrame:Remove()
      self.fr.saveFrame = nil
    end
  end
  self.fr.saveText.OnTextChanged = function(object, text)
    self.fr.saveButton:SetClickable(true)
  end
  
  self.fr.saveButton = loveframes.Create("button",self.fr.saveFrame)
  self.fr.saveButton:SetPos(5,270):SetSize(190,25):SetText("Save Level"):SetClickable(false)
  self.fr.saveButton.OnClick = function(object)
    self:saveLevel(self.fr.saveText:GetValue())
    if self.fr.saveFrame then
      self.fr.saveFrame:Remove()
      self.fr.saveFrame = nil
    end
  end
end

function LevelEditor:saveLevel(name)
  --local workingDir = love.filesystem.getWorkingDirectory()
  table.save(self.map,_SaveDir.."/Levels/"..name..".level")
end

function LevelEditor:loadLevel(name)
  --local workingDir = love.filesystem.getWorkingDirectory()
  self.map = table.load(_SaveDir.."/Levels/"..name..".level")
  if not self.map.meta then self.map.meta = {ver="V1.5"} end
  self.encodedMap = LevelLoader:encodeMap(self.map)
  _Camera:zoomTo(1)
  _Camera:lookAt(1000/2,700/2)
end

function LevelEditor:fillLevels(object)
  local files = loveframes.util.GetDirectoryContents("Levels/")
  for k, v in ipairs(files) do
    if v.extension == "level" then
      object:AddRow(v.name)
    end
  end
end

function LevelEditor:Destroy()
  if self.fr then
    if self.fr.topBar then
      for k,v in pairs(self.fr.topBar) do
        v:Remove()
        self.fr.topBar[k] = nil
      end
      self.fr.topBar = nil
    end
    for k,v in pairs(self.fr) do
        v:Remove()
        self.fr[k] = nil
    end
  end
  _Camera = nil
end

function LevelEditor:mousepressed(x,y,button)
  self.MPX, self.MPY = x, y
  self.CMX, self.CMY = _Camera:pos()
  if button == "l" then
    self.checkhover = false
  elseif button == "wu" and _Camera.scale < 1 and not self.hover then
    _Camera:zoomTo(_Camera.scale+0.1)
  elseif button == "wd" and _Camera.scale > 0.2 and not self.hover then
    _Camera:zoomTo(_Camera.scale-0.1)
  end
end

function LevelEditor:mousereleased(x,y,button)
  if self.MPX == x and self.MPY == y then
    if button == "r" and self.selected and not self.hover then
      self.selected = nil
    end
  end
  self.MPX, self.MPY = nil, nil
  if button == "l" then self.checkhover = true end
end

function LevelEditor:keypressed(key, isrepeat)
  if key == "c" and not self.hover then
    _Camera:zoomTo(1)
    _Camera:lookAt(_Width/2,_Height/2)
  elseif key == "g" and not self.hover then
    self.guide = not self.guide
  end
end

function LevelEditor:touch(touch)
  if not self.touchdata.cam then self.touchdata.cam = {} end
  if not self.touchdata.cam.id and touch.state == BEGAN then self.touchdata.cam.id = touch.id end
  if touch.id == self.touchdata.cam.id then
    if touch.state == BEGAN then
      self.touchdata.cam.MPX, self.touchdata.cam.MPY = touch.x, touch.y
      self.touchdata.cam.CMX, self.touchdata.cam.CMY = _Camera:pos()
    elseif touch.state == MOVED then
      local X,Y = _Camera:worldCoords(touch.x,touch.y)
      local MPX, MPY = _Camera:worldCoords(self.touchdata.cam.MPX, self.touchdata.cam.MPY)
      _Camera:lookAt(self.touchdata.cam.CMX-(X-MPX),self.touchdata.cam.CMY-(Y-MPY))
    elseif touch.state == ENDED then
      local X,Y = _Camera:worldCoords(touch.x,touch.y)
      local MPX, MPY = _Camera:worldCoords(self.touchdata.cam.MPX, self.touchdata.cam.MPY)
      _Camera:lookAt(self.touchdata.cam.CMX-(X-MPX),self.touchdata.cam.CMY-(Y-MPY))
      self.touchdata.cam = {}
    end
  end
end