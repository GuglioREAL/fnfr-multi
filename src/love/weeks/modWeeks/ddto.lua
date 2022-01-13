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

local stageBack, stageFront, curtains

return {
	enter = function(self, from, songNum, songAppend)
		if player2 == "default" then
			player2 = "daddy-dearest"
		end
		weeks:enter()

		song = songNum
		difficulty = songAppend

		stageBack = graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/stage-back")))
		stageFront = graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/stage-front")))
		curtains = graphics.newImage(love.graphics.newImage(graphics.imagePath("week1/curtains")))
		stageFront.y = 400
		curtains.y = -100
		girlfriend.x, girlfriend.y = 30, -90
		enemy = love.filesystem.load("sprites/characters/enemy/" .. player2 .. ".lua")()
		boyfriend = love.filesystem.load("sprites/characters/boyfriend/" .. player1 .. ".lua")()

		if player2 == "default" then
			enemy = love.filesystem.load("sprites/week1/daddy-dearest.lua")()
		end
		if player2 == "pico" then
			enemy.sizeX = -1 -- Reverse, reverse!
			enemy.x, enemy.y = -480, 50	
		elseif player2 == "spooky-kids" then
			enemy.x, enemy.y = -480, -7
		elseif player2 == "daddy-dearest" then
			enemy.x, enemy.y = -480, -110
		elseif player2 == "parents" then
			enemy.x, enemy.y = -480, -90
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
			boyfriend.x, boyfriend.y = 165, -90
		end
		if player1 ~= "boyfriend" and player1 ~= "pico" then
			boyfriend.sizeX = -1
		end

		self:load()
	end,

	load = function(self)
		weeks:load()
		if song == 18 then
			inst = love.audio.newSource("music/mods/ddto/extra/epiphany/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/extra/epiphany/Voices.ogg", "stream")
		elseif song == 17 then
			inst = love.audio.newSource("music/mods/ddto/extra/dual demise/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/extra/dual demise/Voices.ogg", "stream")
		elseif song == 16 then
			inst = love.audio.newSource("music/mods/ddto/extra/poems n thorns/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/extra/poems n thorns/Voices.ogg", "stream")
		elseif song == 15 then
			inst = love.audio.newSource("music/mods/ddto/extra/your reality/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/extra/your reality/Voices.ogg", "stream")
		elseif song == 14 then
			inst = love.audio.newSource("music/mods/ddto/extra/glitcher/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/extra/glitcher/Voices.ogg", "stream")
		elseif song == 13 then
			inst = love.audio.newSource("music/mods/ddto/extra/it's complicated/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/extra/it's complicated/Voices.ogg", "stream")
		elseif song == 12 then
			inst = love.audio.newSource("music/mods/ddto/extra/crucify/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/extra/crucify/Voices.ogg", "stream")
		elseif song == 11 then
			inst = love.audio.newSource("music/mods/ddto/extra/beethoven/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/extra/beethoven/Voices.ogg", "stream")
		elseif song == 10 then
			inst = love.audio.newSource("music/mods/ddto/monika/reconciliation/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/monika/reconciliation/Voices.ogg", "stream")
		elseif song == 9 then
			inst = love.audio.newSource("music/mods/ddto/yuri/obsession/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/yuri/obsession/Voices.ogg", "stream")
		elseif song == 8 then
			inst = love.audio.newSource("music/mods/ddto/yuri/deep breaths/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/yuri/deep breaths/Voices.ogg", "stream")
		elseif song == 7 then
			inst = love.audio.newSource("music/mods/ddto/natsuki/baka/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/natsuki/baka/Voices.ogg", "stream")
		elseif song == 6 then
			inst = love.audio.newSource("music/mods/ddto/natsuki/my sweets/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/natsuki/my sweets/Voices.ogg", "stream")
		elseif song == 5 then
			inst = love.audio.newSource("music/mods/ddto/sayori/my confession/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/sayori/my confession/Voices.ogg", "stream")
		elseif song == 4 then
			inst = love.audio.newSource("music/mods/ddto/sayori/rain clouds/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/sayori/rain clouds/Voices.ogg", "stream")
		elseif song == 3 then
			inst = love.audio.newSource("music/mods/ddto/monika/your demise/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/monika/your demise/Voices.ogg", "stream")
		elseif song == 2 then
			inst = love.audio.newSource("music/mods/ddto/monika/bara no yume/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/monika/bara no yume/Voices.ogg", "stream")
		else
			inst = love.audio.newSource("music/mods/ddto/monika/high school conflict/Inst.ogg", "stream")
			voices = love.audio.newSource("music/mods/ddto/monika/high school conflict/Voices.ogg", "stream")
		end

		self:initUI()

		weeks:setupCountdown()
	end,

	initUI = function(self)
		weeks:initUI()
		if song == 18 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/extra/epiphany.lua")())
		elseif song == 17 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/extra/dual demise" .. difficulty .. ".lua")())
		elseif song == 16 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/extra/poems n thorns" .. difficulty .. ".lua")())
		elseif song == 15 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/extra/your reality" .. difficulty .. ".lua")())
		elseif song == 14 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/extra/glitcher" .. difficulty .. ".lua")())
		elseif song == 13 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/extra/it's complicated" .. difficulty .. ".lua")())
		elseif song == 12 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/extra/crucify" .. difficulty .. ".lua")())
		elseif song == 11 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/extra/beathoven" .. difficulty .. ".lua")())
		elseif song == 10 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/monika/reconciliation" .. difficulty .. ".lua")())
		elseif song == 9 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/yuri/obsession" .. difficulty .. ".lua")())
		elseif song == 8 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/yuri/deep breaths" .. difficulty .. ".lua")())
		elseif song == 7 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/natsuki/baka" .. difficulty .. ".lua")())
		elseif song == 6 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/natsuki/my sweets" .. difficulty .. ".lua")())
		elseif song == 5 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/sayori/my confession" .. difficulty .. ".lua")())
		elseif song == 4 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/sayori/rain clouds" .. difficulty .. ".lua")())
		elseif song == 3 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/monika/your demise" .. difficulty .. ".lua")())
		elseif song == 2 then
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/monika/bara no yume" .. difficulty .. ".lua")())
		else
			weeks:generateNotes(love.filesystem.load("charts/mods/ddto/monika/high school conflict" .. difficulty .. ".lua")())
		end
	end,

	update = function(self, dt)
		weeks:update(dt)

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

				stageBack:draw()
				stageFront:draw()

				girlfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x, cam.y)

				enemy:draw()
				boyfriend:draw()
			love.graphics.pop()
			love.graphics.push()
				love.graphics.translate(cam.x * 1.1, cam.y * 1.1)

				curtains:draw()
			love.graphics.pop()
			weeks:drawRating(0.9)
		love.graphics.pop()

		weeks:drawUI()
	end,

	leave = function(self)
		stageBack = nil
		stageFront = nil
		curtains = nil

		weeks:leave()
	end
}
