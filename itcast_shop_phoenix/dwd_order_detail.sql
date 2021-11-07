
create view "dwd_order_detail"(
    "rowid" varchar primary key,
    "detail"."ogId" varchar,
    "detail"."orderId" varchar,
    "detail"."goodsId" varchar,
    "detail"."goodsNum" varchar,
    "detail"."goodsPrice" varchar,
    "detail"."goodsName" varchar,
    "detail"."shopId" varchar,
    "detail"."goodsThirdCatId" varchar,
    "detail"."goodsThirdCatName" varchar,
    "detail"."goodsSecondCatId" varchar,
    "detail"."goodsSecondCatName" varchar,
    "detail"."goodsFirstCatId" varchar,
    "detail"."goodsFirstCatName" varchar,
    "detail"."areaId" varchar,
    "detail"."shopName" varchar,
    "detail"."shopCompany" varchar,
    "detail"."cityId" varchar,
    "detail"."cityName" varchar,
    "detail"."regionId" varchar,
    "detail"."regionName" varchar
);

-- 创建索引
create local index "idx_dwd_order_detail" on "dwd_order_detail"("detail"."goodsThirdCatName", "detail"."goodsSecondCatName", "detail"."goodsFirstCatName", "detail"."cityName", "detail"."regionName");

explain select * from "dwd_order_detail" where "goodsThirdCatName" = '其他蔬果' and "cityName" = '景德镇市分公司';