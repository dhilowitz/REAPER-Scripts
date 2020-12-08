newRate=1.00059463445332746;
 
item_count = reaper.CountSelectedMediaItems(0)

for i=0, item_count do
	item = reaper.GetSelectedMediaItem(0, i);
	if not item then
		break
	end
	take = reaper.GetActiveTake(item);
	if not take then
		break
	end
    rate = reaper.GetMediaItemTakeInfo_Value(take, "D_PLAYRATE");
    reaper.SetMediaItemTakeInfo_Value(take, "D_PLAYRATE", rate/newRate);
end

reaper.UpdateArrange();



