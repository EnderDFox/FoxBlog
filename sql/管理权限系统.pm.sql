-- ## pm

-- ### proj表

ALTER TABLE `pm_project`
DROP COLUMN `mode_sort`,
ADD COLUMN `create_time`  int(10) UNSIGNED NULL DEFAULT NULL AFTER `name`;


UPDATE pm_project SET create_time=1512614298;

### 流程 负责人改多人

ALTER TABLE `pm_link`
MODIFY COLUMN `uid`  varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '负责人' AFTER `name`;

-- ### 新增 晨会状态表

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pm_collate
-- ----------------------------
DROP TABLE IF EXISTS `pm_collate`;
CREATE TABLE `pm_collate` (
  `wid` int(10) unsigned DEFAULT '0' COMMENT 'work id',
  `uid` int(10) unsigned DEFAULT '0' COMMENT '添加人',
  `status` tinyint(3) unsigned DEFAULT '0' COMMENT '0未检查1完成2持续3未完成',
  `add_uid` int(10) unsigned DEFAULT '0' COMMENT '检查人',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '检查时间',
  UNIQUE KEY `wid,uid` (`wid`,`uid`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

