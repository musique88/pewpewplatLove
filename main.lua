require "utils"
require "rectangle"
require "player"

function love.load()
  love.window.setMode(0, 0)
  --array resets
  rectangles = {}
  players = {playerO:new(1,randomGun(),0.5,1,4)}
  rectangleO:new(0.5, 0.5, 0.2, 0.2)
  windowWidth, windowHeight = love.window.getMode()
end

function love.update()
  mouseX, mouseY = love.mouse.getPosition()
  escape()
  for i=1, #players do
    players[i]:update()
  end
end

function love.keyPressed(key)
  for i=1, #players do
    players[i]:keyboardPressed(key)
  end
end

function love.draw()
  for i=1, #players do
    players[i]:draw()
  end
  for i=1, #rectangles do
    rectangles[i]:draw()
  end
end
