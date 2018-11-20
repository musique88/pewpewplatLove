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
  love.graphics.setNewFont(12)
  love.graphics.setColor(1,1,1)
  love.graphics.print(roundTimer,0,0)
  love.graphics.print(#bullets,200)
end

function deadScreen()
  if showDeadScreen then
    map()
      players = {playerO:new(1,"pistol",-1000,-1000), playerO:new(2,"pistol",-1000,-1000)}
    love.graphics.setNewFont(20)
    if roundTimer < -3 then
      love.graphics.print("Player "..previousWinner.." won!",640,360)
    elseif roundTimer < -2 then
      love.graphics.print("3",640,360)
    elseif roundTimer < -1 then
      love.graphics.print("2",640,360)
    elseif roundTimer < 0 then
      love.graphics.print("1",640,360)
    else
      reset()
    end
  end
end

function reset()
  bullets = {}
  players = {playerO:new(1,"pistol"), playerO:new(2,"pistol")}
  deadBullets={}
  roundTimer=0
  showDeadScreen = false
end

function assignCollisionBox(self)
  local temp = {
    tl = vectorO:new(self.x          + 1, self.y          + 1),
    tr = vectorO:new(self.x + self.w - 1, self.y          + 1),
    ml = vectorO:new(self.x          + 1, self.y + self.step + 1),
    mr = vectorO:new(self.x + self.w - 1, self.y + self.step + 1),
    bl = vectorO:new(self.x          + 1, self.y + self.h - 1),
    br = vectorO:new(self.x + self.w - 1, self.y + self.h - 1)
  }
  return temp
end

function deleteFromTable(array, object)
  local arrayLength = #array
  for i=1, arrayLength do
    if array[i] == object then
      table.remove(array, i)
      return
    end
  end
end

function rectangleRectanglesCollision(r1, r2)
  --code inspired from https://love2d.org/wiki/BoundingBox.lua
  return r1.x < r2.x+r2.w and
         r2.x < r1.x+r1.w and
         r1.y < r2.y+r2.h and
         r2.y < r1.y+r1.h
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
