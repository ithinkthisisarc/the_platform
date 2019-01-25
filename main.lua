-- DEPENDANCIES
keyutils = require( "src/keyutils" )
utils = require( "src/utils" )

-- GLOBAL VARS
platform = {}
player = {}
objects = {}

jumps = true
deltatime = 0
max_height = 100

-- MAIN CHUNK
function love.load()
    display = {
        width = love.graphics.getWidth(),
        height = love.graphics.getHeight(),
        middleX = love.graphics.getWidth() / 2,
        middleY = love.graphics.getHeight() / 2
    }

    platform.width = display.width    -- This makes the platform as wide as the whole game window.
	platform.height = display.height  -- This makes the platform as tall as the whole game window.
 
        -- This is the coordinates where the platform will be rendered.
	platform.x = 0
    platform.y = platform.height / 1.5
    
        -- This is the coordinates where the player character will be rendered.
	player.x = display.middleX
	player.y = platform.height
 
        -- This calls the file named "purple.png" and puts it in the variable called player.img.
    player.img = love.graphics.newImage('pictures/purple.png')
    player.speed = 200
    player.ground = platform.y
 
    player.jump_height = -200
	player.y_velocity = 0        -- Whenever the character hasn't jumped yet, the Y-Axis velocity is always at 0.
 
    player.gravity = -500        -- Whenever the character falls, he will descend at this rate.
end
 
function love.update(dt)
    deltatime = dt
    check_keys(dt)      
    -- This is in charge of the jump physics.
    if player.y_velocity ~= 0 then
        player.y = player.y + player.y_velocity * dt                -- This makes the character ascend/jump.
        player.y_velocity = player.y_velocity - player.gravity * dt -- This applies the gravity to the character.
    end
    -- This is in charge of collision, making sure that the character lands on the ground.
    if player.y > player.ground then    -- The game checks if the player has jumped.
        player.y_velocity = 0       -- The Y-Axis Velocity is set back to 0 meaning the character is on the ground again.
        player.y = player.ground    -- The Y-Axis Velocity is set back to 0 meaning the character is on the ground again.
    end

    if player.y_velocity == 0 then
        jumps = true
    end
    if player.y < max_height then
        jumps = false
    end

    utils.spawn_rock(deltatime)
end

--[[function love.keypressed(key, scancode, isrepeat)
    if scancode == "w" and player.y_velocity ~= 0 then
        jumps = true
    end
end]]
 
function love.draw()
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
	love.graphics.setColor(1, 1, 1)        -- This sets the platform color to white.
 
    -- The platform will now be drawn as a white rectangle while taking in the variables we declared above.
    love.graphics.rectangle('fill', platform.x, platform.y, platform.width, platform.height/10)
    love.graphics.draw(player.img, player.x, player.y, 0, 1, 1, 0, 32)
    for i=1, #objects, 1 do
        local rock = objects[i]
        love.graphics.setColor(0, 0, 0)
        utils.draw_rock(rock, deltatime)
        if player.y == rock.y and (player.x >= rock.x+5 or player.x <= rock.x-5) then
            love.graphics.print("YOU DIED :(", 200, 200)
        end

        if rock.y > player.ground then
            table.remove(objects, i)
        end
    end

    -- debugging
    love.graphics.setColor(1, 1, 1)
    if jumps == true then
        jump_text = "true"
    elseif jumps == false then
        jump_text = "false"
    else
        jump_text = "hmmmm what"
    end
    love.graphics.print("JUMPS: "..jump_text.."\nDELTATIME: "..deltatime.."\nPLAYER.X: "..player.x.."\nPLAYER.Y: "..player.y.."\nTIME: "..utils.time.."\nX_VAL: "..utils.x_val, 5, 5)
end