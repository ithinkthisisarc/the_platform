utils = {}

utils.time = 1
utils.x_val = 0
rock_speed = 0.3
myTimer = 0

function utils.spawn_rock(dt)
    myTimer=myTimer+dt
    if myTimer > utils.time then
        utils.x_val = math.random(love.graphics.getWidth())
        table.insert(objects, {x=utils.x_val, y=0, speed=rock_speed})
        
        myTimer=myTimer-utils.time
   end
end

function utils.draw_rock(rock, dt)
    rock.speed = rock.speed + 0.7 + dt
    rock.y = rock.y + rock.speed
    love.graphics.circle("fill", rock.x, rock.y, 10, 100)
end

return utils
