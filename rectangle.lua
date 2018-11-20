rectangleO = {}
rectangleO.__index = rectangleO

function rectangleO:new(x,y,w,h,type)
  local newRectangle = {x=x,y=y,w=w,h=h,type=type or "normal"}
  setmetatable(newRectangle, rectangleO)
  table.insert(rectangles, newRectangle)
end

function rectangleO:newReturn(x,y,w,h,type)
  local newRectangle = {x=x,y=y,w=w,h=h,type=type or "normal"}
  setmetatable(newRectangle, rectangleO)
  return newRectangle
end

function rectangleO:draw(color)
  if self.type == "normal" then
    love.graphics.setColor(1,0,0)
  elseif self.type == "bouncing" then
    love.graphics.setColor(0.5,0,0)
  end
  love.graphics.rectangle("fill",
  self.x,self.y,self.w,self.h
  )
end
