/*
SQLyog 企业版 - MySQL GUI v7.14 
MySQL - 5.6.16-log : Database - i_wenyiba_com
*********************************************************************
*/

/*所有的表数据插入*/

/*Data for the table `u_permission` */

insert  into `u_permission`(`id`,`url`,`name`) values (4,'/permission/index.shtml','权限列表'),(6,'/permission/addPermission.shtml','权限添加'),(7,'/permission/deletePermissionById.shtml','权限删除'),(8,'/member/list.shtml','用户列表'),(9,'/member/online.shtml','在线用户'),(10,'/member/changeSessionStatus.shtml','用户Session踢出'),(11,'/member/forbidUserById.shtml','用户激活&禁止'),(12,'/member/deleteUserById.shtml','用户删除'),(13,'/permission/addPermission2Role.shtml','权限分配'),(14,'/role/clearRoleByUserIds.shtml','用户角色分配清空'),(15,'/role/addRole2User.shtml','角色分配保存'),(16,'/role/deleteRoleById.shtml','角色列表删除'),(17,'/role/addRole.shtml','角色列表添加'),(18,'/role/index.shtml','角色列表'),(19,'/permission/allocation.shtml','权限分配'),(20,'/role/allocation.shtml','角色分配');

/*Data for the table `u_role` */

insert  into `u_role`
(id, `name`, code)
 values 
 (1,'系统管理员','888888'), (3,'权限角色','100003'), (4,'用户中心','100002'),
 (5, '物管经理', '100004'),  (6, '物管经理助理', '100004')
;

/*Data for the table `u_role_permission` */

insert  into `u_role_permission`(`rid`,`pid`) values (4,8),(4,9),(4,10),(4,11),(4,12),(3,4),(3,6),(3,7),(3,13),(3,14),(3,15),(3,16),(3,17),(3,18),(3,19),(3,20),(1,4),(1,6),(1,7),(1,8),(1,9),(1,10),(1,11),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20);

/*Data for the table `u_user` */

insert  into `u_user`(`id`,`nickname`,`mobile`,`email`,`pswd`,`create_time`,`last_login_time`,`status`) values 
(1,'管理员','admin','admin','57dd03ed397eabaeaa395eb740b770fd','2016-06-16 11:15:33','2016-06-16 11:24:10',1),
(11,'1111','1111','8446@qq.com','d57ffbe486910dd5b26d0167d034f9ad','2016-05-26 20:50:54','2016-06-16 11:24:35',1),
(12,'2222','2222','2222','4afdc875a67a55528c224ce088be2ab8','2016-05-27 22:34:19','2016-06-15 17:03:16',1);

/*Data for the table `u_user_role` */

insert  into `u_user_role`(`uid`,`rid`) values (12,4),(11,3),(11,4),(1,1);


insert  into `house_business_type`
(`id`,`name`,dimission_avaliable) 
values 
(1,'办公',1),(2,'车库/储藏',1),(3,'商业',1),(4,'住宅',1),
(5,'未分配',0);


insert  into `house_business_sub_type`
(`id`,`name`,parent_id) 
values 
(1,'非人防车库',2),(2,'地上车库位',2),(3,'人防车库',2),(13,'储藏室',2),
(4,'配套商业',3),(5,'整体商业',3),(14,'商业街',3),
(7,'普通住宅',4),(15,'花园洋房',4),(6,'联排别墅',4),
(8,'甲级办公',1),(9,'普通办公',1),(10,'loft',1),(11,'酒店式公寓',1),(16,'准甲办公',1),
(12,'未分配',5);













