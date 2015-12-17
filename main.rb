require 'gosu'
require 'gosu_tiled'
require_relative 'objects/player'
require_relative 'objects/bullet'

class GameWindow < Gosu::Window

	MAP_FILE = 'media/west.json'
	SPEED = 5

	def initialize 
		super 800, 600, false

		self.caption = "Outlaws' Wasteland"

		@music = Gosu::Song.new(
			self, 'media/duel.ogg')
		@music.volume = 0.5
		@music.play(true)


		@map = Gosu::Tiled.load_json(self, MAP_FILE)
		@x = @y = 0
		

		@player = Player.new
		
		@player.warp(width, height/2)

		@bullets = []

		@font = Gosu::Font.new(20)
		
	end

	def update
		@player.turn_left if Gosu::button_down? Gosu::KbA
		@player.turn_right if Gosu::button_down? Gosu::KbD
		@player.accelerate if Gosu::button_down? Gosu::KbW
		@bullets << @player.shoot if Gosu::button_down? Gosu::KbSpace

		@player.move
	end

	def draw
		@map.draw(0,0)
		@player.draw
		@bullets.each {|bullet|
			bullet.update
			bullet.draw
		}
	end

	def button_down(id)
		close if id ==Gosu::KbEscape
	end

end

window = GameWindow.new
window.show





