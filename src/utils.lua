local utils = { }

local dirs = {
   up = { x = 0, y = -1, name = "up", opposite = "down" },
   down = { x = 0, y = 1, name = "down", opposite = "up" },
   left = { x = -1, y = 0, name = "left", opposite = "right" },
   right = { x = 1, y = 0, name = "right", opposite = "left" }
}
utils.dirs = dirs

local axes = {
   x = { positive = "right", negative = "left" },
   y = { positive = "down", negative = "up" }
}
utils.axes = axes

function utils.returnDir(dir)
   return dirs[dir].x, dirs[dir].y
end

function utils.updateCoroutines(routines)
   local dead = { }
   local before = #routines

   for i, routine in ipairs(routines) do
      if routine() then
	 table.insert(dead, i)
      end
   end

   for i, key in ipairs(dead) do
      table.remove(routines, key - i + 1)
   end
   
   if before > 0 and #routines == 0 then
      return true, 0
   else
      return false, #routines
   end
end

function utils.doOverTable(t, func)
   for k, v in pairs(t) do
      func(k, v)
   end
end

function utils.idoOverTable(t, func)
   for k, v in ipairs(t) do
      func(k, v)
   end
end

function utils.dumpTable(t)
   utils.doOverTable(t, function (k, v) print(k, v) end)
end

function utils.idumpTable(t)
   utils.idoOverTable(t, function (k, v) print(k, v) end)
end

return utils
