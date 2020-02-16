json = require "json"
dofile(arg[1])
jdata = json.encode(stats)
print(jdata)

