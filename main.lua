require "utils"
require "rectangle"
require "player"
require "maps"

function love.load()
  love.window.setMode(1280,720)
  --array resets
  reset()
end

function reset()
  rectangles = {}
  players = {playerO:new(1,"pistol")}
  map()
  -- windowWidth, windowHeight = love.window.getMode()
end

function love.update()
  mouseX, mouseY = love.mouse.getPosition()
  escape()
  for i=1, #players do
    players[i]:update()
  end
end

function love.keypressed(key)
  if key == "r" then
    reset()
  end
end

function love.draw()
  for i=1, #rectangles do
    rectangles[i]:draw()
  end
  for i=1, #players do
    players[i]:draw()
  end
  debug()
end
