给表设定一个字段,专门用于排序,本文是相关操作的代码

# 表结构
```sql
DROP TABLE IF EXISTS `ta`;
CREATE TABLE `ta` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `sort` int(5) unsigned NOT NULL DEFAULT '0' COMMENT '用于排序的字段, 新记录的值=max(sort)+1',
  `is_del` tinyint(3) unsigned DEFAULT '0' COMMENT '0正常1删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
```

# 读取数据

数据按照sort倒序(sort越大,越靠前)

```sql
SELECT * FROM ta ORDER BY sort DESC,id DESC
```