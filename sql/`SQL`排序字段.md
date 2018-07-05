给表设定一个字段,专门用于排序,本文是相关操作的代码

# 1. 示例表

```sql
DROP TABLE IF EXISTS `ta`;
CREATE TABLE `ta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `sort` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '用于排序的字段, 新记录的值=max(sort)+1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
```

# 2. 显示行号

读取表中数据, 显示行号

```sql
/*set @rownum=0;
select @rownum:=@rownum+1 as rownum, a.* from pm_version a order by a.vid desc limit 10;*/
```
或
```sql
SELECT (@i:=@i+1)  i,a.* FROM  pm_version a  ,(SELECT   @i:=0)  t2 ORDER BY a.sort,a.vid DESC ;
```

# 3. 重设sort

为一个表的sort字段,设置新值

```sql
UPDATE ta,(SELECT  (@i:=@i+1)  i,ta.id FROM  ta  ,(SELECT   @i:=0)  t2 WHERE is_del=0 ORDER BY id) b SET sort = b.i WHERE ta.id=b.id
```

# 4. 读取数据

数据按照sort倒序(sort越大,越靠前)

```sql
SELECT * FROM ta ORDER BY sort DESC,id DESC
```

# 5. 增加数据

## 新增数据时, 需要`sort=最大sort+1`

```sql
INSERT INTO ta(sort) VALUES
(
  (SELECT IFNULL((SELECT ms FROM (SELECT max(sort)+1 AS ms FROM ta) b),1))
)
```

## 新增数据时, 需要`sort=目标sort+1` 目标sort后的

## 5.1. update为最大+1

将一条数据的sort更新为`最大sort+1`

```sql
UPDATE ta SET sort = (SELECT ms FROM (SELECT max(sort)+1 AS ms FROM ta) b)
```

# 6. 改变排序

## 6.1. 交换两条数据的sort

最简单的交换 仅交换a,b两个数据的sort, 其它sort不受影响

```sql
UPDATE pm_version AS ta,pm_version AS tb,
	(SELECT @a:=sort FROM pm_version WHERE vid=124) AS tt1,
	(SELECT @b:=sort FROM pm_version WHERE vid=125) AS tt2
SET ta.sort = @b,tb.sort=@a WHERE ta.vid=124 AND tb.vid=125
```

## 6.2. 移动到更小的sort

将一条已有数据a移动到另一个数据b,  b的sort比a小, b~a(包括b) 之间的数据sort+1

```sql
UPDATE pm.pm_version AS ta, pm_version AS tb,
 (SELECT @a := sort FROM pm.pm_version WHERE vid = 130) AS tt1,
 (SELECT @b := sort FROM pm.pm_version WHERE vid = 122) AS tt2
SET ta.sort = @b, tb.sort = tb.sort + 1
WHERE
	ta.vid = 130
AND tb.vid <> 130
AND tb.sort >= @b
AND tb.sort < @a 
```

## 6.2. 移动到更大的sort

将一条已有数据a移动到另一个数据b,  b的sort比a大, a~b(包括b) 之间的数据sort-1

```sql
UPDATE pm.pm_version AS ta, pm_version AS tb,
 (SELECT @va:=122 FROM pm.pm_version) AS ttva,
 (SELECT @vb:=131 FROM pm.pm_version) AS ttvb,
 (SELECT @a := ta0.sort,@b := tb0.sort FROM pm.pm_version as ta0,pm.pm_version as tb0 WHERE ta0.vid = @va AND tb0.vid=@vb) AS tt1
SET ta.sort = @b, tb.sort = tb.sort - 1
WHERE
	ta.vid = @va
AND tb.vid <> @va
AND tb.sort > @a
AND tb.sort <= @b
```