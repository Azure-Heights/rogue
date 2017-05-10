return {
   updateCoroutines = function (routines)
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
	 return true
      end
   end,

   dumpTable = function (table)
      for k, v in pairs(table) do
	 print(k, v)
      end
   end,

   idumpTable = function (table)
      for i, v in ipairs(table) do
	 print(i, v)
      end
   end
}
