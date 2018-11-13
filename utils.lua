function restart()
  if love.keyboard.isDown("r") then
    love.load()
  end
end

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

--/vectorO

vectorO = {}
vectorO.__index = vectorO

function vectorO:new(x,y)
  return {x=x, y=y}
end

function vectorO:length()
  return sqrt((self.x^2)+(self.y^2))
end

function vectorO:angle()
  return atan(self.y/self.x)
end

function vectorO:isInRectangle(rect)
  return self.x >= rect.x and self.x <= rect.x + rect.w and
         self.y >= rect.y and self.y <= rect.y + rect.h
end

--vectorO/
