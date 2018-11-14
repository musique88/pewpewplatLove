require "utils"
playerO = {}
playerO.__index = playerO

function playerO:new(pnum,gunType,xSpeed,maxXSpeed,maxYSpeed,grav,jumpSpeed,x,y,w,h)
  local newPlayer = {}
    newPlayer.x=x or love.math.random(1280)
    newPlayer.y=y or love.math.random(720)
    newPlayer.w=w or love.math.random(50)
    newPlayer.h=h or love.math.random(50)
    newPlayer.xSpeed = xSpeed or 0.5
    newPlayer.pnum = pnum or 1
    newPlayer.gunType = gunType or randomGun(1)
    newPlayer.maxSpeed = vectorO:new(maxXSpeed or 5,maxYSpeed or 5)
    newPlayer.grav = grav or 1
    newPlayer.jumpSpeed = jumpSpeed or 5
    newPlayer.isGrounded = false
    newPlayer.a = vectorO:new(0,0)
  setmetatable(newPlayer, playerO)
  return newPlayer
end

function playerO:update()
  --inputs
  if self.pnum == 1 then
    if love.keyboard.isDown("left") then
      if self.a.x >= -self.maxSpeed.x then
        self.a.x = self.a.x - self.xSpeed
      end
    elseif love.keyboard.isDown("right") then
      if self.a.x <= self.maxSpeed.x then
        self.a.x = self.a.x + self.xSpeed
      end
    else
      self.a.x = 0
    end
    if self.isGrounded then
      if love.keyboard.isDown("up") then

      end
    else
      if love.keyboard.isDown("down") then
        self.a.y = self.a.y + self.grav
      end
      self.a.y = self.a.y + self.grav
      if self.a.y >= self.maxSpeed.y then
        self.a.y = self.maxSpeed.y
      end
    end
    --actually moving
    self.x = self.x + self.a.x
    self.y = self.y + self.a.y
    --collision
    local boundingBox = rectangleO:newReturn(self.x,self.y,self.w,self.h)
    for i=1, #rectangles do
      if CheckCollision(rectangles[i],boundingBox)then
        
      end
    end
  end
end

function playerO:draw()
  love.graphics.setColor(0,0,1)
  love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
end
