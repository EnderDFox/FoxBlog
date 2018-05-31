# Err 1093

> [Err] 1093 - You can't specify target table 'ta' for update in FROM clause

如下sql会报错

```sql
UPDATE ta SET ta.sort = ta.sort+1 WHERE ta.sort = (SELECT t1.sort FROM ta as t1 WHERE t1.id>1)
```

结局方法

```sql
UPDATE ta SET ta.sort = ta.sort+1 WHERE ta.sort = (SELECT b.sort FROM (SELECT t1.sort FROM ta as t1 WHERE t1.id>1) b)
```

