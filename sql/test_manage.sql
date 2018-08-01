INSERT INTO manage.pm (pid,ver,name,add_uid,create_time,sort) VALUES (?,?,?,?,?,(
(SELECT IFNULL(
    (SELECT ms FROM(SELECT max(sort)+1 AS ms FROM pm.pm_version WHERE is_del=0 AND pid=?) m)
,1))
))