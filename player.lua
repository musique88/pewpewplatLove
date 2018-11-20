require "utils"
require "bullet"

playerO = {}
playerO.__index = playerO

function playerO:new(pnum,gunType,xSpeed,friction,maxXSpeed,maxYSpeed,grav,
  jumpSpeed,x,y,w,h,step)
  local newPlayer = {}
    newPlayer.x=x or love.math.random(1280)
    newPlayer.y=y or love.math.random(720)
    newPlayer.w=w or 45
    newPlayer.h=h or 60 --love.math.random(50)
    newPlayer.d="right"
    newPlayer.step=step or newPlayer.h/2
    newPlayer.xSpeed = xSpeed or 0.5
    newPlayer.friction = friction or 1.3
    newPlayer.pnum = pnum or 1
    newPlayer.gunType = gunType or randomGun(1)
    newPlayer.maxSpeed = vectorO:new(maxXSpeed or 15,maxYSpeed or 50)
    newPlayer.grav = grav or 1
    newPlayer.jumpSpeed = jumpSpeed or 20
    newPlayer.canJump = false
    newPlayer.isGrounded = false
    newPlayer.a = vectorO:new(0,0)
  setmetatable(newPlayer, playerO)
  return newPlayer
end

function playerO:update()
  --inputs
  --player 1
  if self.pnum == 1 then
    if love.keyboard.isDown("left") then
      if self.a.x >= -self.maxSpeed.x then
        if self.a.x > 0 then
          self.a.x = self.a.x / self.friction
        end
        self.a.x = self.a.x - self.xSpeed
        self.d = "left"
      end
    elseif love.keyboard.isDown("right") then
      if self.a.x <= self.maxSpeed.x then
        if self.a.x < 0 then
          self.a.x = self.a.x / self.friction
        end
        self.a.x = self.a.x + self.xSpeed
        self.d = "right"
      end
    else
      self.a.x = self.a.x/self.friction
    end
    if self.isGrounded then
      if love.keyboard.isDown("up") and self.canJump then
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
    --bullets
    local canShoots = true
    if love.keyboard.isDown("z") then
      if canShoot  then
        bulletO:new(self.x+self.w/2,self.y+self.h/2,self.d,self.gunType,self.pnum)
        canShoot = false
      end
    else
      canShoot = true
    end
  --player 2
  elseif self.pnum == 2 then
    if love.keyboard.isDown("a") then
      if self.a.x >= -self.maxSpeed.x then
        if self.a.x > 0 then
          self.a.x = self.a.x / self.friction
        end
        self.a.x = self.a.x - self.xSpeed
      end
    elseif love.keyboard.isDown("d") then
      if self.a.x <= self.maxSpeed.x then
        if self.a.x < 0 then
          self.a.x = self.a.x / self.friction
        end
        self.a.x = self.a.x + self.xSpeed
      end
    else
      self.a.x = self.a.x/self.friction
    end
    if self.isGrounded then
      if love.keyboard.isDown("w") and self.canJump then
        self.a.y = self.a.y - self.jumpSpeed
      end
    else
      if love.keyboard.isDown("s") then
        self.a.y = self.a.y + self.grav
      end
      self.a.y = self.a.y + self.grav
      if self.a.y >= self.maxSpeed.y then
        self.a.y = self.maxSpeed.y
      end
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
  --collision with rectangles
  for i=1, #rectangles do
    while collisionBox.ml:isInRectangle(rectangles[i])
    and collisionBox.mr:isInRectangle(rectangles[i])
    and collisionBox.bl:isInRectangle(rectangles[i])
    and collisionBox.br:isInRectangle(rectangles[i])
    and collisionBox.tl:isInRectangle(rectangles[i])
    and collisionBox.tr:isInRectangle(rectangles[i]) do
      self.y = self.y - 1
      self.a.y = 0
      collisionBox = assignCollisionBox(self)
      lastCollisionChecked = "bottom"
    end
    --3 and 4 and 5 and 6 up
    while collisionBox.ml:isInRectangle(rectangles[i])
    and collisionBox.mr:isInRectangle(rectangles[i])
    and collisionBox.bl:isInRectangle(rectangles[i])
    and collisionBox.br:isInRectangle(rectangles[i]) do
      self.y = self.y - 1
      if self.a.y > 0 then
        self.a.y = 0
      end
      collisionBox = assignCollisionBox(self)
      lastCollisionChecked = "bottom"
    end
    --1 and 2 and 3 and 4 down
    while collisionBox.ml:isInRectangle(rectangles[i])
    and collisionBox.mr:isInRectangle(rectangles[i])
    and collisionBox.tl:isInRectangle(rectangles[i])
    and collisionBox.tr:isInRectangle(rectangles[i]) do
      self.y = self.y + 1
      if self.a.y < 0 then
        self.a.y = 0
      end
      collisionBox = assignCollisionBox(self)
      lastCollisionChecked = "top"
    end
    --3 right
    while collisionBox.ml:isInRectangle(rectangles[i]) do
      self.x = self.x + 1
      self.a.x = 0
      collisionBox = assignCollisionBox(self)
      lastCollisionChecked = "left"
    end
    --4 left
    while collisionBox.mr:isInRectangle(rectangles[i]) do
      self.x = self.x - 1
      self.a.x = 0
      collisionBox = assignCollisionBox(self)
      lastCollisionChecked = "right"
    end
    --5 or 6 up
    while collisionBox.bl:isInRectangle(rectangles[i])
    or collisionBox.br:isInRectangle(rectangles[i]) do
      self.y = self.y - 1
      if self.a.y > 0 then
        self.a.y = 0
      end
      collisionBox = assignCollisionBox(self)
      lastCollisionChecked = "bottom"
    end
    --1 or 2 down
    while collisionBox.tl:isInRectangle(rectangles[i])
    or collisionBox.tr:isInRectangle(rectangles[i]) do
      self.y = self.y + 1
      if self.a.y < 0 then
        self.a.y = 0
      end
      collisionBox = assignCollisionBox(self)
      lastCollisionChecked = "top"
    end
  end
  --collision with players
  for i=1, #players do
    if players[i].pnum ~= self.pnum then
      local otherPlayerRectangle = rectangleO:newReturn(players[i].x,
      players[i].y,players[i].w,players[i].h)
      while collisionBox.ml:isInRectangle(otherPlayerRectangle)
      and collisionBox.mr:isInRectangle(otherPlayerRectangle)
      and collisionBox.bl:isInRectangle(otherPlayerRectangle)
      and collisionBox.br:isInRectangle(otherPlayerRectangle)
      and collisionBox.tl:isInRectangle(otherPlayerRectangle)
      and collisionBox.tr:isInRectangle(otherPlayerRectangle) do
        self.y = self.y - 1
        self.a.y = 0
        collisionBox = assignCollisionBox(self)
        lastCollisionChecked = "bottom"
      end
      --3 and 4 and 5 and 6 up
      while collisionBox.ml:isInRectangle(otherPlayerRectangle)
      and collisionBox.mr:isInRectangle(otherPlayerRectangle)
      and collisionBox.bl:isInRectangle(otherPlayerRectangle)
      and collisionBox.br:isInRectangle(otherPlayerRectangle) do
        self.y = self.y - 1
        if self.a.y > 0 then
          self.a.y = 0
        end
        collisionBox = assignCollisionBox(self)
        lastCollisionChecked = "bottom"
      end
      --3 right
      while collisionBox.ml:isInRectangle(otherPlayerRectangle)do
        self.x = self.x + 1
        self.a.x = 0
        collisionBox = assignCollisionBox(self)
        lastCollisionChecked = "left"
      end
      --4 left
      while collisionBox.mr:isInRectangle(otherPlayerRectangle)do
        self.x = self.x - 1
        self.a.x = 0
        collisionBox = assignCollisionBox(self)
        lastCollisionChecked = "right"
      end
      --5 or 6 up
      while collisionBox.bl:isInRectangle(otherPlayerRectangle)
      or collisionBox.br:isInRectangle(otherPlayerRectangle) do
        self.y = self.y - 1
        self.a.y = -self.jumpSpeed
        if self.a.y > 0 then
          self.a.y = 0
        end
        collisionBox = assignCollisionBox(self)
        lastCollisionChecked = "bottom"
      end
    end
  end
  --Grounded?
  if lastCollisionChecked == "bottom" then
    self.isGrounded = true
  else
    self.isGrounded = false
  end
  --can i jump?
  if self.isGrounded and self.a.y >=-1 then
    self.canJump = true
  else
    self.canJump = false
  end
end

function playerO:draw()
  if self.pnum == 1 then
    love.graphics.setColor(0,0,1)
  elseif self.pnum == 2 then
    love.graphics.setColor(0,1,0)
  end
  love.graphics.rectangle("fill",self.x,self.y,self.w,self.h)
end
