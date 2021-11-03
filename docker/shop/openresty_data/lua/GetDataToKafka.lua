--开启服务区的保护机制（当前活跃用户连接数小于1000时采集数据，大于1000就不采集数据）

--最大的用户数阈值
local maxUserNumber=1000
--获取当前活跃用户连接数
local  activeUserNumber=ngx.var.connections_active

--当前活跃用户连接数小于1000时采集数据
if tonumber(activeUserNumber)<tonumber(maxUserNumber)
then
--1 引入kafka 第三方的依赖包
local importkafka= require  "resty.kafka.producer"

--实例broker_list数据
local broker_list={{host="172.35.0.6",port="9092"}}
--实例topic    0   1
local topic="B2CDATA_COLLECTION3"
--topic 有两个分区
local topicPartitions=2 

--2 创建kafka的生产者
local kafkaProducer=importkafka:new(broker_list)

--计算出数据的编号
--获取共享字典
local sharedData=ngx.shared.shared_data
--获取共享字典的数据
local dataCounts=sharedData:get("count")
--第一次获取数据有可能是空
if not dataCounts then
--若无数据便设置一个1
sharedData:set("count",1)
--重新获取数据
dataCounts=sharedData:get("count")
end
--实例数据写入kafka分区的编号
local partitionNumber=tostring(dataCounts%topicPartitions)
--数据编号自增
sharedData:incr("count",1)
--在web输出
ngx.say("dataCounts  :",dataCounts)
ngx.say("<br>")
ngx.say("partitionNumber  :",partitionNumber)


--获取用于支撑反爬虫识别的数据
--获取Time_local  
local time_local = ngx.var.time_local
if time_local == nil then
time_local = ""
end
local request = ngx.var.request
if request == nil then
request = ""
end
local request_method = ngx.var.request_method
if request_method == nil then
request_method = ""
end
local content_type = ngx.var.content_type
if content_type == nil then
content_type = ""
end 
ngx.req.read_body()
local request_body = ngx.var.request_body
if request_body == nil then
request_body = ""
end
local http_referer = ngx.var.http_referer
if http_referer == nil then
http_referer = ""
end
local remote_addr = ngx.var.remote_addr
if remote_addr == nil then
remote_addr = ""
end
local http_user_agent = ngx.var.http_user_agent
if http_user_agent == nil then
http_user_agent = ""
end
local time_iso8601 = ngx.var.time_iso8601
if time_iso8601 == nil then
time_iso8601 = ""
end
local server_addr = ngx.var.server_addr
if server_addr == nil then
server_addr = ""
end
local http_cookie = ngx.var.http_cookie
if http_cookie == nil then
http_cookie = ""
end
 


--实例将要打入kafka 的数据
local  message  =  time_local  .."#CS#"..  request  .."#CS#"..  request_method  .."#CS#".. 
content_type  .."#CS#"..  request_body  .."#CS#"..  http_referer  .."#CS#"..  remote_addr  .."#CS#".. 
http_user_agent .."#CS#".. time_iso8601 .."#CS#".. server_addr .."#CS#".. http_cookie.."#CS#".. activeUserNumber;

ngx.say("<br>",message)

--3  发送数据
local ok,err=kafkaProducer:send(topic, partitionNumber, message)
if not ok then
	ngx.say("<br>" )
	ngx.say("kafkaProducer:send err " ,err)
else
	ngx.say("<br>" )
	ngx.say("kafkaProducer:send ok " )
end
end