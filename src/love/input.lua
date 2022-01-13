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

local gameLeft
local gameDown
local gameUp
local gameRight

if love.system.getOS() == "NX" then
	if settings.kBinds then
		-- Boyfriend
		gameLeft = {"button:x", "key:j"}
		gameDown = {"button:a", "key:k"}
		gameUp = {"button:y", "key:l"}
		gameRight = {"button:b", "key:;"}
		-- Enemy
		gameLeft2 = {"button:dpleft", "key:a"}
		gameDown2 = {"button:dpdown", "key:s"}
		gameUp2 = {"button:dpup", "key:d"}
		gameRight2 = {"button:dpright", "key:f"}
	else
		-- Boyfriend
		gameLeft = {"key:j", "button:x"}
		gameDown = {"key:k", "button:a"}
		gameUp = {"key:l", "button:y"}
		gameRight = {"key:;", "button:b"}
		-- Enemy
		gameLeft2 = {"key:a", "button:dpleft"}
		gameDown2 = {"key:s", "button:dpdown"}
		gameUp2 = {"key:d", "button:dpup"}
		gameRight2 = {"key:f", "button:dpright"}
	end

	return baton.new {
		controls = {
			left = {"axis:leftx-", "button:dpleft", "key:left"},
			down = {"axis:lefty+", "button:dpdown", "key:down"},
			up = {"axis:lefty-", "button:dpup", "key:up"},
			right = {"axis:leftx+", "button:dpright", "key:right"},
			confirm = {"button:b", "key:return"},
			back = {"button:a", "key:escape"},

			gameLeft = gameLeft,
			gameDown = gameDown,
			gameUp = gameUp,
			gameRight = gameRight,

			gameLeft2 = gameLeft2,
			gameDown2 = gameDown2,
			gameUp2 = gameUp2,
			gameRight2 = gameRight2,
			gameBack = {"button:start", "key:escape"},
		},
		joystick = love.joystick.getJoysticks()[1]
	}
else
	if settings.kBinds then
		-- Boyfriend
		gameLeft = {"key:j", "button:x"}
		gameDown = {"key:k", "button:a"}
		gameUp = {"key:l", "button:y"}
		gameRight = {"key:;", "button:b"}
		-- Enemy
		gameLeft2 = {"key:a", "button:dpleft"}
		gameDown2 = {"key:s", "button:dpdown"}
		gameUp2 = {"key:d", "button:dpup"}
		gameRight2 = {"key:f", "button:dpright"}
	else
		-- Boyfriend
		gameLeft = {"key:left", "button:x"}
		gameDown = {"key:down", "button:a"}
		gameUp = {"key:up", "button:y"}
		gameRight = {"key:right", "button:b"}
		-- Enemy
		gameLeft2 = {"key:a", "button:dpleft"}
		gameDown2 = {"key:s", "button:dpdown"}
		gameUp2 = {"key:w", "button:dpup"}
		gameRight2 = {"key:d", "button:dpright"}
	end
	

	return baton.new {
		controls = {
			left = {"key:left", "axis:leftx-", "button:dpleft"},
			down = {"key:down", "axis:lefty+", "button:dpdown"},
			up = {"key:up", "axis:lefty-", "button:dpup"},
			right = {"key:right", "axis:leftx+", "button:dpright"},
			confirm = {"key:return", "button:a"},
			back = {"key:escape", "button:b"},

			gameLeft = gameLeft,
			gameDown = gameDown,
			gameUp = gameUp,
			gameRight = gameRight,

			gameLeft2 = gameLeft2,
			gameDown2 = gameDown2,
			gameUp2 = gameUp2,
			gameRight2 = gameRight2,
			gameBack = {"key:escape", "button:start"},
		},
		joystick = love.joystick.getJoysticks()[1]
	}
end
