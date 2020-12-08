MediaItem = reaper.GetSelectedMediaItem(0, 0) -- the first "0"  stands for "current project tab", the second one means "the first of all selected items"
Item_Start_Time = reaper.GetMediaItemInfo_Value(MediaItem, "D_POSITION");
Item_End_Time = Item_Start_Time + reaper.GetMediaItemInfo_Value(MediaItem, "D_LENGTH")
markeridx, regionidx = reaper.GetLastMarkerAndCurRegion(0, Item_Start_Time)

if markeridx == NULL then return end

retval, isrgn, pos, rgnend, markername, markrgnindexnumber = reaper.EnumProjectMarkers(markeridx)
local NewName =  markername

MediaItemTake = reaper.GetActiveTake(MediaItem)
reaper.GetSetMediaItemTakeInfo_String(MediaItemTake , "P_NAME", NewName, true) -- "True" makes the function set a new name ("False" would give you the current name in the function's return)


if(regionidx ~= -1) then
  retval, isrgn, pos, rgnend, regionname, markrgnindexnumber = reaper.EnumProjectMarkers(regionidx)
  reaper.SetProjectMarker(markrgnindexnumber, true, Item_Start_Time, Item_End_Time, NewName)
else
  reaper.AddProjectMarker(0, true, Item_Start_Time, Item_End_Time, NewName, -1)
end


