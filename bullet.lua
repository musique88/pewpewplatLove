require "utils"
require "maps"

bulletO = {}
bulletO.__index = bulletO

function bulletO:new(x,y,d,type,id)
  local newBullet = {}
  newBullet.x=x
  newBullet.y=y
  newBullet.d=d
  newBullet.type=type
  newBullet.id=id
  newBullet.timer=0
  setmetatable(newBullet,bulletO)
  table.insert(bullets,newBullet)
end

function bulletO:update()
  if self.type=="pistol" then
    local speed = 20
    if self.d == "right" then
      self.x = self.x + speed
    else
      self.x = self.x - speed
    end
    for i=1, #rectangles do
      if rectangleRectanglesCollision(rectangles[i], rectangleO:newReturn(self.x,self.y,4,4)) then
        table.insert(deadBullets, self)
      end
    end
  end
end

function bulletO:draw()
  if self.type=="pistol" then
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",self.x,self.y,4,4)
  end
end
