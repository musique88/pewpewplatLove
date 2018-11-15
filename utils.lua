function randomGun(gunNumber)
  local gun = love.math.random(gunNumber)
  if gun == 1 then
    return "pistol"
  end
end

function escape()
  if love.keyboard.isDown("escape") then
    love.event.quit()
  end
end

function debug()
  if players[1].isGrounded then
    love.graphics.print("True")
  else
    love.graphics.print("False")
  end
end

function assignCollisionBox(self)
  local temp = {
    tl = vectorO:new(self.x          + 1, self.y          + 1),
    tr = vectorO:new(self.x + self.w - 1, self.y          + 1),
    bl = vectorO:new(self.x          + 1, self.y + self.h - 1),
    br = vectorO:new(self.x + self.w - 1, self.y + self.h - 1)
  }
  return temp
end

--/vectorO

vectorO = {}
vectorO.__index = vectorO

function vectorO:new(x,y)
  newVector = {x=x, y=y}
  setmetatable(newVector, vectorO)
  return newVector
end

function vectorO:length()
  return sqrt((self.x^2)+(self.y^2))
end

function vectorO:isInRectangle(rect)
  return self.x >= rect.x and self.x <= rect.x + rect.w and
         self.y >= rect.y and self.y <= rect.y + rect.h
end

function vectorO:closestDistanceOut(rect, sensibility)
  local posIn = vectorO:new(self.x-rect.x,self.y-rect.y)
  local temp = vectorO:new(0,0)
  if posIn.x < sensibility then
    temp.x = -posIn.x
  elseif rect.w - posIn.x < sensibility then
    temp.x = rect.w - posIn.x
  end
  if posIn.y < sensibility then
    temp.y = -posIn.y
  elseif rect.h - posIn.y < sensibility then
    temp.y = rect.h - posIn.y
  end
  return temp
end

--vectorO/
