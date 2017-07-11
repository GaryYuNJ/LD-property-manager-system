
DROP TABLE IF EXISTS `u_user_role`;
DROP TABLE IF EXISTS `u_role_permission`;

/*表结构插入 权限表*/
DROP TABLE IF EXISTS `u_permission`;

CREATE TABLE `u_permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(256) NOT NULL unique COMMENT 'url地址',
  `name` varchar(64) NOT NULL COMMENT 'url描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;


/*Table structure for table `u_role` 角色表*/
DROP TABLE IF EXISTS `u_role`;

CREATE TABLE `u_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL unique COMMENT '角色名称',
  `code` varchar(10) NOT NULL  unique  COMMENT '角色类型 code 唯一码',
  `appointments_id` bigint(3) DEFAULT NULL COMMENT '角色对应的职务id', 
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父id', 
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

  
/*Table structure for table `u_role_permission` */
DROP TABLE IF EXISTS `u_role_permission`;

CREATE TABLE `u_role_permission` (
  `rid` bigint(20) NOT NULL COMMENT '角色ID',
  `pid` bigint(20) NOT NULL COMMENT '权限ID',
  FOREIGN KEY (rid) REFERENCES u_role(id) ON DELETE CASCADE,
  FOREIGN KEY (pid) REFERENCES u_permission(id) ON DELETE CASCADE,
  UNIQUE KEY rolePermission (rid,pid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `u_user` */

DROP TABLE IF EXISTS `u_user`;

CREATE TABLE `u_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(20) NOT NULL COMMENT '用户姓名',
  `mobile` varchar(15) NOT NULL UNIQUE COMMENT '手机号|登录帐号',
  `email` varchar(128) DEFAULT NULL COMMENT '邮箱',
  `pswd` varchar(32) NOT NULL COMMENT '密码',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `status` bigint(1) DEFAULT '1' COMMENT '1:有效，0:禁止登录',
  `dimission_status` bigint(1) DEFAULT '0' COMMENT '是否已离职; 1:已离职，0:未离职',
  `dimission_time` datetime DEFAULT NULL COMMENT '离职时间',
  `dimission_process_flag` bigint(1) DEFAULT '0' COMMENT '离职后佣金数据已处理标记; 1:已处理，0:未处理',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

/*Table structure for table `u_user_role` */

DROP TABLE IF EXISTS `u_user_role`;

CREATE TABLE `u_user_role` (
  `uid` bigint(20) NOT NULL COMMENT '用户ID',
  `rid` bigint(20) NOT NULL COMMENT '角色ID',
  FOREIGN KEY (rid) REFERENCES u_role(id) ON DELETE CASCADE,
  FOREIGN KEY (uid) REFERENCES u_user(id) ON DELETE CASCADE,
  UNIQUE KEY user_role (rid,uid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*Table structure for table `city_company` 城市公司*/

DROP TABLE IF EXISTS `member_community_rel`;
DROP TABLE IF EXISTS `member_callfix_form`;
DROP TABLE IF EXISTS `public_information`;
DROP TABLE IF EXISTS `lost_info_form`;
DROP TABLE IF EXISTS `house`;
DROP TABLE IF EXISTS `building`;
DROP TABLE IF EXISTS `community`;
DROP TABLE IF EXISTS `city`;


CREATE TABLE `city` (
  `id` bigint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '城市名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;


/*Table structure for table `property_company` 物业公司*/
DROP TABLE IF EXISTS `property_company`;

CREATE TABLE `property_company` (
  `id` bigint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '物业公司名称',
  `code` varchar(20) default NULL COMMENT '物业公司编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8
COMMENT '物业公司数据表';
/*Table structure for table `user_property_company` 系统用户与物业公司关系*/




/*Table structure for table `community` 小区 */

DROP TABLE IF EXISTS `building`;
DROP TABLE IF EXISTS `member_community_rel`;
DROP TABLE IF EXISTS `member_callfix_form`;
DROP TABLE IF EXISTS `public_information`;
DROP TABLE IF EXISTS `lost_info_form`;
DROP TABLE IF EXISTS `community`;

CREATE TABLE `community` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '小区名称',
  `city_id` bigint(5) DEFAULT NULL COMMENT '城市Id',
  `property_company_id` bigint(5) DEFAULT NULL COMMENT '物业公司Id',
  `code` varchar(25) NOT NULL COMMENT '唯一标志',
  `bigint1` bigint(20) NOT NULL COMMENT '扩展字段',
  `bigint2` bigint(20) NOT NULL COMMENT '扩展字段',
  `varchar1` varchar(25) NOT NULL COMMENT '扩展字段',
  `varchar2` varchar(25) NOT NULL COMMENT '扩展字段',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (city_id) REFERENCES city(id),
  FOREIGN KEY (property_company_id) REFERENCES property_company(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8
COMMENT '小区数据表';



/*Table structure for table `building` 楼栋数据表*/
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '楼栋名称',
  `community_id` bigint(20) NOT NULL COMMENT 'communityid外键',
  `code` varchar(20) default NULL COMMENT '编码',
  PRIMARY KEY (`id`),
  FOREIGN KEY (community_id) REFERENCES community(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8
COMMENT '楼栋数据表';




/*Table structure for table  `house_business_type` 业态大类*/
DROP TABLE IF EXISTS `house_business_sub_type`;
DROP TABLE IF EXISTS `house_business_type`;

CREATE TABLE `house_business_type` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '房源业态，商业类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table 业态细类 `house_business_sub_type` */
DROP TABLE IF EXISTS `house_business_sub_type`;

CREATE TABLE `house_business_sub_type` (
  `id` bigint(2) NOT NULL ,
  `name` varchar(20) NOT NULL COMMENT '房源业态，商业类型 名字',
  `parent_id` bigint(2) NOT NULL ,
  PRIMARY KEY (`id`),
  FOREIGN KEY (parent_id) REFERENCES house_business_type(id) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;



/*Table structure for table 房源主数据表`house` */
DROP TABLE IF EXISTS `house`;

CREATE TABLE `house` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `building_id` bigint(20) NOT NULL COMMENT '楼栋id外键',
  `business_type_id` bigint(2) NOT NULL COMMENT '业态大类id',
  `business_sub_type_id` bigint(2) NOT NULL COMMENT '业态细类id',
  `code` bigint(20) NOT NULL COMMENT '房号编码',
  `name` varchar(25) NOT NULL COMMENT '名称',
  `size` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '平方米', 
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  `bigint1` bigint(20) NOT NULL COMMENT '扩展字段',
  `bigint2` bigint(20) NOT NULL COMMENT '扩展字段',
  `varchar1` varchar(25) NOT NULL COMMENT '扩展字段',
  `varchar2` varchar(25) NOT NULL COMMENT '扩展字段',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`),
  FOREIGN KEY (building_id) REFERENCES building(id),
  FOREIGN KEY (business_type_id) REFERENCES house_business_type(id),
  FOREIGN KEY (business_sub_type_id) REFERENCES house_business_sub_type(id)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 
COMMENT '房产信息';


/*Table structure for table 车位 `parking_space` */
DROP TABLE IF EXISTS `member_parking_space_rel`;
DROP TABLE IF EXISTS `parking_space`;

CREATE TABLE `parking_space` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` bigint(20) NOT NULL COMMENT '车位编号',
  `name` varchar(25) NOT NULL COMMENT '名称',
  `size` DECIMAL(12,5) NOT NULL  DEFAULT 0 COMMENT '平方米', 
  `remark` varchar(250) DEFAULT NULL  COMMENT '备注',
  `bigint1` bigint(20) NOT NULL COMMENT '扩展字段',
  `bigint2` bigint(20) NOT NULL COMMENT '扩展字段',
  `varchar1` varchar(25) NOT NULL COMMENT '扩展字段',
  `varchar2` varchar(25) NOT NULL COMMENT '扩展字段',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 
COMMENT '停车位信息';


/*Table structure for table `CUSTOMER` 业主信息表 , 来自CRM*/
DROP TABLE IF EXISTS `CUSTOMER`;

CREATE TABLE CUSTOMER ( 
    ID           	bigint(20) AUTO_INCREMENT COMMENT '会员ID。 '  NOT NULL,
    CM_MEMID     	varchar(20) COMMENT 'CRM的成员ID，对应CRM主键CMMEMID。考虑到业务要求要先对未注册人进行授权，此时CID并不存在，所以去除NOT NULL unique 限制'  NULL,
    CM_CUSTID    	varchar(20) COMMENT '会员ID'  NULL,
    CM_ISOWNER   	char(1) NULL,
    CM_RELATION  	char(1) COMMENT '与主成员关系(0主成员；1-7其它)'  NULL,
    CM_GRADE     	char(1) COMMENT '级别'  NULL,
    CM_FLAG1     	char(1) COMMENT '积分回馈权限'  NULL,
    CM_FLAG2     	char(1) NULL,
    CM_FLAG3     	char(1) NULL,
    CM_LMYKJF    	decimal(10,0) COMMENT '联名卡预扣积分'  NULL,
    CM_JFXFXE    	decimal(10,0) COMMENT '单次积分消费限额'  NULL,
    CM_LCZHYE    	decimal(10,0) COMMENT '零钞帐户余额'  NULL,
    CM_N1        	decimal(10,0) NULL,
    CM_N2        	decimal(10,0) NULL,
    CM_N3        	decimal(10,0) NULL,
    CM_N4        	decimal(10,0) NULL,
    CM_N5        	decimal(10,0) NULL,
    CM_N6        	decimal(10,0) NULL,
    CM_N7        	decimal(10,0) NULL,
    CM_N8        	decimal(10,0) NULL,
    CM_N9        	decimal(10,0) NULL,
    CM_JFA       	decimal(10,0) COMMENT '消费积分'  NULL,
    CM_JFB       	decimal(10,0) COMMENT '倍享积分'  NULL,
    CM_JFC       	decimal(10,0) COMMENT '温馨积分'  NULL,
    CM_JFD       	decimal(10,0) COMMENT '赠予积分'  NULL,
    CM_JFE       	decimal(10,0) COMMENT '身份积分'  NULL,
    CM_JFF       	decimal(10,0) COMMENT '购买积分'  NULL,
    CM_DECJF     	decimal(10,0) COMMENT '扣减积分'  NULL,
    CM_TOTJF     	decimal(10,0) COMMENT '总积分(A+B+C+D+E+F+回馈)'  NULL,
    CM_XFJE      	decimal(10,0) COMMENT '消费金额'  NULL,
    CM_MAINTOR   	varchar(15) COMMENT '维护人'  NULL,
    CM_MAINTDATE 	datetime COMMENT '维护如期'  NULL,
    CM_NAME      	varchar(100) COMMENT '姓名'  NULL,
    CM_BIRTHDAY  	date COMMENT '生日'  NULL,
    CM_BIRTHTYPE 	char(1) COMMENT '生日类型(1-公历;2-农历)'  NULL,
    CM_SEX       	char(1) COMMENT '性别'  NULL,
    CM_ADDR      	varchar(200) COMMENT '详细地址'  NULL,
    CM_ADD1      	varchar(100) COMMENT '地址（省）'  NULL,
    CM_ADD2      	varchar(100) COMMENT '地址（市）'  NULL,
    CM_ADD3      	varchar(100) COMMENT '地址（区）'  NULL,
    CM_ADD4      	varchar(100) COMMENT '地址（街道）'  NULL,
    CM_ZIP       	char(6) COMMENT '邮编'  NULL,
    CM_IDTYPE    	char(1) COMMENT '证件类型'  NULL,
    CM_IDNO      	varchar(20) COMMENT '证件号码'  NULL,
    CM_LXTYPE1   	char(1) COMMENT '短信联系'  NULL,
    CM_LXTYPE2   	char(1) COMMENT '信件联系'  NULL,
    CM_LXTYPE3   	char(1) COMMENT '电邮联系'  NULL,
    CM_LXTYPE4   	char(1) COMMENT '电话联系'  NULL,
    CM_LXTYPE5   	char(1) NULL,
    CM_TEL       	varchar(30) COMMENT '电话号码'  NULL,
    CM_MOBILE1   	varchar(30) COMMENT '手机号码1'  NULL,
    CM_MOBILE2   	varchar(30) COMMENT '手机号码2'  NULL,
    CM_FAX       	varchar(30) COMMENT '传真'  NULL,
    CM_EMAIL     	varchar(100) COMMENT '电子邮箱'  NULL,
    CM_ISEMPLOYEE	char(1) COMMENT '是否内部员工'  NULL,
    CM_LUNAR     	varchar(8) COMMENT '农历'  NULL,
    CM_LUNARCHN  	varchar(100) COMMENT '农历中文'  NULL,
    CM_SX        	varchar(10) COMMENT '属相'  NULL,
    CM_COMPANY   	varchar(100) COMMENT '工作单位'  NULL,
    CM_DKJF      	decimal(10,0) COMMENT '抵扣积分,历史积分定期处理时增加'  NULL DEFAULT '0',
    CM_DHISJF    	decimal(10,0) COMMENT '用来记录积分定期处理中的减的积分，历史积分定期处理中清0'  NULL DEFAULT '0',
    CM_CHR1      	varchar(100) NULL,
    CM_CHR2      	varchar(100) NULL,
    CM_CHR3      	varchar(100) NULL,
    CM_CHR4      	varchar(100) NULL,
    CM_CHR5      	varchar(100) NULL,
    CM_CHR6      	varchar(100) NULL,
    CM_CHR7      	varchar(100) NULL,
    CM_CHR8      	varchar(100) NULL,
    CM_CHR9      	varchar(100) NULL,
    CM_CHR10     	varchar(100) NULL,
    CM_CHR11     	varchar(100) NULL,
    CM_CHR12     	varchar(100) NULL,
    CM_CHR13     	varchar(100) NULL,
    CM_CHR14     	varchar(100) NULL,
    CM_CHR15     	varchar(100) NULL,
    CM_CHR16     	varchar(100) NULL,
    CM_CHR17     	varchar(100) NULL,
    CM_CHR18     	varchar(100) NULL,
    CM_CHR19     	varchar(100) NULL,
    CM_CHR20     	varchar(100) NULL,
    CM_CHR21     	varchar(100) NULL,
    CM_CHR22     	varchar(100) NULL,
    CM_CHR23     	varchar(100) NULL,
    CM_CHR24     	varchar(100) NULL,
    CM_CHR25     	varchar(100) NULL,
    CM_CHR26     	varchar(100) NULL,
    CM_CHR27     	varchar(100) NULL,
    CM_CHR28     	varchar(100) NULL,
    CM_CHR29     	varchar(100) NULL,
    CM_CHR30     	varchar(100) NULL,
    CM_CHR31     	varchar(100) NULL,
    CM_CHR32     	varchar(100) NULL,
    CM_CHR33     	varchar(100) NULL,
    CM_CHR34     	varchar(100) NULL,
    CM_CHR35     	varchar(100) NULL,
    CM_CHR36     	varchar(100) NULL,
    CM_CHR37     	varchar(100) NULL,
    CM_CHR38     	varchar(100) NULL,
    CM_CHR39     	varchar(100) NULL,
    CM_CHR40     	varchar(100) NULL,
    CM_CHR41     	varchar(100) NULL,
    CM_CHR42     	varchar(100) NULL,
    CM_CHR43     	varchar(100) NULL,
    CM_CHR44     	varchar(100) NULL,
    CM_CHR45     	varchar(100) NULL,
    CM_CHR46     	varchar(100) NULL,
    CM_CHR47     	varchar(100) NULL,
    CM_CHR48     	varchar(100) NULL,
    CM_CHR49     	varchar(100) COMMENT ' 当前会员等级ABCDEZ'  NULL,
    CM_CHR50     	varchar(100) COMMENT 'ABCDEZ会员价值'  NULL,
    CM_NUM1      	decimal(10,0) NULL,
    CM_NUM2      	decimal(10,0) NULL,
    CM_NUM3      	decimal(10,0) NULL,
    CM_NUM4      	decimal(10,0) NULL,
    CM_NUM5      	decimal(10,0) NULL,
    CM_NUM6      	decimal(10,0) NULL,
    CM_NUM7      	decimal(10,0) NULL,
    CM_NUM8      	decimal(10,0) NULL,
    CM_NUM9      	decimal(10,0) NULL,
    CM_NUM10     	decimal(10,0) NULL,
    CM_NUM11     	decimal(10,0) NULL,
    CM_NUM12     	decimal(10,0) NULL,
    CM_NUM13     	decimal(10,0) NULL,
    CM_NUM14     	decimal(10,0) NULL,
    CM_NUM15     	decimal(10,0) NULL,
    CM_NUM16     	decimal(10,0) NULL,
    CM_NUM17     	decimal(10,0) NULL,
    CM_NUM18     	decimal(10,0) COMMENT 'R'  NULL,
    CM_NUM19     	decimal(10,0) COMMENT 'F'  NULL,
    CM_NUM20     	decimal(10,0) COMMENT 'M'  NULL,
    CM_MKT       	varchar(20) COMMENT '所属门店'  NULL,
    CM_KHDATE    	datetime COMMENT '开户日期'  NULL,
    CM_XFDATE    	datetime COMMENT '最后消费日期'  NULL,
    CM_SJDATE    	datetime COMMENT '最后升级日期'  NULL,
    CM_JJDATE    	datetime COMMENT '最后降级日期'  NULL,
    CM_ASTRO     	varchar(20) COMMENT '星座'  NULL,
    CM_FSTDATE   	datetime COMMENT '开卡后第一次消费日期'  NULL,
    CM_TOKEN     	varchar(30) COMMENT 'APP登录令牌'  NULL,
    CM_TOKEN2    	varchar(30) COMMENT '快递箱令牌'  NULL,
    CM_TOKENDATE 	datetime COMMENT 'APP最后登录日期'  NULL,
    CM_PWD       	varchar(100) COMMENT '密码'  NULL,
    CM_SSQY      	varchar(20) COMMENT '所属企业'  NULL,
    CM_QYJS      	varchar(20) COMMENT '企业角色'  NULL,
    CM_JTJS      	varchar(20) COMMENT '家庭角色'  NULL,
    CM_PTNAME    	varchar(100) COMMENT '图片名称'  NULL,
    CM_CZZ       	decimal(10,0) COMMENT '成长值'  NULL,
    CM_REFEREE   	varchar(20) COMMENT '推荐人id'  NULL,
    PRIMARY KEY(ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*Table structure for table `member_community_rel` 业主与小区关系*/
DROP TABLE IF EXISTS `member_community_rel`;

CREATE TABLE `member_community_rel` (
  `member_id` bigint(20) NOT NULL COMMENT '用户id',
  `house_id` bigint(20) NOT NULL COMMENT '房源Id',
  `status` bigint(1) DEFAULT '1' COMMENT '1:有效，0:无效',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  FOREIGN KEY (member_id) REFERENCES CUSTOMER(id) ON DELETE CASCADE,
  FOREIGN KEY (house_id) REFERENCES house(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


/*Table structure for table `member_community_rel` 业主与停车位的关系*/
DROP TABLE IF EXISTS `member_parking_space_rel`;

CREATE TABLE `member_parking_space_rel` (
  `member_id` bigint(20) NOT NULL COMMENT '用户id',
  `parking_space_id` bigint(20) NOT NULL COMMENT '停车位Id',
  `status` bigint(1) DEFAULT '1' COMMENT '1:有效，0:无效',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` bigint(20) DEFAULT NULL COMMENT '更新人',
  FOREIGN KEY (member_id) REFERENCES CUSTOMER(id) ON DELETE CASCADE,
  FOREIGN KEY (parking_space_id) REFERENCES parking_space(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*Table structure for table `member_callfix_form` 业主报修表单*/
DROP TABLE IF EXISTS `member_callfix_form`;

CREATE TABLE `member_callfix_form` (
  `member_id` bigint(20) NOT NULL COMMENT '用户id',
  `community_id` bigint(20) NOT NULL COMMENT '小区外键',
  `organization`   varchar(50) DEFAULT NULL COMMENT '报修单位',
  `object`   varchar(50) DEFAULT NULL COMMENT '报修物品',
  `mobile`   varchar(50) DEFAULT NULL COMMENT '联系电话',
  `desc`   varchar(50) DEFAULT NULL COMMENT '报修内容',
  
  `status` bigint(1) DEFAULT '0' COMMENT '0:提交，1:已处理',
  `process_user` bigint(20) DEFAULT NULL COMMENT '处理人',
  `remark`   varchar(100) DEFAULT NULL COMMENT '处理意见',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  FOREIGN KEY (member_id) REFERENCES CUSTOMER(id) ON DELETE CASCADE,
  FOREIGN KEY (community_id) REFERENCES community(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*Table structure for table `public_information` 公告信息表单*/
DROP TABLE IF EXISTS `public_information`;

CREATE TABLE `public_information` (
    `member_id` bigint(20) NOT NULL COMMENT '用户id',
  `community_id` bigint(20) NOT NULL COMMENT '小区外键',
  `organization`   varchar(50) DEFAULT NULL COMMENT '公告发布单位',
  `title`   varchar(50) DEFAULT NULL COMMENT '主题',
  `content`   varchar(500) DEFAULT NULL COMMENT '内容',
  
  `status` bigint(1) DEFAULT '0' COMMENT '0:提交，1:已处理',
  `process_user` bigint(20) DEFAULT NULL COMMENT '处理人',
  
  `remark`   varchar(100) DEFAULT NULL COMMENT '处理意见',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  FOREIGN KEY (member_id) REFERENCES CUSTOMER(id) ON DELETE CASCADE,
  FOREIGN KEY (community_id) REFERENCES community(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



/*Table structure for table `lost_info_form` 失物详情单*/
DROP TABLE IF EXISTS `lost_info_form`;

CREATE TABLE `lost_info_form` (
  `community_id` bigint(20) NOT NULL COMMENT '小区外键',
  `object_name`   varchar(50) DEFAULT NULL COMMENT '物品名称',
  `mobile`   varchar(50) DEFAULT NULL COMMENT '联系电话',
  `pickup_location`   varchar(50) DEFAULT NULL COMMENT '拾获地点',
  `pickup_user`   varchar(50) DEFAULT NULL COMMENT '拾获人',
  `desc`   varchar(50) DEFAULT NULL COMMENT '描述',
  `time` datetime DEFAULT NULL COMMENT '拾获时间',
  `claim_location`   varchar(50) DEFAULT NULL COMMENT '拾获地点',
  
  `status` bigint(1) DEFAULT '0' COMMENT '0:提交，1:已处理',
  `process_user` bigint(20) DEFAULT NULL COMMENT '处理人',
  `remark`   varchar(100) DEFAULT NULL COMMENT '处理意见',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  FOREIGN KEY (community_id) REFERENCES community(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

