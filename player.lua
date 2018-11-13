require "utils"
playerO = {}
playerO.__index = playerO

function playerO:new(pnum,gunType,xSpeed,grav,jumpSpeed,x,y)
  local newPlayer = {}
    newPlayer.x=x or love.math.random()
    newPlayer.y=y or love.math.random()
    newPlayer.pnum = pnum
    newPlayer.gunType = gunType
    newPlayer.xSpeed = xSpeed
    newPlayer.grav = grav
    newPlayer.jumpSpeed = jumpSpeed
  setmetatable(newPlayer, playerO)
  return newPlayer
end

function playerO:keyboardPressed(btn)
  if self.pnum == 1 then
    if btn == "left" then
      self.x = self.x - self.xSpeed
    elseif btn == "right" then
      self.x = self.x + self.xSpeed
    end
  end
end

function playerO:update()
  if self.pnum == 1 then
    if love.keyboard.isDown("left") then
      self.x = self.x - self.xSpeed
    elseif love.keyboard.isDown("right") then
      self.x = self.x + self.xSpeed
    end
  end
end

function playerO:draw()
  love.graphics.rectangle("fill",self.x*windowWidth,self.y*windowHeight,4,4)
end
