require "bullet"
function shoot(self)
  if self.gun == "pistol" then
    if self.shootTimer>=self.fireRate then
      bulletO:new(self.x+self.w/2,self.y+self.h/2,self.d,self.gunType,self.pnum)
      self.shootTimer = 0
    end
  end
end
