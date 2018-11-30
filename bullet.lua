require "utils"
require "maps"

bulletO = {}
bulletO.__index = bulletO

function bulletO:new(x,y,d,type,id)
  local newBullet = {}
  newBullet.x=x
  newBullet.y=y
  newBullet.d=d
  if type== "pistol" then
    newBullet.dmg = 2.5
    newBullet.a = vectorO:new(20,0)
  elseif type == "shotgun" then
    newBullet.dmg = 2
    newBullet.a = vectorO:new(love.math.random(15,20),love.math.random(-5,5))
  elseif type == "smg" then
    newBullet.dmg = 0.3
    newBullet.a = vectorO:new(love.math.random(15,20),love.math.random(-2,2))
  end
  newBullet.type=type
  newBullet.id=id
  newBullet.timer=0
  setmetatable(newBullet,bulletO)
  table.insert(bullets,newBullet)
end

function bulletO:update()
  if self.d == "right" then
    self.x = self.x + self.a.x
  else
    self.x = self.x - self.a.x
  end
  self.y = self.y + self.a.y
  if self.type=="shotgun" and self.timer >= 20 then
    table.insert(deadBullets, self)
  elseif self.type=="smg" and self.timer >= 30 then
    table.insert(deadBullets, self)
  end
  for i=1, #rectangles do
    if rectangleRectanglesCollision(rectangles[i], rectangleO:newReturn(self.x,self.y,4,4)) then
      table.insert(deadBullets, self)
    end
  end
  self.timer = self.timer + 1
end

function bulletO:draw()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill",self.x,self.y,4,4)
end
