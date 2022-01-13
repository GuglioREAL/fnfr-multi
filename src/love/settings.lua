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

local curOS = love.system.getOS()

local settingsStr = (curOS == "NX" and [[
; Friday Night Funkin' Rewritten Settings (Switch)

[Video]
; Use hardware-compressed image formats to save RAM, disabling this will make the game eat your RAM for breakfast (and increase load times)
hardwareCompression=true

[Audio]
; Master volume
; Possible values: 0.0-1.0
volume=1.0

[Game]
; Sets player 2 (enemy) keybinds to asdf
; and sets player 1 (boyfriend) to jkl;
4kBinds=false

; "Downscroll" makes arrows scroll down instead of up, and also moves some aspects of the UI around
downscroll=false

; "Kade Input" disables anti-spam, but counts "Shit" inputs as misses
; NOTE: Currently unfinished, some aspects of this input mode still need to be implemented, like mash violations
kadeInput=false

[Characters]
; Player 1 character (Possible values are, boyfriend, daddy-dearest, spooky-kids, pico, mommy-mearest, parents)
; Week6 defaults to default characters because of how it is
player1=boyfriend

; Player 2 character (Possible values are, boyfriend, daddy-dearest, spooky-kids, pico, mommy-mearest, parents and default)
; Week6 defaults to default characters because of how it is
player2=default

[Advanced]
; Show debug info on the screen
; Possible values: false, fps, detailed
showDebug=false

; These variables are read by the game for internal purposes, don't edit these unless you want to risk losing your current settings!
[Data]
settingsVer=6-nx
]]) or (curOS ~= "Web" and [[
; Friday Night Funkin' Rewritten Settings

[Video]
; Screen/window width and height (you should change this to your device's screen resolution if you are using the "exclusive" fullscreen type)
; NOTE: These settings will be ignored if using the "desktop" fullscreen type
width=1280
height=720

; Fullscreen settings, if you don't want Vsync (60 FPS cap), set "fullscreenType" to "exclusive" and "vsync" to "0"
fullscreen=false
fullscreenType=desktop
vsync=1

; Use hardware-compressed image formats to save RAM, disabling this will make the game eat your RAM for breakfast (and increase load times)
; WARNING: Don't disable this on 32-bit versions of the game, or the game will quickly run out of memory and crash (thanks to the 2 GB RAM cap)
; NOTE: If hardware compression is not supported on your device, this option will be silently ignored
hardwareCompression=true

[Audio]
; Master volume
; Possible values: 0.0-1.0
volume=1.0

[Game]
; Sets player 2 (enemy) keybinds to asdf
; and sets player 1 (boyfriend) to jkl;
4kBinds=false

; "Downscroll" makes arrows scroll down instead of up, and also moves some aspects of the UI around
downscroll=false

; "Kade Input" disables anti-spam, but counts "Shit" inputs as misses
; NOTE: Currently unfinished, some aspects of this input mode still need to be implemented, like mash violations
kadeInput=false

[Characters]
; Player 1 character (Possible values are, boyfriend, daddy-dearest, spooky-kids, pico, mommy-mearest, parents)
; Week6 defaults to default characters because of how it is
player1=boyfriend

; Player 2 character (Possible values are, boyfriend, daddy-dearest, spooky-kids, pico, mommy-mearest, parents and default)
; Week6 defaults to default characters because of how it is
player2=default

[Advanced]
; Show debug info on the screen
; Possible values: false, fps, detailed
showDebug=false

; These variables are read by the game for internal purposes, don't edit these unless you want to risk losing your current settings!
[Data]
settingsVer=6
]])

local settingsIni

local settings = {}

if curOS == "NX" then
	love.window.setMode(1920, 1080)

	-- TODO: Restore showMessageBox functionality using LÖVE Potion's implementation
	if love.filesystem.getInfo("settings.ini") then
		settingsIni = ini.load("settings.ini")

		if not settingsIni["Data"] or ini.readKey(settingsIni, "Data", "settingsVer") ~= "6-nx" then
			love.filesystem.write("settings.ini", settingsStr)
		end
	else
		love.filesystem.write("settings.ini", settingsStr)
	end

	settingsIni = ini.load("settings.ini")

	if ini.readKey(settingsIni, "Video", "hardwareCompression") == "true" then
		settings.hardwareCompression = true

		graphics.setImageType("dds")
	else
		settings.hardwareCompression = false
	end

	love.audio.setVolume(tonumber(ini.readKey(settingsIni, "Audio", "volume")))

    if ini.readKey(settingsIni, "Game", "4kBinds") == "true" then
		settings.kBinds = true
	else
		settings.kBinds = false
	end

	if ini.readKey(settingsIni, "Game", "downscroll") == "true" then
		settings.downscroll = true
	else
		settings.downscroll = false
	end
	if ini.readKey(settingsIni, "Game", "kadeInput") == "true" then
		settings.kadeInput = true
	else
		settings.kadeInput = false
	end

	if ini.readKey(settingsIni, "Characters", "player1") == "boyfriend" then -- Switches to carBF on week4
		player1 = "boyfriend"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "daddy-dearest" then
		player1 = "daddy-dearest"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "spooky-kids" then
		player1 = "spooky-kids"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "pico" then
		player1 = "pico"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "mommy-mearest" then -- carMom on week 4
		player1 = "mommy-mearest"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "parents" then -- Won't do alt animations outside of week5
		player1 = "parents"
	end
	if ini.readKey(settingsIni, "Characters", "player2") == "boyfriend" then -- Switches to carBF on week4
		player2 = "boyfriend"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "daddy-dearest" then
		player2 = "daddy-dearest"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "spooky-kids" then
		player2 = "spooky-kids"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "pico" then
		player2 = "pico"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "mommy-mearest" then -- carMom on week 4
		player2 = "mommy-mearest"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "parents" then -- Won't do alt animations outside of week5
		player2 = "parents"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "default" then -- Selects the default enemy. Defaults to daddy-dearest on mod songs
		player2 = "default"
	end


	if ini.readKey(settingsIni, "Advanced", "showDebug") == "fps" or ini.readKey(settingsIni, "Advanced", "showDebug") == "detailed" then
		settings.showDebug = ini.readKey(settingsIni, "Advanced", "showDebug")
	else
		settings.showDebug = false
	end
elseif curOS == "Web" then -- For love.js, we won't bother creating and reading a settings file that can't be edited, we'll just preset some settings
	love.window.setMode(1280, 720) -- Due to shared code, lovesize will be used even though the resolution will never change :/

	settings.hardwareCompression = false

	settings.kBinds = false
	settings.downscroll = false
	settings.kadeInput = false

	settings.showDebug = false
else
	if love.filesystem.getInfo("settings.ini") then
		settingsIni = ini.load("settings.ini")

		if not settingsIni["Data"] or ini.readKey(settingsIni, "Data", "settingsVer") ~= "6" then
			love.window.showMessageBox("Warning", "The current settings file is outdated, and will now be reset.")

			local success, message = love.filesystem.write("settings.ini", settingsStr)

			if success then
				love.window.showMessageBox("Success", "Settings file successfully created: \"" .. love.filesystem.getSaveDirectory() .. "/settings.ini\"")
			else
				love.window.showMessageBox("Error", message)
			end
		end
	else
		local success, message = love.filesystem.write("settings.ini", settingsStr)

		if success then
			love.window.showMessageBox("Success", "Settings file successfully created: \"" .. love.filesystem.getSaveDirectory() .. "/settings.ini\"")
		else
			love.window.showMessageBox("Error", message)
		end
	end

	settingsIni = ini.load("settings.ini")

	if ini.readKey(settingsIni, "Video", "fullscreen") == "true" then
		love.window.setMode(
			ini.readKey(settingsIni, "Video", "width"),
			ini.readKey(settingsIni, "Video", "height"),
			{
				fullscreen = true,
				fullscreentype = ini.readKey(settingsIni, "Video", "fullscreenType"),
				vsync = tonumber(ini.readKey(settingsIni, "Video", "vsync"))
			}
		)
	else
		love.window.setMode(
			ini.readKey(settingsIni, "Video", "width"),
			ini.readKey(settingsIni, "Video", "height"),
			{
				vsync = tonumber(ini.readKey(settingsIni, "Video", "vsync")),
				resizable = true
			}
		)
	end
	if ini.readKey(settingsIni, "Video", "hardwareCompression") == "true" then
		settings.hardwareCompression = true

		if love.graphics.getImageFormats()["DXT5"] then
			graphics.setImageType("dds")
		end
	else
		settings.hardwareCompression = false
	end

	love.audio.setVolume(tonumber(ini.readKey(settingsIni, "Audio", "volume")))

	if ini.readKey(settingsIni, "Game", "4kBinds") == "true" then
		settings.kBinds = true
	else
		settings.kBinds = false
	end

	if ini.readKey(settingsIni, "Game", "downscroll") == "true" then
		settings.downscroll = true
	else
		settings.downscroll = false
	end

	if ini.readKey(settingsIni, "Game", "kadeInput") == "true" then
		settings.kadeInput = true
	else
		settings.kadeInput = false
	end

	if ini.readKey(settingsIni, "Characters", "player1") == "boyfriend" then -- Switches to carBF on week4
		player1 = "boyfriend"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "daddy-dearest" then
		player1 = "daddy-dearest"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "spooky-kids" then
		player1 = "spooky-kids"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "pico" then
		player1 = "pico"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "mommy-mearest" then -- carMom on week 4
		player1 = "mommy-mearest"
	elseif ini.readKey(settingsIni, "Characters", "player1") == "parents" then -- Won't do alt animations outside of week5
		player1 = "parents"
	end
	if ini.readKey(settingsIni, "Characters", "player2") == "boyfriend" then -- Switches to carBF on week4
		player2 = "boyfriend"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "daddy-dearest" then
		player2 = "daddy-dearest"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "spooky-kids" then
		player2 = "spooky-kids"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "pico" then
		player2 = "pico"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "mommy-mearest" then -- carMom on week 4
		player2 = "mommy-mearest"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "parents" then -- Won't do alt animations outside of week5
		player2 = "parents"
	elseif ini.readKey(settingsIni, "Characters", "player2") == "default" then -- Selects the default enemy. Defaults to daddy-dearest on mod songs
		player2 = "default"
	end

	if ini.readKey(settingsIni, "Advanced", "showDebug") == "fps" or ini.readKey(settingsIni, "Advanced", "showDebug") == "detailed" then
		settings.showDebug = ini.readKey(settingsIni, "Advanced", "showDebug")
	else
		settings.showDebug = false
	end
end

return settings
