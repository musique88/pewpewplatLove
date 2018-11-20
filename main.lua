require "utils"
require "rectangle"
require "player"
require "maps"
require "bullet"

function love.load()
  love.window.setMode(1280,720)
  --array resets
  reset()
end

function reset()
  rectangles = {}
  bullets = {}
  players = {playerO:new(1,"pistol"), playerO:new(2,"pistol")}
  map()
  -- windowWidth, windowHeight = love.window.getMode()
end

function love.update()
  escape()
  deadBullets = {}
  for i=1, #players do
    players[i]:update()
  end
  for i=1, #bullets do
    bullets[i]:update()
  end
  if #deadBullets > 0 then
    for i = 0, #deadBullets do
      deleteFromTable(bullets,deadBullets[i])
    end
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
  for i=1, #bullets do
    bullets[i]:draw()
  end
  for i=1, #players do
    players[i]:draw()
  end
  debug()
end
