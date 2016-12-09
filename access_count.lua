local function close_redis(red)
    if not red then
        return
    end
    --释放连接(连接池实现)
    local pool_max_idle_time = 10000 --毫秒
    local pool_size = 100 --连接池大小
    local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)

    if not ok then
        ngx.log(ngx.ERR, "set redis keepalive error : ")
    end
end

local function wait()
   ngx.sleep(1)
end

local redis = require "resty.redis"
local red = redis:new()
red:set_timeout(1000)
local ip = "redis-ip"
local port = redis-port
local ok, err = red:connect(ip,port)
if not ok then
    return close_redis(red)
end

local uri = ngx.var.uri -- 获取当前请求的uri
local uriKey = "req:uri:"..uri
res, err = red:eval("local res, err = redis.call('incr',KEYS[1]) if res == 1 then local resexpire, err = redis.call('expire',KEYS[1],KEYS[2]) end return (res)",2,uriKey,1)
while (res > 10)
do 
   local twait, err = ngx.thread.spawn(wait)
   ok, threadres = ngx.thread.wait(twait)
   if not ok then
      ngx.log(ngx.ERR, "wait sleep error: ")
      break;
   end
   res, err = red:eval("local res, err = redis.call('incr',KEYS[1]) if res == 1 then local resexpire, err = redis.call('expire',KEYS[1],KEYS[2]) end return (res)",2,uriKey,1)
end
close_redis(red)