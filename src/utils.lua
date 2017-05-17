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

local function returnDir(dir)
   return dirs[dir].x, dirs[dir].y
end
utils.returnDir = returnDir

local function updateCoroutines(routines)
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
utils.updateCoroutines = updateCoroutines

local function doOverTable(t, func)
   for k, v in pairs(t) do
      func(k, v)
   end
end
utils.doOverTable = doOverTable

local function idoOverTable(t, func)
   for k, v in ipairs(t) do
      func(k, v)
   end
end
utils.idoOverTable = idoOverTable

local function dumpTable(t)
   utils.doOverTable(t, function (k, v) print(k, v) end)
end
utils.dumpTable = dumpTable

local function idumpTable(t)
   utils.idoOverTable(t, function (k, v) print(k, v) end)
end
utils.idumpTable = idumpTable

return utils
