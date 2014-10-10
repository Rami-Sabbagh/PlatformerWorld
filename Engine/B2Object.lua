--Author : Ramilego4Game - This File Is Part Of Platformer World--
--Type : Class/API--
B2Object = class:new()

function B2Object:init(world)
  self.world = world
  --self.map = {}
end

--Creates new Edge B2Object
function B2Object:newEdge(xS,yS,xE,yE,type)
  xE, yE = xE - xS, yE - yS
  
  local object = {}
  object.body = love.physics.newBody( self.world, xS, yS, type )
  object.body:setMass(5)
  object.shape = love.physics.newEdgeShape( 0, 0, xE, yE )
  object.fixture = love.physics.newFixture( object.body, object.shape, 1 )
  object.fixture:setRestitution(0)
  object.fixture:setFriction(.5)
  
  return object
end

--Creates new Player B2Object
function B2Object:newPlayerBody(X,Y)
  local object = {}
  object.body = love.physics.newBody( self.world, X, Y, "dynamic" )
  object.body:setMass(1)
  object.shape = love.physics.newPolygonShape(-11,-46,11,-46,33,-24,33,27,18,46,-18,46,-33,27,-33,-24)
  object.fixture = love.physics.newFixture(object.body, object.shape, 0.5)
  object.fixture:setRestitution(0)
  object.fixture:setFriction(.5)
  
  return object
end

--Creates new Tile B2Object
function B2Object:newTile(X,Y,Width,Height)
  local object = {}
  
  object.body = love.physics.newBody( self.world, X, Y )
  
  X, Y = 0, 0
  
  object.shape1 = love.physics.newEdgeShape( X, Y, Width, Y )
  object.fixture1 = love.physics.newFixture( object.body, object.shape1 )
  
  object.shape2 = love.physics.newEdgeShape( Width, Y, Width, Height )
  object.fixture2 = love.physics.newFixture( object.body, object.shape2 )
  
  object.shape3 = love.physics.newEdgeShape( Width, Height, X, Height )
  object.fixture3 = love.physics.newFixture( object.body, object.shape3 )
  
  object.shape4 = love.physics.newEdgeShape( X, Height, X, Y )
  object.fixture4 = love.physics.newFixture( object.body, object.shape4 )
  
  return object
end

--Creates new Box B2Object
function B2Object:newBox(X,Y,Width,Height,type)
  
  local object = {}
  object.body = love.physics.newBody( self.world, X, Y, type )
  object.body:setMass(5)
  object.shape = love.physics.newRectangleShape( Width/2, Height/2, Width, Height)
  object.fixture = love.physics.newFixture( object.body, object.shape, 1 )
  object.fixture:setRestitution(0)
  object.fixture:setFriction(.5)
  
  return object
end