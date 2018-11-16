require "utils"
playerO = {}
playerO.__index = playerO

function playerO:new(pnum,gunType,xSpeed,maxXSpeed,maxYSpeed,grav,jumpSpeed,x,y,w,h,step)
  local newPlayer = {}
    newPlayer.x=x or love.math.random(1280)
    newPlayer.y=y or love.math.random(720)
    newPlayer.w=w or love.math.random(50)
    newPlayer.h=h or love.math.random(50)
    newPlayer.step=step or newPlayer.h/2
    newPlayer.xSpeed = xSpeed or 0.5
    newPlayer.pnum = pnum or 1
    newPlayer.gunType = gunType or randomGun(1)
    newPlayer.maxSpeed = vectorO:new(maxXSpeed or 10,maxYSpeed or 10)
    newPlayer.grav = grav or 1
    newPlayer.jumpSpeed = jumpSpeed or 40
    newPlayer.isGrounded = false
    newPlayer.a = vectorO:new(0,0)
  setmetatable(newPlayer, playerO)
  return newPlayer
end

function playerO:update()
  local oldX = self.x
  local oldY = self.y
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
        self.a.y = self.a.y - self.jumpSpeed
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

    --[[
    -------
    |1   2|
    |3   4|
    |5   6|
    -------
    ]]
    local collisionBox = assignCollisionBox(self)
    local lastCollisionChecked = ""
    for i=1, #rectangles do
      --3 and 4 and 5 and 6 up 
      --1 and 2 and 3 and 4 down
      --3 right
      --4 left
      --5 or 6 up
    --   --bottom checking
    --   while collisionBox.bl:isInRectangle(rectangles[i]) and
    --         collisionBox.br:isInRectangle(rectangles[i]) do
    --     self.y = self.y - 1
    --     collisionBox = assignCollisionBox(self)
    --     lastCollisionChecked = "bottom"
    --   end
    --   --top checking
    --   while collisionBox.tr:isInRectangle(rectangles[i]) and
    --         collisionBox.tl:isInRectangle(rectangles[i]) do
    --     self.x = self.x + 1
    --     collisionBox = assignCollisionBox(self)
    --     lastCollisionChecked = "top"
    --   end
    --   --right checking
    --   while collisionBox.tr:isInRectangle(rectangles[i]) and
    --         collisionBox.br:isInRectangle(rectangles[i]) do
    --     self.x = self.x - 1
    --     collisionBox = assignCollisionBox(self)
    --     lastCollisionChecked = "right"
    --     self.a.x = 0
    --   end
    --   --left checking
    --   while collisionBox.tl:isInRectangle(rectangles[i]) and
    --         collisionBox.bl:isInRectangle(rectangles[i]) do
    --     self.x = self.x + 1
    --     collisionBox = assignCollisionBox(self)
    --     lastCollisionChecked = "left"
    --     self.a.x = 0
    --   end
    end
    --Grounded?
    if lastCollisionChecked == "bottom" then
      self.isGrounded = true
    else
      self.isGrounded = false
    end
  end
end

function playerO:draw()
  love.graphics.setColor(0,0,1)
  love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
end
