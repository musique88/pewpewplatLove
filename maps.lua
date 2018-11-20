function map(id)
  local id = id or love.math.random(1)
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
  end
end
