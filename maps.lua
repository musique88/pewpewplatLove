function map(id)
  local id = id or love.math.random(2)
  if id == 1 then
    rectangles = {}
    rectangleO:new(-100,0,120,720)
    rectangleO:new(0,700,1280,120)
    rectangleO:new(1260,0,120,720)
    rectangleO:new(500,400,100,500)
    rectangleO:new(100,675,100,100)
    rectangleO:new(300,550,100,40)
    rectangleO:new(700,675,100,100)
    rectangleO:new(500,550,110,500)
    rectangleO:new(900,699,100,100,"bouncing")
    rectangleO:new(1000,300,260,50)
  elseif id == 2 then
    rectangles = {}
    rectangleO:new(-1000,-1000,1010,2280,"normal")
    rectangleO:new(0,710,1280,1010,"normal")
    rectangleO:new(1270,-1000,1010,2280,"normal")
    rectangleO:new(363,233,231,165,"normal")
    rectangleO:new(265,383,169,138,"normal")
    rectangleO:new(539,577,194,111,"normal")
  end
end
