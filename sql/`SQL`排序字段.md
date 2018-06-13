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

# 6. 交换排序

## 6.1. 交换相邻

最简单的交换 a,b相邻,仅交换二者的sort

```sql
UPDATE ta a,ta b,
	(SELECT @a:=ta.sort va FROM ta WHERE ta.id=1) tas,
	(SELECT @b:=ta.sort vb FROM ta WHERE ta.id=2) tbs 
SET a.sort = @b,b.sort=@a WHERE a.id=1 AND b.id=2
```

## 6.2 交换到其它位置

为了将`数据a`**置顶**或**置底**, 需要将`a`的sort插入到目标位置, 并且相关的数据sort都要+1或-1

**TODO** 被交换的row的sort还没有改呢

# 7. 交换到目标位置

两种方式,用的sql大体相同, 仅 修改`WHERE v1.sort > (SELECT`部分的代码

假设目标id是104

```sql
UPDATE ta SET sort=sort+1 WHERE id IN (
	SELECT id FROM
	(
		SELECT id FROM ta AS v1 
		WHERE v1.sort > 
			(SELECT sort FROM ta WHERE id = 5)
	) as v2
)
```

## 7.1. 交换数据到目标id位置后

需要 **大于目标id的数据** 设置为 `sort+1`

sql用 `>`

```sql
WHERE v1.sort > (SELECT
```

## 7.2. 交换数据到目标id位置前

需要 **大于等于目标id的数据** 设置为 `sort+1`

sql用 `>=`

```sql
WHERE v1.sort >= (SELECT
``` 