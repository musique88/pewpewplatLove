require "utils"
require "rectangle"
require "player"
require "maps"
require "bullet"

function love.load()
  love.window.setMode(1280,720)
  --array resets
  reset()
  map()
end

function love.update(dt)
  escape()
  if #deadBullets > 0 then
    for i = 0, #deadBullets do
      deleteFromTable(bullets,deadBullets[i])
    end
    deadBullets = {}
  end
  for i=1, #players do
    players[i]:update()
  end
  if players[1].health<= 0 then
    previousWinner = 2
    roundTimer = -4
    showDeadScreen = true
  end
  if players[2].health<= 0 then
    previousWinner = 1
    roundTimer = -4
    showDeadScreen = true
  end
  for i=1, #bullets do
    bullets[i]:update()
  end
  roundTimer = roundTimer+dt
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
  deadScreen()
  debug()
end
