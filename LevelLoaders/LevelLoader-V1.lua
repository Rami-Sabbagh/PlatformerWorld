--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/API--
LevelLoader = class:new()

function LevelLoader:init(world)
  self.world = world
  self.map = {}
end

--This function will draw the map that it's loaded with LevelLoader:loadMap(map)
function LevelLoader:drawMap()
  for x,yC in pairs(self.map) do
    if yC ~= nil then
      for y,Objects in pairs(yC) do
        if Objects ~= nil then
          for k,object in pairs(Objects) do
            if object.marker ~= nil and object.tile ~= nil and object.tile.draw ~= nil then
              if not object.tile.dynamic and object.tile.category == "Decor" then
                self.map[x][y][k].tile:draw(object.marker,self.map)
              end
            end
          end
        end
      end
    end
  end
  
  for x,yC in pairs(self.map) do
    if yC ~= nil then
      for y,Objects in pairs(yC) do
        if Objects ~= nil then
          for k,object in pairs(Objects) do
            if object.marker ~= nil and object.tile ~= nil and object.tile.draw ~= nil then
              if not object.tile.dynamic and object.tile.category ~= "Decor" then
                self.map[x][y][k].tile:draw(object.marker,self.map)
              end
            end
          end
        end
      end
    end
  end
  
  for x,yC in pairs(self.map) do
    if yC ~= nil then
      for y,Objects in pairs(yC) do
        if Objects ~= nil then
          for k,object in pairs(Objects) do
            if object.marker ~= nil and object.tile ~= nil and object.tile.draw ~= nil then
              if object.tile.dynamic then
                self.map[x][y][k].tile:draw(object.marker,self.map)
              end
            end
          end
        end
      end
    end
  end
end

--This function will update the map that it's loaded with LevelLoader:loadMap(map)
function LevelLoader:updateMap(players,dt)
  for x,yC in pairs(self.map) do
    if yC ~= nil then
      for y,Objects in pairs(yC) do
        if Objects ~= nil then
          for k,object in pairs(Objects) do
            if object.marker ~= nil and object.tile ~= nil and object.tile.update ~= nil then
              self.map[x][y][k].tile:update(object.marker,self.map,players,dt)
            end
          end
        end
      end
    end
  end
end

--This function will draw the map that it's encoded with LevelLoader:encodeMap(map)
function LevelLoader:drawEditorMap(map)
  for x,yC in pairs(map) do
    if yC ~= nil then
      for y,Objects in pairs(yC) do
        if Objects ~= nil then
          for k,object in pairs(Objects) do
            if object.tile ~= nil and object.marker ~= nil then
              map[x][y][k].tile:draw(object.marker,map)
            end
          end
        end
      end
    end
  end
  return map
end

--This function will encode the map that it's passed as a parameter
function LevelLoader:encodeMap(map)
  local encodedMap = {}
  for x,xC in pairs(map) do
    if type(map[x]) ~= nil then
      for y,yC in pairs(map[x]) do
        if map[x][y] ~= nil then
          for k,v in pairs(map[x][y]) do
            if map[x][y][k] ~= nil then
              if love.filesystem.exists( "Engine/Tiles/"..k..".lua" ) then
                local marker = map[x][y][k] or {}
                marker.x, marker.y = x, y
                local tile = _TilesList[k]:new()
                if encodedMap[x] == nil then encodedMap[x] = {} end
                if encodedMap[x][y] == nil then encodedMap[x][y] = {} end
                encodedMap[x][y][k] = {}
                encodedMap[x][y][k].tile = tile
                encodedMap[x][y][k].marker = marker
              end
            end
          end
        end
      end
    end
  end
  return encodedMap
end

function LevelLoader:loadMap(map)
  self.map = self:encodeMap(map)
  self:buildMap()
end

function LevelLoader:buildMap()
  for x,yC in pairs(self.map) do
    if yC ~= nil then
      for y,Objects in pairs(yC) do
        if Objects ~= nil then
          for k,object in pairs(Objects) do
            if object.marker ~= nil and object.tile ~= nil and object.tile.create ~= nil then
              self.map[x][y][k].tile:create(object.marker,self.map)
            end
          end
        end
      end
    end
  end
end

function LevelLoader:destroyMap()
  for x,yC in pairs(self.map) do
    if yC ~= nil then
      for y,Objects in pairs(yC) do
        if Objects ~= nil then
          for k,object in pairs(Objects) do
            if object.marker ~= nil and object.tile ~= nil and object.tile.destroy ~= nil then
              self.map[x][y][k].tile:destroy()
            end
          end
        end
      end
    end
  end
end