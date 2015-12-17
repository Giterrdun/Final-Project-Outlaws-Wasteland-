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
		@player2 = Player.new
		
		@player.warp(width/4, height/2)

		@player2.warp(width-width/4, height/2)

		@bullets = []

		@font = Gosu::Font.new(20)
		
	end

	def update
		@player.turn_left if Gosu::button_down? Gosu::KbA
		@player.turn_right if Gosu::button_down? Gosu::KbD
		@player.accelerate if Gosu::button_down? Gosu::KbW
		@bullets << @player.shoot if Gosu::button_down? Gosu::KbSpace
		@player.move
		
		

		@player2.turn_left if Gosu::button_down? Gosu::KbLeft
		@player2.turn_right if Gosu::button_down? Gosu::KbRight
		@player2.accelerate if Gosu::button_down? Gosu::KbUp
		@bullets << @player2.shoot if Gosu::button_down? Gosu::KbEnter
		@player2.move
		

	end

	def draw
		@map.draw(0,0)
		@player.draw
		@player2.draw
		@bullets.each {|bullet|
			if bullet != nil
				bullet.update
				bullet.draw
			end
		}
		@font.draw("Player1: #{@player.health}♥", 10,30,3,1.0,1.0, 0xff_000099 )
		@font.draw("Player2: #{@player2.health}♥", width-(width/7),30,3,1.0,1.0, 0xff_e60000 )
		@font.draw("Bounty: $#{@player.bounty}", 10,10,3,1.0,1.0, 0xff_000099 )
		@font.draw("Bounty: $#{@player2.bounty}", width-(width/7),10,3,1.0,1.0, 0xff_e60000)
	end

	def button_down(id)
		close if id ==Gosu::KbEscape
	end

end

window = GameWindow.new
window.show





