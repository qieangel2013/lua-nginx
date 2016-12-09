local function close_redis(redis)
    if not redis then
        return
    end
    local pool_max_idle_time = 10000 --毫秒
    local pool_size = 100 --连接池大小
    local ok, err = redis:set_keepalive(pool_max_idle_time, pool_size)

    if not ok then
        ngx_log(ngx_ERR, "set redis keepalive error : ", err)
    end
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

local clientIP = ngx.req.get_headers()["X-Real-IP"]
if clientIP == nil then
   clientIP = ngx.req.get_headers()["x_forwarded_for"]
end
if clientIP == nil then
   clientIP = ngx.var.remote_addr
end

local incrKey = "user:"..clientIP..":freq"
local blockKey = "user:"..clientIP..":block"

local is_block,err = red:get(blockKey) -- check if ip is blocked
if tonumber(is_block) == 1 then
   ngx.exit(ngx.HTTP_FORBIDDEN)
   return close_redis(red)
end

res, err = red:incr(incrKey)

if res == 1 then
   res, err = red:expire(incrKey,1)
end

if res > 200 then
    res, err = red:set(blockKey,1)
    res, err = red:expire(blockKey,600)
end

close_redis(red)