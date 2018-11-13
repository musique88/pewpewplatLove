rectangleO = {}
rectangleO.__index = rectangleO

function rectangleO:new(x,y,w,h)
  local newRectangle = {x=x,y=y,w=w,h=h}
  setmetatable(newRectangle, rectangleO)
  table.insert(rectangles, newRectangle)
end

function rectangleO:draw(color)
  love.graphics.setColor(1,0,0)
  love.graphics.rectangle("fill",
  self.x*windowWidth,
  self.y*windowHeight,
  self.w*windowWidth,
  self.h*windowHeight
  --self.x,self.y,self.w,self.h
  )
end
