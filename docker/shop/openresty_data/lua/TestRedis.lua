
-- 1、引入redis的模块
local importRedis= require "resty.redis"

-- 2、实例对象：
-- local redis=importRedis:new()
local redis=importRedis:new({password="bitnami"})

-- 3、创建连接：
local ok,err=redis:connect("172.35.0.5",6379)
if not ok then
	ngx.say("redis connect err" ,err)
	ngx.say("<br>" )
	
else
	ngx.say("redis connect ok" ,ok)
	ngx.say("<br>" )
end

ok, err = redis:auth("bitnami")
if not ok then
    ngx.say("failed to auth: ", err)
    return
end
-- 4、调用命令：
local ok,err=redis:get("heima")
if not ok then
	ngx.say("get redis data err" ,err)
	ngx.say("<br>" )
else
	ngx.say("get redis data ok" ,ok)
	ngx.say("<br>" )
end

