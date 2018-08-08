-- # Proj升级为新sql系统的sql

-- ## manager

-- ### 新增的表

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for mag_auth
-- ----------------------------
-- ----------------------------
-- Table structure for mag_auth
-- ----------------------------
DROP TABLE IF EXISTS `mag_auth`;
CREATE TABLE `mag_auth` (
  `authid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `name` varchar(60) DEFAULT '',
  `description` varchar(60) DEFAULT '',
  `sort` int(10) unsigned DEFAULT '0',
  `is_del` tinyint(3) unsigned DEFAULT '0' COMMENT '0正常1删除',
  PRIMARY KEY (`authid`)
) ENGINE=MyISAM AUTO_INCREMENT=2013 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mag_auth
-- ----------------------------
INSERT INTO `mag_auth` VALUES ('70', '全部项目 管理', '', '0', '0');
INSERT INTO `mag_auth` VALUES ('101', '所属项目 后台管理', '该成员所属项目的\"后台\"管理', '1', '0');
INSERT INTO `mag_auth` VALUES ('110', '所属部门 后台管理', '该成员所属部门及其子部门的\"后台\"管理', '2', '0');
INSERT INTO `mag_auth` VALUES ('201', '所属项目 工作管理', '该成员所属项目的\"工作\"管理', '3', '0');
INSERT INTO `mag_auth` VALUES ('210', '所属部门 工作管理', '该成员所属部门及其子部门的\"工作\"管理', '4', '0');
INSERT INTO `mag_auth` VALUES ('230', '所属项目 晨会管理', '可以在晨会页面编辑状态', '5', '0');

-- ----------------------------
-- Table structure for mag_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `mag_auth_group`;
CREATE TABLE `mag_auth_group` (
  `agid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '职位id',
  `pid` int(10) unsigned NOT NULL,
  `name` varchar(60) DEFAULT '',
  `description` varchar(60) DEFAULT '',
  `sort` int(10) unsigned DEFAULT '0',
  `is_del` tinyint(3) unsigned DEFAULT '0' COMMENT '0正常1删除',
  PRIMARY KEY (`agid`)
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mag_auth_group_auth
-- ----------------------------
DROP TABLE IF EXISTS `mag_auth_group_auth`;
CREATE TABLE `mag_auth_group_auth` (
  `agid` int(10) unsigned NOT NULL COMMENT '职位id',
  `authid` int(10) unsigned NOT NULL COMMENT '职位id',
  UNIQUE KEY `index` (`agid`,`authid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mag_user_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `mag_user_auth_group`;
CREATE TABLE `mag_user_auth_group` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `pid` int(10) unsigned NOT NULL COMMENT '职位id',
  `agid` int(10) unsigned NOT NULL COMMENT '职位id',
  UNIQUE KEY `index` (`uid`,`pid`,`agid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for mag_user_dept
-- ----------------------------
DROP TABLE IF EXISTS `mag_user_dept`;
CREATE TABLE `mag_user_dept` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `pid` int(10) unsigned NOT NULL COMMENT '职位id',
  `did` int(10) unsigned NOT NULL COMMENT '职位id',
  `sort` int(10) unsigned DEFAULT '0',
  `create_time` int(10) unsigned DEFAULT '1524554392',
  UNIQUE KEY `index` (`uid`,`pid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- ### 修改的表

ALTER TABLE `mag_department`
ADD COLUMN `pid`  int(10) UNSIGNED NOT NULL AFTER `sort`,
ADD COLUMN `config`  int(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `pid`,
ADD COLUMN `color`  int(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `config`,
ADD COLUMN `is_del`  tinyint(3) UNSIGNED NOT NULL DEFAULT 0 AFTER `color`;


-- ### 修改数据

-- #### user表gid
-- > 在go中修改
-- UPDATE mag_user SET gid=0 WHERE 1=1;
-- UPDATE mag_user SET gid=3 WHERE `name`='村长' OR `name`='狐狸猫';

-- #### dept表修改

UPDATE mag_department SET pid=1;
UPDATE mag_department SET config=2 WHERE name='质检';
UPDATE mag_department SET config=4 WHERE name='策划';
DELETE FROM mag_department WHERE name='美术管理';

-- #### user的did信息导入 user_dept

UPDATE mag_user SET did=2 WHERE did=7;


