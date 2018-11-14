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
  local oldPosX = self.x
  local oldPosY = self.y
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
    local colCheck = {
      vectorO:new(self.x,self.y),
      vectorO:new(self.x+self.w, self.y),
      vectorO:new(self.x+self.w, self.y+self.h),
      vectorO:new(self.x,self.y+self.h)
    }
    for i=1, #rectangles do
      for j=1, #colCheck do
        if colCheck[j]:isInRectangle(rectangles[i]) then
          if colCheck[j]:isInXRectangle(rectangles[i]) then
            self.x = oldPosX
            self.isGrounded = true
          elseif colCheck[j]:isInYRectangle(rectangles[i]) then
            self.y = oldPosY
            self.isGrounded = true
          end
        end
      end
    end
  end
end

function playerO:draw()
  love.graphics.setColor(0,0,1)
  love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
end
