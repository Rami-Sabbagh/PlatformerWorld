--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/API--
HUD = class:new()

function HUD:init()
  self.data = {}
  self.data[1] = {heart=6,score="0",gems={blue=false,green=false,red=false,yellow=false},keys={blue=false,green=false,red=false,yellow=false}}
  self.data[2] = {heart=6,score="0",gems={blue=false,green=false,red=false,yellow=false},keys={blue=false,green=false,red=false,yellow=false}}
  self.data[3] = {heart=6,score="0",gems={blue=false,green=false,red=false,yellow=false},keys={blue=false,green=false,red=false,yellow=false}}
end

--Sets witch player HUD to show on the screen
function HUD:setPlayer(num)
  self.player = UI:forceNum(num)
end

--Adds coins to the player
function HUD:addScore(num,playernum)
  local playernum = playernum or self.player
  local score = tonumber(self.data[playernum].score)
  self.data[playernum].score = tostring(score+num)
end

--The hud draw function that should be called at love.draw
function HUD:draw()
  if not self.player then return end
  local State = ""
  --Player ICON--
  UI:Draw("hud_p"..self.player.."Alt",10,10)
  
  --Player Hearts--
  local HeartOrg = {67,97,127}--137
  if self.data[self.player].heart >= 2 then
    UI:Draw("hud_heartFull",HeartOrg[1],20,25,25)
  elseif self.data[self.player].heart == 1 then
    UI:Draw("hud_heartHalf",HeartOrg[1],20,25,25)
  elseif self.data[self.player].heart < 1 then
    UI:Draw("hud_heartEmpty",HeartOrg[1],20,25,25)
  end
  
  if self.data[self.player].heart >= 4 then
    UI:Draw("hud_heartFull",HeartOrg[2],20,25,25)
  elseif self.data[self.player].heart == 3 then
    UI:Draw("hud_heartHalf",HeartOrg[2],20,25,25)
  elseif self.data[self.player].heart < 3  then
    UI:Draw("hud_heartEmpty",HeartOrg[2],20,25,25)
  end
  
  if self.data[self.player].heart >= 6 then
    UI:Draw("hud_heartFull",HeartOrg[3],20,25,25)
  elseif self.data[self.player].heart == 5 then
    UI:Draw("hud_heartHalf",HeartOrg[3],20,25,25)
  elseif self.data[self.player].heart < 5 then
    UI:Draw("hud_heartEmpty",HeartOrg[3],20,25,25)
  end
  
  --Player Coins
  local CT = self:numToTable(self.data[self.player].score)
  local OrgineX = _Width - (67+#CT*5+#CT*26)
  for k,v in ipairs(CT) do
    UI:Draw("hud_"..v,OrgineX+k*5+k*26-26,15)
  end
  CT = #CT + 1
  UI:Draw("hud_coins",OrgineX+CT*5+CT*26-26+5,10)
end

--This function is use to splite the number to table, with number 50105 will a table like this {5,0,1,0,5}
function HUD:numToTable(num)
  num = tostring(num)
  local numChar, numTable = "",{}
  for cN=1,string.len(num) do
    numChar = string.sub(num,cN,cN)
    table.insert(numTable,cN,tonumber(numChar))
  end
  return numTable
end