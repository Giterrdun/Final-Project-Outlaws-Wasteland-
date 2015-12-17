class Player

	TURN_INCREMENT = 4.5
	ACCELERATION = 0.25
	COLLISION_DISTANCE = 35
	SHOOT_DELAY = 500
	

	attr_reader :x, :y, :health, :bounty 

	def initialize
		@x = @y = @vel_x = @vel_y = @angle = 0.0
		@bounty = 0
		@health = 100
		@image = Gosu::Image.new('media/cowboy.png',
								:tileable => true)
		@gunfire = Gosu::Sample.new("media/gunshot.ogg")
		@last_shot = 0

	end

	def warp(x, y)
		@x, @y = x, y
	end

	def turn_left
		@angle -= TURN_INCREMENT
		
	end

	def turn_right
		@angle += TURN_INCREMENT
		
	end

	def accelerate
		@vel_x += Gosu::offset_x(@angle, ACCELERATION )
		@vel_y += Gosu::offset_y(@angle, ACCELERATION)
	end

	def move
		@x = @x + @vel_x
		@y += @vel_y

		@x %= 800
		@y %= 600

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def draw
		
		@image.draw_rot(@x, @y, 2, @angle)

	end



	def bounty
		@bounty
	end

	def health
		@health 
	end

	def dead?
		@health == 0
	end

	def shoot

		if Gosu.milliseconds - @last_shot > SHOOT_DELAY 
			@last_shot = Gosu.milliseconds
			bullet = Bullet.new(@angle,@x,@y)
			@gunfire.play
			
			bullet
			
		end				
	end

	

	
end
