num_mrkrgns, num_markers, num_regions = reaper.CountProjectMarkers(0)

if num_regions == NULL or num_regions == 0 then
  return
end

region_names = {}

-- For each region
for markeridx =0, num_mrkrgns do
  retval, isrgn, pos, rgnend, regionname, rgnindexnumber = reaper.EnumProjectMarkers(markeridx)
  if isrgn then
    markeridx, regionidx = reaper.GetLastMarkerAndCurRegion(0, pos)
    -- TODO: Continue instead of return
    if markeridx >= 0 then  
      retval2, isrgn2, pos2, rgnend2, markername, markrgnindexnumber = reaper.EnumProjectMarkers(markeridx)
    -- Check to see whether the region name ends with an underscore followed by a number. if it ends with a number, then we've probably already numbered it so we ignore it
      if string.match(markername, ".+_$") then
         markername = string.match(markername, "(.+)_$")
      end
         -- do nothing

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
      reaper.SetProjectMarker(rgnindexnumber, isrgn, pos, rgnend, NewName)
      -- end
    end
  end
end


