json = require "json"
dofile(arg[1])
local function isempty(s)
  return s == nil or s == ''
end

if not isempty(stats) then
 jdata = json.encode(stats)
else
 jdata = json.encode(misStats)
end

print(jdata)

