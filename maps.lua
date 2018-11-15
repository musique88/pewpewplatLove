function map(id)
  local id = id or love.math.random(1)
  if id == 1 then
    rectangles = {}
    rectangleO:new(0,0,20,720)
    rectangleO:new(0,700,1280,20)
    rectangleO:new(1260,0,20,720)
    rectangleO:new(500,400,100,500)
  end
end
