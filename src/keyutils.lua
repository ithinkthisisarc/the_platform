kutils = {}

function check_keys(dt)
	if love.keyboard.isDown('d') then
		-- This makes sure that the character doesn't go pass the game window's right edge.
		if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
			player.x = player.x + (player.speed * dt)
		end
	elseif love.keyboard.isDown('a') then
		-- This makes sure that the character doesn't go pass the game window's left edge.
		if player.x > 0 then 
			player.x = player.x - (player.speed * dt)
        end
	end
    if love.keyboard.isDown('w') then
        if jumps == true then
            player.y_velocity = player.jump_height    -- The player's Y-Axis Velocity is set to it's Jump Height.
        end
    end
end

return kutils