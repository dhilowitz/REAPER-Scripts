-- MediaItem = reaper.GetSelectedMediaItem(0, 0) -- the first "0"  stands for "current project tab", the second one means "the first of all selected items"
-- Item_Start_Time = reaper.GetMediaItemInfo_Value(MediaItem, "D_POSITION");
-- Item_End_Time = Item_Start_Time + reaper.GetMediaItemInfo_Value(MediaItem, "D_LENGTH")
-- markeridx, regionidx = reaper.GetLastMarkerAndCurRegion(0, Item_Start_Time)

-- if markeridx == NULL then return end

-- retval, isrgn, pos, rgnend, markername, markrgnindexnumber = reaper.EnumProjectMarkers(markeridx)
-- local NewName =  markername .. "_down"

-- MediaItemTake = reaper.GetActiveTake(MediaItem)
-- reaper.GetSetMediaItemTakeInfo_String(MediaItemTake , "P_NAME", NewName, true) -- "True" makes the function set a new name ("False" would give you the current name in the function's return)


-- if(regionidx ~= -1) then
--   retval, isrgn, pos, rgnend, regionname, markrgnindexnumber = reaper.EnumProjectMarkers(regionidx)
--   reaper.SetProjectMarker(markrgnindexnumber, true, Item_Start_Time, Item_End_Time, NewName)
-- else
--   reaper.AddProjectMarker(0, true, Item_Start_Time, Item_End_Time, NewName, -1)
-- end


num_mrkrgns, num_markers, num_regions = reaper.CountProjectMarkers(0)

if num_regions == NULL or num_regions == 0 then
	return
end

region_names = {}

-- For each region
for markeridx =0, num_mrkrgns do
	retval, isrgn, pos, rgnend, markername, markrgnindexnumber = reaper.EnumProjectMarkers(markeridx)
	if isrgn then
		-- If the region anme ends with a number, strip it
		--markername = string.match(markername, "(.-)_%d*$")

	-- Check to see whether the region name ends with an underscore followed by a number. if it ends with a number, then we've probably already numbered it so we ignore it
		if string.match(markername, ".+_[0-9]+$") then
			 markername = string.match(markername, "(.+)_[0-9]*$")
		end
			 -- do nothing
	--      else
		-- Check in our dictionary to see whether or not we've already seen this region name before. 
		-- If we have, then we look up how many of these we've already seen in the dictionary, 
		local num_so_far = region_names[markername]
		if num_so_far and num_so_far > 0 then
			-- add 1 to that number,
			num_so_far = num_so_far + 1
			-- rename the region
		else
			num_so_far = 1
		end

		-- add the new number to the dictionary

		region_names[markername] = num_so_far
		NewName = markername .. "_" .. num_so_far
		NewName = markername .. num_so_far
		reaper.SetProjectMarker(markrgnindexnumber, isrgn, pos, rgnend, NewName)
		-- end
	end
end
