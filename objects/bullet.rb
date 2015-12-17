class Bullet
	MAX_DIST = 300

	attr_reader :x, :y
	
	def initialize(angle, x, y)
		@image = Gosu::Image.new("media/bullet.png", :tileable => true)
		@x = x 
		@y = y 
		@vel_y = @vel_x = 0.0		
		@angle = angle - 90
		@bullet_d = 20
		radians = @angle * Math::PI / 180

		@vel_y = @bullet_d * Math.sin(radians).to_f
		@vel_x = @bullet_d * Math.cos(radians).to_f
		 

	end

	def warp(x, y)
		@x, @y = x,y
	end

	def move
		@x += @vel_x
		@y += @vel_y
		

		@vel_x *= 0.95
		@vel_y *= 0.95
	end

	def update
		
		move
	end

	def draw
		
		@image.draw_rot(@x, @y, 3, @angle - 90)
		
	end

	
end