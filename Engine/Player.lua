--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/Object--
Player = class:new()

function Player:init(X,Y,Num,Key)
  self.X = UI:forceNum(X) or _Width/2
  self.Y = UI:forceNum(Y) or _Height/2
  self.Num = UI:forceNum(Num) or 1
  self.Key = UI:forceNum(Key) or self.Num
  
  self.KeySet = {}
  self.KeySet[1] = { up = "up", down = "down", left = "left", right = "right" }
  self.KeySet[2] = { up = "w", down = "s", left = "a", right = "d" }
  self.KeySet[3] = { up = "i", down = "k", left = "j", right = "l" }
  
  self.Shape = { State = "front", Flip = false, Walk = false, WalkTimer = 0, WalkSpeed = -1, OrginX = 0, OrginY = 0 }
  
  self:Box2D(self.X, self.Y)
end

function Player:Box2D(X,Y)
  self.object = B2Object:newPlayerBody(X,Y)
  self.object.body:setFixedRotation(true)
  self.object.fixture:setUserData("Player "..self.Num)
end

function Player:update(dt)
  self.X, self.Y = self.object.body:getPosition()
  
  local X,Y = self.object.body:getLinearVelocity()
  self.object.body:setLinearVelocity( X, Y+100 )
  
  local KeySet = self.KeySet[self.Key]
  if _Keys[KeySet.left] then
    local X,Y = self.object.body:getLinearVelocity()
    self.object.body:setLinearVelocity( -500, Y )
    self.Shape.State = "walk"
    self.Shape.Flip = true
    if not self.Shape.Walk then self.Shape.Walk, self.Shape.WalkTimer = 1, 0 end
    self.Shape.OrginX = 0
    self.Shape.OrginY = 0
  elseif _Keys[KeySet.right] then
    local X,Y = self.object.body:getLinearVelocity()
    self.object.body:setLinearVelocity( 500, Y )
    self.Shape.State = "walk"
    self.Shape.Flip = false
    if not self.Shape.Walk then self.Shape.Walk, self.Shape.WalkTimer = 1, 0 end
    self.Shape.OrginX = 0
    self.Shape.OrginY = 0
  else
    self.Shape.State = "stand"
    if self.Shape.Walk then
      local X,Y = self.object.body:getLinearVelocity()
      self.object.body:setLinearVelocity( 0, Y )
    end
    self.Shape.Walk = false
    self.Shape.OrginX = 0
    self.Shape.OrginY = 0
  end
  
  if _Keys[KeySet.up] then
    if _Keys[KeySet.up] < 3 then 
      _Keys[KeySet.up] = _Keys[KeySet.up] + 1
      local X,Y = self.object.body:getLinearVelocity()
      self.object.body:setLinearVelocity( X, Y-650 )
    end
    self.Shape.State = "jump"
    self.Shape.Walk = false
    self.Shape.OrginX = 0
    self.Shape.OrginY = 0
  elseif _Keys[KeySet.down] then
    self.Shape.State = "duck"
    if self.Shape.Walk then
      local X,Y = self.object.body:getLinearVelocity()
      self.object.body:setLinearVelocity( 0, Y )
    end
    self.Shape.Walk = false
    self.Shape.OrginX = 0
    self.Shape.OrginY = 11
  end
end

function Player:draw()
  if self.Shape.Walk then
    self.Shape.State = "walk" .. self.Shape.Walk
  end
  UI:Draw("p"..self.Num.."_"..self.Shape.State,self.X+self.Shape.OrginX,self.Y+self.Shape.OrginY,nil,nil,nil,true,self.Shape.Flip)
  if self.Shape.Walk then
    self.Shape.State = "walk"
    self.Shape.WalkTimer = self.Shape.WalkTimer + 1
    if self.Shape.WalkTimer > -self.Shape.WalkSpeed then
      self.Shape.WalkTimer = 0
      self.Shape.Walk = self.Shape.Walk + 1
      if self.Shape.Walk > 11 then self.Shape.Walk = 1 end
    end
  end
end

function Player:Destroy()
  self.object.body:destroy()
end