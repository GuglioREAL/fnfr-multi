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

local hauntedHouse

return {
	enter = function(self, from, songNum, songAppend)
		if player2 == "default" then
			player2 = "spooky-kids"
		end
		weeks:enter()

		song = songNum
		difficulty = songAppend

		cam.sizeX, cam.sizeY = 1.1, 1.1
		camScale.x, camScale.y = 1.1, 1.1

		sounds["thunder"] = {
			love.audio.newSource("sounds/week2/thunder1.ogg", "static"),
			love.audio.newSource("sounds/week2/thunder2.ogg", "static")
		}
		hauntedHouse = love.filesystem.load("sprites/week2/haunted-house.lua")()
		
		enemy = love.filesystem.load("sprites/characters/enemy/" .. player2 .. ".lua")()
		boyfriend = love.filesystem.load("sprites/characters/boyfriend/" .. player1 .. ".lua")()

		if player2 == "default" then
			enemy = love.filesystem.load("sprites/characters/daddy-dearest.lua")()
		end
		if player2 == "default" or player2 == "spooky-kids" then
			enemy.x, enemy.y = -480, 140
		elseif player2 == "daddy-dearest" then
			enemy.x, enemy.y = -480, 50
		elseif player2 == "parents" then
			enemy.x, enemy.y = -480, 140
		elseif player2 == "mommy-mearest" then
			enemy.x, enemy.y = -480, 50
		elseif player2 == "boyfriend" then
			enemy.x, enemy.y = -480, 240
			enemy.sizeX = -1
		elseif player2 == "pico" then
			enemy.x, enemy.y = -480, 240
			enemy.sizeX = -1
		end
		if player1 == "boyfriend" then
			boyfriend.x, boyfriend.y = 165, 240
		elseif player1 == "pico" then
			boyfriend.x, boyfriend.y = 165, 240
		elseif player1 == "mommy-mearest" then
			boyfriend.x, boyfriend.y = 165, 50
		elseif player1 == "daddy-dearest" then
			boyfriend.x, boyfriend.y = 165, 50
		elseif player1 == "parents" then
			boyfriend.x, boyfriend.y = 165, 140
		elseif player1 == "spooky-kids" then
			boyfriend.x, boyfriend.y = 165, 140
		end
		if player1 ~= "boyfriend" and player1 ~= "pico" then
			boyfriend.sizeX = -1
		end
		girlfriend.x, girlfriend.y = -200, 50



		self:load()
	end,

	load = function(self)
		weeks:load()

		if song == 3 then
			if player2 == "default" then
				enemy = love.filesystem.load("sprites/week2/monster.lua")()
			end

			inst = love.audio.newSource("music/normal/week2/monster-inst.ogg", "stream")
			voices = love.audio.newSource("music/normal/week2/monster-voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("music/normal/week2/south-inst.ogg", "stream")
			voices = love.audio.newSource("music/normal/week2/south-voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/normal/week2/spookeez-inst.ogg", "stream")
			voices = love.audio.newSource("music/normal/week2/spookeez-voices.ogg", "stream")
		end

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 3 then
			weeks:generateNotes(love.filesystem.load("charts/normal/week2/monster" .. difficulty .. ".lua")())
		elseif song == 2 then
			weeks:generateNotes(love.filesystem.load("charts/normal/week2/south" .. difficulty .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/normal/week2/spookeez" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)

		hauntedHouse:update(dt)

		if not hauntedHouse:isAnimated() then
			hauntedHouse:animate("normal", false)
		end
		if song == 1 and musicThres ~= oldMusicThres and math.fmod(absMusicTime, 60000 * (love.math.random(17) + 7) / bpm) < 100 then
			audio.playSound(sounds["thunder"][love.math.random(2)])

			hauntedHouse:animate("lightning", false)
			weeks:safeAnimate(girlfriend, "fear", true, 1)
			if player2 == "boyfriend" then
				weeks:safeAnimate(enemy, "shaking", true, 3)
			end
			if player1 == "boyfriend" then
				weeks:safeAnimate(boyfriend, "shaking", true, 3)
			end
		end

		if song ~= 3 and musicThres ~= oldMusicThres and math.fmod(absMusicTime, 60000 / bpm) < 100 then
			if enemy:getAnimName() == "idle" then
				enemy:setAnimSpeed(14.4 / (120 / bpm))
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
		love.graphics.push()
			love.graphics.translate(graphics.getWidth() / 2, graphics.getHeight() / 2)
			love.graphics.scale(cam.sizeX, cam.sizeY)

			love.graphics.push()
				love.graphics.translate(cam.x * 0.9, cam.y * 0.9)

				hauntedHouse:draw()
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
		hauntedHouse = nil

		weeks:leave()
	end
}
