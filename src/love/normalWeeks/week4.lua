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

local sunset

local bgLimo, limoDancer, limo

local zoomTimer
local zoom = {}


return {
	enter = function(self, from, songNum, songAppend)
		if player2 == "default" then
			player2 = "mommy-mearest"
		end
		bpm = 100

		enemyFrameTimer = 0
		boyfriendFrameTimer = 0

		sounds = {
			countdown = {
				three = love.audio.newSource("sounds/countdown-3.ogg", "static"),
				two = love.audio.newSource("sounds/countdown-2.ogg", "static"),
				one = love.audio.newSource("sounds/countdown-1.ogg", "static"),
				go = love.audio.newSource("sounds/countdown-go.ogg", "static")
			},
			miss = {
				love.audio.newSource("sounds/miss1.ogg", "static"),
				love.audio.newSource("sounds/miss2.ogg", "static"),
				love.audio.newSource("sounds/miss3.ogg", "static")
			},
			death = love.audio.newSource("sounds/death.ogg", "static")
		}

		images = {
			icons = love.graphics.newImage(graphics.imagePath("icons")),
			notes = love.graphics.newImage(graphics.imagePath("notes")),
			numbers = love.graphics.newImage(graphics.imagePath("numbers"))
		}

		sprites = {
			icons = love.filesystem.load("sprites/icons.lua"),
			numbers = love.filesystem.load("sprites/numbers.lua")
		}

		song = songNum
		difficulty = songAppend

		sunset = graphics.newImage(love.graphics.newImage(graphics.imagePath("week4/sunset")))

		bgLimo = love.filesystem.load("sprites/week4/bg-limo.lua")()
		limoDancer = love.filesystem.load("sprites/week4/limo-dancer.lua")()
		girlfriend = love.filesystem.load("sprites/week4/girlfriend.lua")()
		limo = love.filesystem.load("sprites/week4/limo.lua")()
		enemy = love.filesystem.load("sprites/characters/enemy/" .. player2 .. ".lua")()
		boyfriend = love.filesystem.load("sprites/characters/boyfriend/" .. player1 .. ".lua")()
		if player2 == "default" or player2 == "mommy-mearest" then
			enemy = love.filesystem.load("sprites/week4/enemy/mommy-mearest.lua")()
		end
		if player2 == "boyfriend" then
			enemy = love.filesystem.load("sprites/week4/enemy/boyfriend.lua")()
		end

		if player1 == "boyfriend" then
			boyfriend = love.filesystem.load("sprites/week4/boyfriend.lua")()
		elseif player1 == "mommy-mearest" then
			boyfriend = love.filesystem.load("sprites/week4/boyfriend/mommy-mearest.lua")()
		end
		if player2 == "pico" then
			enemy.sizeX = -1 -- Reverse, reverse!
			enemy.x, enemy.y = -380, 110
		elseif player2 == "spooky-kids" then
			enemy.x, enemy.y = -380, -7
		elseif player2 == "daddy-dearest" then
			enemy.x, enemy.y = -380, -10
		elseif player2 == "parents" then
			enemy.x, enemy.y = -380, -30
		elseif player2 == "mommy-mearest" or player2 == "default" then
			enemy.x, enemy.y = -380, -10
		elseif player2 == "boyfriend" then
			enemy.x, enemy.y = -380, 110
			enemy.sizeX = -1
		end
		if player1 == "boyfriend" then
			boyfriend.x, boyfriend.y = 340, -100
		elseif player1 == "spooky-kids" then
			boyfriend.x, boyfriend.y = 340, -140
		elseif player1 == "pico" then
			boyfriend.x, boyfriend.y = 340, -100
		elseif player1 == "mommy-mearest" then
			boyfriend.x, boyfriend.y = 340, -265
		elseif player1 == "daddy-dearest" then
			boyfriend.x, boyfriend.y = 340, -265
		elseif player1 == "parents" then
			boyfriend.x, boyfriend.y = 340, -240
		end
		if player1 ~= "boyfriend" and player1 ~= "pico" then
			boyfriend.sizeX = -1
		end
		rating = love.filesystem.load("sprites/rating.lua")()

		bgLimo.y = 250
		limoDancer.y = -130
		girlfriend.x, girlfriend.y = 30, -50
		limo.y = 375

		rating = love.filesystem.load("sprites/rating.lua")()

		rating.sizeX, rating.sizeY = 0.75, 0.75
		numbers = {}
		for i = 1, 3 do
			numbers[i] = sprites.numbers()

			numbers[i].sizeX, numbers[i].sizeY = 0.5, 0.5
		end

		enemyIcon = sprites.icons()
		boyfriendIcon = sprites.icons()

		if settings.downscroll then
			enemyIcon.y = -400
			boyfriendIcon.y = -400
		else
			enemyIcon.y = 350
			boyfriendIcon.y = 350
		end
		enemyIcon.sizeX, enemyIcon.sizeY = 1.5, 1.5
		boyfriendIcon.sizeX, boyfriendIcon.sizeY = -1.5, 1.5

		countdownFade = {}
		countdown = love.filesystem.load("sprites/countdown.lua")()

		enemyIcon:animate("mommy mearest", false)

		self:load()
	end,

	load = function(self)
		weeks:load()

		if song == 3 then
			inst = love.audio.newSource("music/normal/week4/milf-inst.ogg", "stream")
			voices = love.audio.newSource("music/normal/week4/milf-voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("music/normal/week4/high-inst.ogg", "stream")
			voices = love.audio.newSource("music/normal/week4/high-voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/normal/week4/satin-panties-inst.ogg", "stream")
			voices = love.audio.newSource("music/normal/week4/satin-panties-voices.ogg", "stream")
		end

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()

		if song == 3 then
			weeks:generateNotes(love.filesystem.load("charts/normal/week4/milf" .. difficulty .. ".lua")())
		elseif song == 2 then
			weeks:generateNotes(love.filesystem.load("charts/normal/week4/high" .. difficulty .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/normal/week4/satin-panties" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)

		-- Hardcoded M.I.L.F camera scaling
		if song == 3 and musicTime > 56000 and musicTime < 67000 and musicThres ~= oldMusicThres and math.fmod(absMusicTime, 60000 / bpm) < 100 then
			if camScaleTimer then Timer.cancel(camScaleTimer) end

			camScaleTimer = Timer.tween((60 / bpm) / 16, cam, {sizeX = camScale.x * 1.05, sizeY = camScale.y * 1.05}, "out-quad", function() camScaleTimer = Timer.tween((60 / bpm), cam, {sizeX = camScale.x, sizeY = camScale.y}, "out-quad") end)
		end

		bgLimo:update(dt)
		limoDancer:update(dt)
		limo:update(dt)

		if musicThres ~= oldMusicThres and math.fmod(absMusicTime, 120000 / bpm) < 100 then
			limoDancer:animate("anim", false)

			limoDancer:setAnimSpeed(14.4 / (60 / bpm))
		end

		if health >= 80 then
			if enemyIcon:getAnimName() == "mommy mearest" then
				enemyIcon:animate("mommy mearest losing", false)
			end
		else
			if enemyIcon:getAnimName() == "mommy mearest losing" then
				enemyIcon:animate("mommy mearest", false)
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
				love.graphics.translate(cam.x * 0.5, cam.y * 0.5)

				sunset:draw()

				bgLimo:draw()
				for i = -475, 725, 400 do
					limoDancer.x = i

					limoDancer:draw()
				end
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				girlfriend:draw()
				limo:draw()
				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
			weeks:drawRating(1)
		love.graphics.pop()

		weeks:drawUI()
	end,

	leave = function()
		sunset = nil

		bgLimo = nil
		limoDancer = nil
		limo = nil
		weekNum = 1

		weeks:leave()
	end
}
