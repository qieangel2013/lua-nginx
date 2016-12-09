local cjson = require "cjson";
local config = ngx.shared.config;  
local file = io.open("/usr/local/nginx/lua/config.json","r");  
local content = cjson.decode(file:read("*all"));  
file:close();  
for name,value in pairs(content) do  
   config:set(name,value);  
end