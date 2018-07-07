--[[
    GD50 2018
    Pong Remake

    -- Ball Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents a ball which will bounce back and forth between paddles
    and walls until it passes a left or right boundary of the screen,
    scoring a point for the opponent.
]]

Ball = Class{}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    -- these variables are for keeping track of our velocity on both the
    -- X and Y axis, since the ball can move in two dimensions
    self.dy = 0
    self.dx = 0
end

--[[
    Expects a paddle as an argument and returns true or false, depending
    on whether their rectangles overlap.
    
    The extra step to check which side the paddle is on is to prevent
    the ball from "phasing through" the paddle when the ball is moving
    very fast (greater than the width of the paddle in one time step)
]]
function Ball:collides(paddle)            
    -- check if left paddle can collide
    if (paddle.side == 0) and
       (self.x > paddle.x + paddle.width) then
            return false
    -- check if right paddle can collide
    elseif (paddle.x > self.x + self.width) then
            return false
    end
    
    -- check if ball is lined up with paddle vertically
    if (self.y > paddle.y + paddle.height) or
       (paddle.y > self.y + self.height) then
       return false
    end
    
    -- collision registered
    return true
end

--[[
    Places the ball in the middle of the screen, with no movement.
]]
function Ball:reset()
    self.x = VIRTUAL_WIDTH / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2
    self.dx = 0
    self.dy = 0
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end