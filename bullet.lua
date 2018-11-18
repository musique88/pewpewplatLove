require "utils"
require "maps"

bulletO = {}
bulletO.__index = bulletO

function bulletO:new(x,y,d,type)
  newBullet = {}
  newBullet.x=x
  newBullet.y=y
  newBullet.d=d
  setmetatable(newBullet,bulletO)
  table.insert(bullets,newBullet)
end

function bulletO:update()
  if self.type=="pistol" then
    local speed = 1
    if self.d == "right" then
      self.x = self.x + speed
    else
      self.x = self.x - speed
    end
  end
end

function bulletO:draw()
  if self.type=="pistol" then
    love.graphics.rectangle(self.x,self.y,4,4)
  end
end
