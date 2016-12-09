local config = ngx.shared.config;  
local host = config:get("host");  
local port = config:get("port"); 
local redis = require "resty.redis"; 
local instance=redis:new(); 
--local instance = redis.connect("192.168.102.163",6379);  
local ok,err = instance:connect(host,port);  
if not ok then  
   ngx.log(ngx.ERR,err);  
   ngx.exit(ngx.HTTP_SERVICE_UNAVAILABLE);  
end  
--local response = instance:ping();
local counter=instance:incr("zqfcounter");  
ngx.header.content_type = "text/html";
ngx.say("网站访问次数:",counter);