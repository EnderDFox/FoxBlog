给表设定一个字段,专门用于排序,本文是相关操作的代码

# 表结构

```sql
DROP TABLE IF EXISTS `ta`;
CREATE TABLE `ta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `sort` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '用于排序的字段, 新记录的值=max(sort)+1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
```
# 读取序列号

```sql
/*set @rownum=0;
select @rownum:=@rownum+1 as rownum, a.* from pm_version a order by a.vid desc limit 10;*/
```
或
```sql
select  (@i:=@i+1)  i,a.* from  pm_version a  ,(select   @i:=0)  t2 order by a.sort,a.vid desc ;
```

# 重设sort

```sql
update ta,(select  (@i:=@i+1)  i,ta.id from  ta  ,(select   @i:=0)  t2 WHERE is_del=0 order by id) b set sort = b.i where ta.id=b.id
```

# 读取数据

数据按照sort倒序(sort越大,越靠前)

```sql
SELECT * FROM ta ORDER BY sort DESC,id DESC
```

# 赠加数据

```sql
insert into ta(sort) values
(
  (SELECT IFNULL((SELECT ms FROM (SELECT max(sort)+1 AS ms FROM ta) b),1))
)
```

## update为最大+1

```sql
update ta set sort = (SELECT ms FROM (SELECT max(sort)+1 AS ms FROM ta) b)
```

# 交换排序

```sql
UPDATE ta a,ta b,
	(SELECT @a:=ta.sort va FROM ta WHERE ta.id=1) tas,
	(SELECT @b:=ta.sort vb FROM ta WHERE ta.id=2) tbs 
SET a.sort = @b,b.sort=@a where a.id=1 and b.id=2
```

# 插入数据

两种插入方式[在目标id位置后插入数据](#在目标id位置后插入数据)和[在目标id位置前插入数据](#在目标id位置前插入数据)用的sql大体相同

假设目标id是104

```sql
UPDATE pm.pm_version SET add_uid=2 WHERE vid in
(
select mvid from (SELECT max(vid) as mvid FROM pm.pm_version as v1 
WHERE v1.sort > (SELECT v2.sort FROM pm.pm_version as v2 WHERE vid = 104)) as a
)
```

## 在目标id位置后插入数据

需要 **大于目标id的数据** 设置为 `sort+1`

sql用 `>`

```sql
WHERE v1.sort > (SELECT
```

## 在目标id位置前插入数据

需要 **大于等于目标id的数据** 设置为 `sort+1`

sql用 `>=`

```sql
WHERE v1.sort >= (SELECT
``` 