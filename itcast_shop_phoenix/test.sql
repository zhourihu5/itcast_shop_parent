-- 创建表
create table if not exists "user_info"(
                                          "id" varchar primary key,
                                          "cf"."name" varchar,
                                          "cf"."age" integer,
                                          "cf"."sex" varchar,
                                          "cf"."address" varchar
);

-- 新增数据
upsert into "user_info" values('1', '张三', 30, '男', '北京市西城区');
upsert into "user_info" values('2', '李四', 20, '女', '上海市闵行区');

-- 修改数据
upsert into "user_info"("id", "age") values('1', 35);

-- 删除数据
delete from "user_info" where "id" = '2';