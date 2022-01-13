--[[----------------------------------------------------------------------------
This file is part of Friday Night Funkin' Rewritten

Copyright (C) 2021  HTV04

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
------------------------------------------------------------------------------]]

local song, difficulty

local sky, city, cityWindows, behindTrain, street
local winColors, winColor

return {
	enter = function(self, from, songNum, songAppend)
		if player2 == "default" then
			player2 = "pico"
		end
		weeks:enter()

		song = songNum
		difficulty = songAppend

		cam.sizeX, cam.sizeY = 1, 1
		camScale.x, camScale.y = 1, 1

		winColors = {
			{49, 162, 253}, -- Blue
			{49, 253, 140}, -- Green
			{251, 51, 245}, -- Magenta
			{253, 69, 49}, -- Orange
			{251, 166, 51}, -- Yellow
		}
		winColor = 1

		sky = graphics.newImage(love.graphics.newImage(graphics.imagePath("week3/sky")))
		city = graphics.newImage(love.graphics.newImage(graphics.imagePath("week3/city")))
		cityWindows = graphics.newImage(love.graphics.newImage(graphics.imagePath("week3/city-windows")))
		behindTrain = graphics.newImage(love.graphics.newImage(graphics.imagePath("week3/behind-train")))
		street = graphics.newImage(love.graphics.newImage(graphics.imagePath("week3/street")))

		behindTrain.y = -100
		behindTrain.sizeX, behindTrain.sizeY = 1.25, 1.25
		street.y = -100
		street.sizeX, street.sizeY = 1.25, 1.25
		enemy = love.filesystem.load("sprites/characters/enemy/" .. player2 .. ".lua")()
		boyfriend = love.filesystem.load("sprites/characters/boyfriend/" .. player1 .. ".lua")()


		girlfriend.x, girlfriend.y = -70, -140
		if player2 == "default" or player2 == "pico" then
			enemy.sizeX = -1 -- Reverse, reverse!
			enemy.x, enemy.y = -480, 50	
		elseif player2 == "spooky-kids" then
			enemy.x, enemy.y = -480, -7
		elseif player2 == "daddy-dearest" then
			enemy.x, enemy.y = -480, -110
		elseif player2 == "parents" then
			enemy.x, enemy.y = -480, -140
		elseif player2 == "mommy-mearest" then
			enemy.x, enemy.y = -480, -110
		elseif player2 == "boyfriend" then
			enemy.x, enemy.y = -480, 50
			enemy.sizeX = -1
		end
		if player1 == "boyfriend" then
			boyfriend.x, boyfriend.y = 165, 50
		elseif player1 == "spooky-kids" then
			boyfriend.x, boyfriend.y = 165, -40
		elseif player1 == "pico" then
			boyfriend.x, boyfriend.y = 165, 50
		elseif player1 == "mommy-mearest" then
			boyfriend.x, boyfriend.y = 165, -110
		elseif player1 == "daddy-dearest" then
			boyfriend.x, boyfriend.y = 165, -110
		elseif player1 == "parents" then
			boyfriend.x, boyfriend.y = 165, -140
		end
		if player1 ~= "boyfriend" and player1 ~= "pico" then
			boyfriend.sizeX = -1
		end


		self:load()
	end,

	load = function(self)
		weeks:load()

		if song == 3 then
			inst = love.audio.newSource("music/normal/week3/blammed-inst.ogg", "stream")
			voices = love.audio.newSource("music/normal/week3/blammed-voices.ogg", "stream")
			enemyIcon:animate(player2, false)
			boyfriendIcon:animate(player1, false)
		elseif song == 2 then
			inst = love.audio.newSource("music/normal/week3/philly-nice-inst.ogg", "stream")
			voices = love.audio.newSource("music/normal/week3/philly-nice-voices.ogg", "stream")
			enemyIcon:animate(player2, false)
			boyfriendIcon:animate(player1, false)
		else
			inst = love.audio.newSource("music/normal/week3/pico-inst.ogg", "stream")
			voices = love.audio.newSource("music/normal/week3/pico-voices.ogg", "stream")
			enemyIcon:animate(player2, false)
			boyfriendIcon:animate(player1, false)
		end

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 3 then
			weeks:generateNotes(love.filesystem.load("charts/normal/week3/blammed" .. difficulty .. ".lua")())
		elseif song == 2 then
			weeks:generateNotes(love.filesystem.load("charts/normal/week3/philly-nice" .. difficulty .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/normal/week3/pico" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)

		if musicThres ~= oldMusicThres and math.fmod(absMusicTime, 240000 / bpm) < 100 then
			winColor = winColor + 1

			if winColor > 5 then
				winColor = 1
			end
		end

		if health >= 80 then
			if enemyIcon:getAnimName() == player2 then
				enemyIcon:animate(player2 .. " losing", false)
			end
		else
			if enemyIcon:getAnimName() == player2 .. " losing" then
				enemyIcon:animate(player2, false)
			end
		end

		if not (countingDown or graphics.isFading()) and not (inst:isPlaying() and voices:isPlaying()) then
			if storyMode and song < 3 then
				song = song + 1

				self:load()
			else
				status.setLoading(true)

				graphics.fadeOut(
					0.5,
					function()
						Gamestate.switch(menu)

						status.setLoading(false)
					end
				)
			end
		end

		weeks:updateUI(dt)
	end,

	draw = function(self)
		local curWinColor = winColors[winColor]

		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			love.graphics.push()
				love.graphics.translate(cam.x * 0.25, cam.y * 0.25)

				sky:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 0.5, cam.y * 0.5)

				city:draw()
				graphics.setColor(curWinColor[1] / 255, curWinColor[2] / 255, curWinColor[3] / 255)
				cityWindows:draw()
				graphics.setColor(1, 1, 1)
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

				behindTrain:draw()
				street:draw()

				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()

		weeks:drawUI()
	end,

	leave = function(self)
		sky = nil
		city = nil
		cityWindows = nil
		behindTrain = nil
		street = nil

		weeks:leave()
	end
}
