/*
 Navicat Premium Data Transfer

 Source Server         : sun
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : localhost:3306
 Source Schema         : hotel

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 06/05/2024 15:40:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for check_in
-- ----------------------------
DROP TABLE IF EXISTS `check_in`;
CREATE TABLE `check_in`  (
  `check_in_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '入住id',
  `order_id` int(11) NOT NULL COMMENT '订单号',
  `room_id` int(11) NOT NULL COMMENT '房间ID',
  `room_number` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房间号',
  `peo_count` int(11) NOT NULL DEFAULT 1 COMMENT '入住人数',
  `persons` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '入住人',
  `ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '身份证号',
  `check_in_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入住时间',
  `check_out_time` timestamp(0) NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '离店时间',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`check_in_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '入住退房登记表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of check_in
-- ----------------------------
INSERT INTO `check_in` VALUES (1, 5, 5, '111', 1, '李元芳', '112468098654334567', '2018-12-08 17:14:05', '2018-12-18 14:05:38', '2018-12-08 17:13:33', '2018-12-18 14:05:38');
INSERT INTO `check_in` VALUES (2, 7, 7, '112', 2, '王昭君,上官婉儿', '775432134479076664,8876543233568677789', '2018-12-11 19:10:34', '2018-12-18 14:05:53', '2018-12-12 16:07:16', '2018-12-18 14:05:53');
INSERT INTO `check_in` VALUES (3, 11, 9, '123', 2, '黄石,吕晓明', '441982300129390022,441823900918230021', '2018-12-18 18:24:54', '2018-12-18 18:26:30', '2018-12-18 18:24:54', '2018-12-18 18:26:30');
INSERT INTO `check_in` VALUES (4, 13, 8, '113', 1, 'baozhikuan', '11346', '2018-12-20 11:46:28', '0000-00-00 00:00:00', '2018-12-20 11:46:28', '2018-12-20 11:46:28');
INSERT INTO `check_in` VALUES (5, 14, 12, '100', 2, '分析,社稷', '143958344085440092,1438573958392432423', '2018-12-22 13:41:06', '2018-12-22 13:41:26', '2018-12-22 13:41:06', '2018-12-22 13:41:26');
INSERT INTO `check_in` VALUES (6, 16, 12, '100', 2, '软须,测试', '1243243254895823,23483925832728914', '2018-12-22 14:13:03', '2018-12-22 14:13:20', '2018-12-22 14:13:03', '2018-12-22 14:13:20');
INSERT INTO `check_in` VALUES (7, 17, 12, '100', 1, 'ss', '1111111', '2018-12-25 13:48:44', '2018-12-25 13:48:55', '2018-12-25 13:48:44', '2018-12-25 13:48:55');

-- ----------------------------
-- Table structure for hotel_info
-- ----------------------------
DROP TABLE IF EXISTS `hotel_info`;
CREATE TABLE `hotel_info`  (
  `hotel_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '酒店id',
  `hotel_name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '酒店名',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `telephone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电话号码',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电子邮箱',
  `address` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '地址',
  `website` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网站',
  `create_time` timestamp(0) NOT NULL COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`hotel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '酒店信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hotel_info
-- ----------------------------
INSERT INTO `hotel_info` VALUES (1, '伦兰唯尚大酒店', '18768866666', '0763-4831555', '1032796097@qq.com', '浙江省杭州市', 'http://hotel.ruenlan.com', '2018-11-23 10:14:44', '2019-11-23 19:39:34');

-- ----------------------------
-- Table structure for order_info
-- ----------------------------
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info`  (
  `order_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单号',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户姓名',
  `cid` varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户身份证号',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '客户手机号',
  `room_id` int(11) NOT NULL COMMENT '房间ID',
  `room_number` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房间号码',
  `type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房间类型',
  `price` double(10, 0) NULL DEFAULT 0 COMMENT '房间价格',
  `rc_num` int(2) NULL DEFAULT NULL COMMENT '入住人数',
  `in_date` timestamp(0) NULL DEFAULT NULL COMMENT '开房时间',
  `out_date` timestamp(0) NULL DEFAULT NULL COMMENT '退房时间',
  `order_status` int(11) NOT NULL DEFAULT 0 COMMENT '订单状态（1：存续，2：结单）',
  `order_cost` double NULL DEFAULT NULL COMMENT '消费金额',
  `create_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '订单信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_info
-- ----------------------------
INSERT INTO `order_info` VALUES (25, '孙子', '343121199303141214', '13276672031', 19, '4501', '1 张特大床, 城市景观, 客房', 338, 2, '2024-04-30 00:00:00', '2024-05-14 00:00:00', 6, 4732, '2024-05-01 16:56:56', '2024-05-01 21:08:23');
INSERT INTO `order_info` VALUES (26, '孙子', '343121199303141214', '13276672033', 20, '4502', '1 张特大床, 城市景观, 客房', 338, 3, '2024-05-09 00:00:00', '2024-05-24 00:00:00', 5, 5070, '2024-05-01 17:02:09', '2024-05-01 21:08:23');
INSERT INTO `order_info` VALUES (27, '孙子', '343121199303141214', '13276672222', 21, '4503', '1 张特大床, 城市景观, 客房', 338, 3, '2024-05-01 00:00:00', '2024-05-01 20:29:21', 6, 338, '2024-05-01 18:48:20', '2024-05-01 21:08:23');
INSERT INTO `order_info` VALUES (28, '孙子', '343121199303141214', '13276673000', 204, '5505', '1 张特大床, 湖景, 行政酒廊礼遇, 总统套房', 988, 1, '2024-05-13 00:00:00', '2024-05-22 00:00:00', 4, 8892, '2024-05-01 19:21:59', '2024-05-01 21:08:23');
INSERT INTO `order_info` VALUES (29, '孙上', '343121199602041111', '13277775656', 21, '4503', '1 张特大床, 城市景观, 客房', 338, 4, '2024-04-30 00:00:00', '2024-05-01 20:31:48', 6, 338, '2024-05-01 20:30:09', '2024-05-01 21:08:23');
INSERT INTO `order_info` VALUES (30, '方伟', '430123187712124565', '12821784558', 26, '4508', '1 张特大床, 城市景观, 客房', 338, 2, '2024-05-01 00:00:00', NULL, 2, 0, '2024-05-01 20:32:38', '2024-05-01 21:08:23');
INSERT INTO `order_info` VALUES (31, '吴风', '420117198801233550', '18645687852', 47, '4607', '1 张特大床, 城市景观, 客房', 338, 1, '2024-05-01 00:00:00', NULL, 2, 0, '2024-05-01 20:33:47', '2024-05-01 21:08:23');
INSERT INTO `order_info` VALUES (32, '许家新', '355123196612134568', '13345689784', 19, '4501', '1 张特大床, 城市景观, 客房', 338, 3, '2024-05-01 00:00:00', '2024-05-01 20:36:17', 6, 338, '2024-05-01 20:36:12', '2024-05-01 21:08:23');
INSERT INTO `order_info` VALUES (33, '方大应', '340121199812253654', '15845689874', 19, '4501', '1 张特大床, 城市景观, 客房', 338, 1, '2024-05-02 00:00:00', '2024-05-05 00:00:00', 3, 1014, '2024-05-01 21:03:20', '2024-05-01 21:08:23');
INSERT INTO `order_info` VALUES (34, '赵四', '34012198812054568', '15416587895', 94, '5102', '2 张单人床, 湖景, 客房', 458, 2, '2024-05-02 00:00:00', '2024-05-05 00:00:00', 3, 1374, '2024-05-01 21:09:48', '2024-05-01 21:09:48');
INSERT INTO `order_info` VALUES (36, '十三点', '34012198812054568', '13356784568', 22, '4504', '1 张特大床, 城市景观, 客房', 338, 13, '2024-05-03 00:00:00', '2024-05-06 00:00:00', 6, 1014, '2024-05-02 18:29:13', '2024-05-02 18:30:23');
INSERT INTO `order_info` VALUES (37, '十四人', '34013198812054568', '13345687985', 63, '4801', '2 张单人床, 城市景观, 客房', 358, 4, '2024-05-03 00:00:00', '2024-05-05 00:00:00', 3, 716, '2024-05-02 18:31:50', '2024-05-02 18:31:50');
INSERT INTO `order_info` VALUES (38, '七人团', '34013198912054568', '13276672031', 45, '4605', '1 张特大床, 城市景观, 客房', 338, 2, '2024-05-03 00:00:00', '2024-05-05 00:00:00', 3, 676, '2024-05-02 19:25:57', '2024-05-02 19:25:57');
INSERT INTO `order_info` VALUES (39, '孙零', '343131199303141214', '13276672031', 25, '4507', '1 张特大床, 城市景观, 客房', 338, 1, '2024-05-05 00:00:00', '2024-05-08 00:00:00', 3, 1014, '2024-05-04 13:32:30', '2024-05-04 13:32:30');
INSERT INTO `order_info` VALUES (40, '孙零', '343131199303141214', '13276672013', 115, '5303', '1 张特大床, 城市景观, 行政酒廊礼遇, 客房', 788, 1, '2024-05-07 00:00:00', '2024-05-10 00:00:00', 4, 2364, '2024-05-04 13:33:12', '2024-05-04 13:33:12');

-- ----------------------------
-- Table structure for order_type
-- ----------------------------
DROP TABLE IF EXISTS `order_type`;
CREATE TABLE `order_type`  (
  `type_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'typeId',
  `type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '方式',
  `remark` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '预订方式表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_type
-- ----------------------------
INSERT INTO `order_type` VALUES (1, '电话预订', '通过电话联系前台完成预定', '2018-11-15 16:19:21', '2019-11-28 20:26:05');
INSERT INTO `order_type` VALUES (2, '官网预订', '在酒店官网注册用户，自主下单完成预订', '2018-11-06 16:20:09', '2018-11-14 16:20:12');
INSERT INTO `order_type` VALUES (4, '领导安排', '通过领导为重要来宾安排客房', '2018-11-15 18:19:16', '2018-11-25 20:54:03');
INSERT INTO `order_type` VALUES (5, '前台预订', '直接在酒店前台进行客房预订入住', '2018-11-26 19:49:33', '2018-11-26 19:49:33');
INSERT INTO `order_type` VALUES (7, 'APP预订', '通过APP来预订客房', '2018-12-22 14:15:11', '2018-12-22 14:15:11');

-- ----------------------------
-- Table structure for room_info
-- ----------------------------
DROP TABLE IF EXISTS `room_info`;
CREATE TABLE `room_info`  (
  `room_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '房间id',
  `room_number` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房间号码',
  `type_id` int(11) NOT NULL COMMENT '房间类型ID',
  `room_status` int(11) NOT NULL DEFAULT 1 COMMENT '房间状态:1-可预订，0-已被预订，-1：已入住，-2：不可用',
  `floor` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所在楼层',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '客户手机号',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`room_id`) USING BTREE,
  UNIQUE INDEX `uqe_room_number`(`room_number`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 217 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '房间信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_info
-- ----------------------------
INSERT INTO `room_info` VALUES (19, '4501', 2, 2, '45', '15845689874', '2024-04-29 14:57:08', '2024-05-01 21:03:20');
INSERT INTO `room_info` VALUES (20, '4502', 2, 1, '45', '13276672033', '2024-04-29 19:26:10', '2024-05-01 21:16:23');
INSERT INTO `room_info` VALUES (21, '4503', 2, 1, '45', '13277775656', '2024-04-29 19:26:17', '2024-05-01 20:31:48');
INSERT INTO `room_info` VALUES (22, '4504', 2, 1, '45', '', '2024-04-29 19:26:27', '2024-05-02 18:31:15');
INSERT INTO `room_info` VALUES (23, '4505', 2, 1, '45', NULL, '2024-04-29 19:26:34', '2024-04-29 19:26:34');
INSERT INTO `room_info` VALUES (24, '4506', 2, 1, '45', NULL, '2024-04-29 19:26:42', '2024-04-29 19:26:42');
INSERT INTO `room_info` VALUES (25, '4507', 2, 2, '45', '13276672031', '2024-04-29 19:26:49', '2024-05-04 13:32:30');
INSERT INTO `room_info` VALUES (26, '4508', 2, 3, '45', '12821784558', '2024-04-29 19:26:56', '2024-05-01 20:32:38');
INSERT INTO `room_info` VALUES (27, '4509', 2, 1, '45', NULL, '2024-04-29 19:27:25', '2024-04-29 19:27:25');
INSERT INTO `room_info` VALUES (28, '4510', 2, 1, '45', '13276673000', '2024-04-29 19:27:33', '2024-05-01 22:14:34');
INSERT INTO `room_info` VALUES (41, '4601', 2, 1, '46', NULL, '2024-04-29 19:39:23', '2024-04-29 19:39:23');
INSERT INTO `room_info` VALUES (42, '4602', 2, 1, '46', NULL, '2024-04-29 19:39:29', '2024-04-29 19:39:29');
INSERT INTO `room_info` VALUES (43, '4603', 2, 1, '46', NULL, '2024-04-29 19:39:36', '2024-04-29 19:39:36');
INSERT INTO `room_info` VALUES (44, '4604', 2, 1, '46', NULL, '2024-04-29 19:39:43', '2024-04-29 19:39:43');
INSERT INTO `room_info` VALUES (45, '4605', 2, 2, '46', '13276672031', '2024-04-29 19:39:49', '2024-05-02 19:25:57');
INSERT INTO `room_info` VALUES (46, '4606', 2, 1, '46', NULL, '2024-04-29 19:40:04', '2024-04-29 19:40:04');
INSERT INTO `room_info` VALUES (47, '4607', 2, 3, '46', '18645687852', '2024-04-29 19:40:09', '2024-05-01 20:33:47');
INSERT INTO `room_info` VALUES (48, '4608', 2, 1, '46', NULL, '2024-04-29 19:41:23', '2024-04-29 19:41:23');
INSERT INTO `room_info` VALUES (49, '4609', 2, 1, '46', '', '2024-04-29 19:41:28', '2024-05-04 13:34:40');
INSERT INTO `room_info` VALUES (50, '4610', 2, 1, '46', NULL, '2024-04-29 19:41:35', '2024-04-29 19:41:35');
INSERT INTO `room_info` VALUES (51, '4701', 3, 1, '47', NULL, '2024-04-29 19:39:23', '2024-04-29 19:39:23');
INSERT INTO `room_info` VALUES (52, '4702', 3, 1, '47', NULL, '2024-04-29 19:39:29', '2024-04-29 19:39:29');
INSERT INTO `room_info` VALUES (53, '4703', 3, 1, '47', NULL, '2024-04-29 19:39:36', '2024-04-29 19:39:36');
INSERT INTO `room_info` VALUES (54, '4704', 3, 1, '47', NULL, '2024-04-29 19:39:43', '2024-04-29 19:39:43');
INSERT INTO `room_info` VALUES (55, '4705', 3, 1, '47', NULL, '2024-04-29 19:39:49', '2024-04-29 19:39:49');
INSERT INTO `room_info` VALUES (56, '4706', 3, 1, '47', NULL, '2024-04-29 19:40:04', '2024-04-29 19:40:04');
INSERT INTO `room_info` VALUES (57, '4707', 3, 1, '47', NULL, '2024-04-29 19:40:09', '2024-04-29 19:40:09');
INSERT INTO `room_info` VALUES (58, '4708', 3, 1, '47', NULL, '2024-04-29 19:41:23', '2024-04-29 19:41:23');
INSERT INTO `room_info` VALUES (59, '4709', 3, 1, '47', NULL, '2024-04-29 19:41:28', '2024-04-29 19:41:28');
INSERT INTO `room_info` VALUES (60, '4710', 3, 1, '47', NULL, '2024-04-29 19:41:35', '2024-04-29 19:41:35');
INSERT INTO `room_info` VALUES (63, '4801', 3, 2, '48', '13345687985', '2024-04-29 19:46:06', '2024-05-02 18:31:50');
INSERT INTO `room_info` VALUES (64, '4802', 3, 1, '48', NULL, '2024-04-29 19:48:04', '2024-04-29 19:48:04');
INSERT INTO `room_info` VALUES (65, '4803', 3, 1, '48', NULL, '2024-04-29 19:48:21', '2024-04-29 19:48:21');
INSERT INTO `room_info` VALUES (66, '4804', 3, 1, '48', NULL, '2024-04-29 19:48:42', '2024-04-29 19:48:42');
INSERT INTO `room_info` VALUES (67, '4805', 3, 1, '48', NULL, '2024-04-29 19:49:09', '2024-04-29 19:49:09');
INSERT INTO `room_info` VALUES (68, '4806', 3, 1, '48', NULL, '2024-04-29 19:49:23', '2024-04-29 19:49:23');
INSERT INTO `room_info` VALUES (69, '4807', 3, 1, '48', NULL, '2024-04-29 19:49:32', '2024-04-29 19:49:32');
INSERT INTO `room_info` VALUES (70, '4808', 3, 1, '48', NULL, '2024-04-29 19:49:39', '2024-04-29 19:49:39');
INSERT INTO `room_info` VALUES (71, '4809', 3, 1, '48', NULL, '2024-04-29 19:49:48', '2024-04-29 19:49:48');
INSERT INTO `room_info` VALUES (72, '4810', 3, 1, '48', NULL, '2024-04-29 19:49:54', '2024-04-29 19:49:54');
INSERT INTO `room_info` VALUES (73, '4901', 4, 1, '49', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (74, '4902', 4, 1, '49', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (75, '4903', 4, 1, '49', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (76, '4904', 4, 1, '49', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (77, '4905', 4, 1, '49', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (78, '4906', 4, 1, '49', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (79, '4907', 4, 1, '49', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (80, '4908', 4, 1, '49', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (81, '4909', 4, 1, '49', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (82, '4910', 4, 1, '49', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (83, '5001', 4, 1, '50', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (84, '5002', 4, 1, '50', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (85, '5003', 4, 1, '50', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (86, '5004', 4, 1, '50', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (87, '5005', 4, 1, '50', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (88, '5006', 4, 1, '50', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (89, '5007', 4, 1, '50', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (90, '5008', 4, 1, '50', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (91, '5009', 4, 1, '50', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (92, '5010', 4, 1, '50', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (93, '5101', 5, 1, '51', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (94, '5102', 5, 2, '51', '15416587895', '2024-04-29 19:50:12', '2024-05-01 21:09:48');
INSERT INTO `room_info` VALUES (95, '5103', 5, 1, '51', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (96, '5104', 5, 1, '51', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (97, '5105', 5, 1, '51', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (98, '5106', 5, 1, '51', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (99, '5107', 5, 1, '51', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (100, '5108', 5, 1, '51', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (101, '5109', 5, 1, '51', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (102, '5110', 5, 1, '51', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (103, '5201', 5, 1, '52', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (104, '5202', 5, 1, '52', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (105, '5203', 5, 1, '52', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (106, '5204', 5, 1, '52', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (107, '5205', 5, 1, '52', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (108, '5206', 5, 1, '52', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (109, '5207', 5, 1, '52', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (110, '5208', 5, 1, '52', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (111, '5209', 5, 1, '52', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (112, '5210', 5, 1, '52', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (113, '5301', 7, 1, '53', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (114, '5302', 7, 1, '53', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (115, '5303', 7, 3, '53', '13276672013', '2024-04-29 19:50:19', '2024-05-04 13:34:40');
INSERT INTO `room_info` VALUES (116, '5304', 7, 1, '53', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (117, '5305', 7, 1, '53', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (118, '5306', 7, 1, '53', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (119, '5307', 7, 1, '53', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (120, '5308', 7, 1, '53', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (121, '5309', 7, 1, '53', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (122, '5310', 7, 1, '53', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (123, '5401', 7, 1, '54', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (124, '5402', 7, 1, '54', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (125, '5403', 7, 1, '54', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (126, '5404', 7, 1, '54', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (127, '5405', 7, 1, '54', NULL, '2024-04-29 19:50:04', '2024-04-29 19:50:04');
INSERT INTO `room_info` VALUES (128, '5406', 7, 1, '54', NULL, '2024-04-29 19:50:12', '2024-04-29 19:50:12');
INSERT INTO `room_info` VALUES (129, '5407', 7, 1, '54', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (130, '5408', 7, 1, '54', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (131, '5409', 7, 1, '54', NULL, '2024-04-29 19:50:19', '2024-04-29 19:50:19');
INSERT INTO `room_info` VALUES (132, '5410', 7, 1, '54', NULL, '2024-04-29 19:50:26', '2024-04-29 19:50:26');
INSERT INTO `room_info` VALUES (200, '5501', 8, 1, '55', NULL, '2024-04-29 19:50:04', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (201, '5502', 8, 1, '55', NULL, '2024-04-29 19:50:12', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (202, '5503', 8, 1, '55', NULL, '2024-04-29 19:50:19', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (203, '5504', 8, 1, '55', NULL, '2024-04-29 19:50:26', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (204, '5505', 8, 3, '55', '13276673000', '2024-04-29 19:50:04', '2024-05-01 22:20:36');
INSERT INTO `room_info` VALUES (205, '5506', 8, 1, '55', NULL, '2024-04-29 19:50:12', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (206, '5507', 8, 1, '55', NULL, '2024-04-29 19:50:19', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (207, '5508', 8, 1, '55', NULL, '2024-04-29 19:50:26', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (208, '5509', 8, 1, '55', NULL, '2024-04-29 19:50:19', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (209, '5510', 8, 1, '55', NULL, '2024-04-29 19:50:26', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (210, '5601', 10, 1, '56', NULL, '2024-04-29 19:50:12', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (211, '5602', 10, 1, '56', NULL, '2024-04-29 19:50:19', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (212, '5603', 10, 1, '56', '', '2024-04-29 19:50:26', '2024-05-01 22:20:35');
INSERT INTO `room_info` VALUES (213, '5604', 10, 1, '56', NULL, '2024-04-29 19:50:04', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (214, '5605', 10, 1, '56', NULL, '2024-04-29 19:50:12', '2024-04-29 20:02:12');
INSERT INTO `room_info` VALUES (216, 'cs501', 15, 1, '5', NULL, '2024-04-29 20:24:44', '2024-04-29 20:25:15');

-- ----------------------------
-- Table structure for room_type
-- ----------------------------
DROP TABLE IF EXISTS `room_type`;
CREATE TABLE `room_type`  (
  `type_id` int(20) NOT NULL AUTO_INCREMENT COMMENT '类型ID',
  `type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型名',
  `type_num` int(11) NOT NULL COMMENT '房间数量',
  `price` double(10, 0) NOT NULL DEFAULT 0 COMMENT '房间价格',
  `deposit` double(10, 0) NOT NULL COMMENT '房间押金',
  `type_bed` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '床型',
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '12' COMMENT '房间大小:m2',
  `tc_num` int(11) NOT NULL COMMENT '可住人数',
  `floor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分布楼层',
  `picture` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房型图片',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`type_id`) USING BTREE,
  UNIQUE INDEX `uqe_room_type`(`type_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '房间类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_type
-- ----------------------------
INSERT INTO `room_type` VALUES (2, '1 张特大床, 城市景观, 客房', 20, 338, 500, '1 张特大床', '20-25', 2, '45-46', 'b6bbc159-bed7-424a-8819-0635a2a473151.png', '2018-11-13 16:55:09', '2024-04-25 17:48:48');
INSERT INTO `room_type` VALUES (3, '2 张单人床, 城市景观, 客房', 20, 358, 500, '2 张单人床', '20-25', 2, '47-48', '0116d29a-7946-48b7-8b24-4475164ae8eb2.png', '2018-10-31 19:32:03', '2024-04-25 18:00:07');
INSERT INTO `room_type` VALUES (4, '1 张特大床, 湖景, 客房', 20, 438, 800, '1 张特大床', '20-25', 2, '49-50', '19d033f8-479f-4103-bbcd-5a7694910f733.png', '2018-11-13 20:27:02', '2024-04-25 18:00:20');
INSERT INTO `room_type` VALUES (5, '2 张单人床, 湖景, 客房', 20, 458, 800, '2 张单人床', '20-25', 2, '51-52', '3f9c9dcc-bc9e-4653-b2af-93a4817f52e54.png', '2018-11-13 20:28:08', '2024-04-25 18:00:24');
INSERT INTO `room_type` VALUES (7, '1 张特大床, 城市景观, 行政酒廊礼遇, 客房', 20, 788, 1000, '1 张特大床', '25-35', 2, '53-54', '5b105a8c-c9ef-452a-8c0f-ff91ef586d5e5.png', '2018-12-03 11:24:07', '2024-04-25 18:00:32');
INSERT INTO `room_type` VALUES (8, '1 张特大床, 湖景, 行政酒廊礼遇, 总统套房', 10, 988, 2000, '1 张特大床', '25-35', 2, '55', '4479ee47-7509-4ea2-bb7a-fb61ff7605ad6.png', '2018-12-22 13:42:21', '2024-04-25 18:00:36');
INSERT INTO `room_type` VALUES (10, '4 张特大床, 湖景, 行政酒廊礼遇, 总统套房', 5, 989, 2400, '4 张特大床', '31-35', 6, '56', 'fdcf3728-931b-4e2d-ac75-a57b87f561234.png', '2024-04-25 14:29:58', '2024-04-25 17:48:14');
INSERT INTO `room_type` VALUES (15, 'cs5', 5, 5, 5, '5', '5', 5, '5', 'fb6d65d1-b5ae-447f-a2bb-f6019dffbc0b2.png', '2024-04-25 22:46:07', '2024-04-25 22:46:07');
INSERT INTO `room_type` VALUES (16, 'cs7', 5, 100, 100, '7', '7', 7, '7', '5bc446b2-b19b-470c-93bf-37feb9ab658e6.png', '2024-04-29 20:24:27', '2024-04-29 20:24:27');
INSERT INTO `room_type` VALUES (18, 'cs6', 5, 100, 200, '1 张特大床', '20-25', 5, '10-11', '8d5eca86-0f9a-4265-a0e8-c34bf8c63a7f5.png', '2024-05-04 13:36:12', '2024-05-04 13:36:12');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `gender` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '男' COMMENT '性别',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码',
  `email` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `address` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `idcard` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号码',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uqe_phone`(`phone`) USING BTREE,
  UNIQUE INDEX `uqe_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '注册用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (12, 'user0', 'pass0', '司蕊', '女', '15902203347', '7y4ikalr@googlemail.com', '新湛路90号-13-10', '155002902231550688', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (13, 'user1', 'pass1', '刁奇善', '男', '15000492184', '0pcdc5@hotmail.com', '河北大厦113号-13-7', '137077905971370626', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (14, 'user2', 'pass2', '空友', '男', '13504010606', 'bgqpdzy5@163.net', '贮水山大厦113号-13-5', '131022008441310667', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (15, 'user3', 'pass3', '聂志河', '男', '13007413989', 'm8yf2x@yahoo.com.cn', '澳门八街123号-9-9', '138080908841380496', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (16, 'user4', 'pass4', '董梁飞', '男', '13308573145', '5qnpxg3@msn.com', '金门路146号-5-2', '150052203431500459', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (17, 'user5', 'pass5', '衡昌功', '男', '15707416676', 'voa12ru@googlemail.com', '秋阳路142号-15-5', '150052105641500768', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (18, 'user6', 'pass6', '凤翠琰', '女', '13601540822', 'p8hy3un7@126.com', '漳州街二街110号-4-9', '130014701651300723', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (19, 'user7', 'pass7', '焦永树', '男', '13802622538', 'uylsv4k@hotmail.com', '宁夏路98号-2-1', '138041006231380509', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (20, 'user8', 'pass8', '戴心', '男', '13502253514', '60wi7ri@qq.com', '广西街26号-3-1', '150053806601500816', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (21, 'user9', 'pass9', '施航', '男', '13601170914', 'q5gq21rb@yahoo.com.cn', '硕阳街125号-18-2', '133035705121330430', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (22, 'user10', 'pass10', '巩宜娣', '女', '15705104604', 'syuqfan@163.com', '居庸关街116号-19-9', '139081700871390257', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (23, 'user11', 'pass11', '宰环', '女', '15008005526', 'r6hl6jj@163.net', '鹊山广场150号-14-3', '135042502421350645', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (24, 'user12', 'pass12', '舌鹏', '男', '15601528069', 'xuys772@163.net', '台东八广场141号-9-5', '136023204721360103', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (25, 'user13', 'pass13', '奚馨', '女', '13707191699', 'ntfp3w0@hotmail.com', '新泰大厦99号-8-3', '137045102781370883', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (26, 'user14', 'pass14', '童彪林', '男', '13404156615', 'na9k2qvq@msn.com', '澳门一路88号-13-10', '153080805961530311', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (27, 'user15', 'pass15', '伍菊澜', '女', '13602777035', '9yciidvd@googlemail.com', '丽水街136号-6-5', '131002004271310589', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (28, 'user16', 'pass16', '班旭', '男', '15801762368', 'ktw6enh@aol.com', '宁国二支路40号-10-6', '150009406161500782', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (29, 'user17', 'pass17', '童福', '男', '15500527496', 'b6s47itop@gmail.com', '石岛广场137号-8-6', '131033103661310677', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (30, 'user18', 'pass18', '五超', '男', '15501533610', 'sdriz3@gmail.com', '珠海一广场20号-19-10', '132042105071320341', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (31, 'user19', 'pass19', '管健信', '男', '15101630430', 'gcfc9ew0@ask.com', '无棣街70号-1-5', '133052206051330281', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (32, 'user20', 'pass20', '太策', '男', '15200581655', 'wk8yad@aol.com', '东阿街136号-11-9', '139076304341390552', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (33, 'user21', 'pass21', '容善庆', '男', '13304126348', '21mkw0ir@126.com', '历城广场19号-2-4', '130085700861300159', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (34, 'user22', 'pass22', '佟文', '男', '15105082209', 'l0uhs96u@aol.com', '南通大厦23号-15-3', '151008800731510719', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (35, 'user23', 'pass23', '戴婕筠', '女', '15601311376', 'pqzk2v@msn.com', '瑞云街58号-8-5', '137082808401370585', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (36, 'user24', 'pass24', '龙伊纯', '女', '15706021078', '7xn2lf7@hotmail.com', '重庆大厦94号-5-5', '130035108111300690', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (37, 'user25', 'pass25', '边希', '女', '13901196618', '6ypojp@sina.com', '汶水街93号-2-4', '138018905981380101', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (38, 'user26', 'pass26', '伍兰', '女', '13807388270', 'ca6afv6s@ask.com', '芝罘路123号-8-6', '156022505691560735', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (39, 'user27', 'pass27', '倪俊', '男', '13904570746', '43zjstnll@ask.com', '杭州支广场110号-1-6', '130073600611300390', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (40, 'user28', 'pass28', '官胜斌', '男', '15603811430', 'jm65g1mnm@googlemail.com', '仙居街115号-7-4', '153046200381530325', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (41, 'user29', 'pass29', '隗军士', '男', '15004855580', 'ddcksa18y@0355.net', '大连支街112号-18-4', '155077500681550097', '2018-11-30 23:17:39', '2018-11-30 23:17:39');
INSERT INTO `user_info` VALUES (73, 'baozhiku', '123456', '包23', '男', '18767140000', '1924389@qq.com', 'io', '1243214325436436', '2018-12-03 10:43:48', '2023-03-10 15:11:17');
INSERT INTO `user_info` VALUES (77, 'muamua', 'muamua', '李小明', '男', '16812585899', '1032796097@qq.com', '浙江省杭州市', '441821199603192231', '2018-12-13 19:06:34', '2023-03-10 15:11:20');
INSERT INTO `user_info` VALUES (78, 'ss', '111', 'dasd', '男', '123456788145', '111@com', 'ssss', '1111', '2018-12-18 14:30:32', '2018-12-18 14:30:32');
INSERT INTO `user_info` VALUES (79, 'ruanxu', '123456', '阮旭', '男', '18768224455', '1239485594@qq.com', '软须', '4419284299023902244', '2018-12-22 13:37:04', '2018-12-22 13:37:04');
INSERT INTO `user_info` VALUES (80, 'ceshi', '123456', '测试', '女', '187681257384', '1093847437@test.cn', '软须', '441821924292039902', '2018-12-22 14:11:37', '2018-12-22 14:11:37');
INSERT INTO `user_info` VALUES (81, 'wwmm', 'wwwmmm', 'w', '男', 'fe', 'fe', 'fe', 'ef', '2019-01-03 19:28:04', '2019-01-03 19:28:04');
INSERT INTO `user_info` VALUES (82, '123', '123', '123', '男', '123', '123', '123', '123', '2019-01-11 11:04:14', '2019-01-11 11:04:14');
INSERT INTO `user_info` VALUES (83, '苍海', '123456', '苍海', '男', '17612137467', 'canghai0617@163.com', '上海', '325452199012134098', '2019-01-21 12:49:37', '2019-01-21 12:49:37');
INSERT INTO `user_info` VALUES (84, 'admin', '123456', 'jim', '男', '18621709036', 'jimhu0817@163.com', 'shanghai', '110101199003075592', '2019-01-21 15:01:10', '2019-01-21 15:01:10');
INSERT INTO `user_info` VALUES (85, 'gagechan', '123456', '陈锦瑞', '男', '13060221766', 'gage@foxmail.com', '四川省成都市', '500101199809128878', '2019-03-03 18:40:54', '2019-03-03 18:40:54');
INSERT INTO `user_info` VALUES (86, 'asd', 'asd', 'asd', '男', 'asd', 'asd', 'asd', 'asd', '2019-03-13 11:14:22', '2019-03-13 11:14:22');
INSERT INTO `user_info` VALUES (88, 'l', '123', '林', '男', '13367208346', '1262676539@qq.com', '北京', '5208', '2019-03-17 23:03:14', '2019-03-17 23:03:14');
INSERT INTO `user_info` VALUES (89, 'hahah', 'asdzxc1314', '东少', '男', '15601335391', 'm15601335391@163.com', 'beijing', '1', '2019-03-18 09:21:49', '2019-03-18 09:21:49');
INSERT INTO `user_info` VALUES (90, 'dajiang', '123456', '大江', '女', '13819234567', '649001928@163.com', '东京', '231126199109090411', '2019-03-20 10:39:14', '2019-03-20 10:39:14');
INSERT INTO `user_info` VALUES (91, 'freee', 'e10adc3949ba59abbe56e057f20f883e', '谢建峰', '男', '18768124566', '184732@qq.com', '凤起路8号', '661723489884389232', '2019-09-20 09:39:56', '2019-11-22 21:50:58');
INSERT INTO `user_info` VALUES (92, 'fdsafdasfdsafdsa', '202cb962ac59075b964b07152d234b70', '的萨芬', '男', '24324324', '', '', '', '2019-11-28 21:03:45', '2019-11-28 21:03:45');

-- ----------------------------
-- Table structure for worker_info
-- ----------------------------
DROP TABLE IF EXISTS `worker_info`;
CREATE TABLE `worker_info`  (
  `worker_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '操作员id',
  `role` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'operator' COMMENT '角色:worker/admin',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '姓名',
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`worker_id`) USING BTREE,
  UNIQUE INDEX `uqe_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '工作人员信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of worker_info
-- ----------------------------
INSERT INTO `worker_info` VALUES (1, 'admin', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '何来', '18758343488', '2018-11-12 15:33:50', '2024-05-02 19:27:30');
INSERT INTO `worker_info` VALUES (5, 'operator', 'wawa', 'e10adc3949ba59abbe56e057f20f883e', '李大霄', '12345678', '2018-11-26 19:48:16', '2024-05-02 19:27:32');
INSERT INTO `worker_info` VALUES (6, 'operator', 'op', 'e10adc3949ba59abbe56e057f20f883e', '杜锋', '124342', '2018-11-30 11:55:12', '2024-05-02 19:27:33');
INSERT INTO `worker_info` VALUES (7, 'operator', 'abc', 'e10adc3949ba59abbe56e057f20f883e', '韩格', '242424', '2018-11-30 11:55:14', '2024-05-02 19:27:34');
INSERT INTO `worker_info` VALUES (8, 'admin', 'freee', 'e10adc3949ba59abbe56e057f20f883e', '谢建峰', '18768124566', '2019-11-27 20:18:17', '2019-11-27 20:18:17');
INSERT INTO `worker_info` VALUES (9, 'operator', 'www', 'e10adc3949ba59abbe56e057f20f883e', '放电管', '234324354', '2019-11-28 20:31:55', '2019-11-28 20:31:55');
INSERT INTO `worker_info` VALUES (11, 'admin', 'ccss1', 'd8578edf8458ce06fbc5bb76a58c5ca4', '窝窝窝1', '13276672033', '2024-05-02 11:14:12', '2024-05-02 12:53:46');

SET FOREIGN_KEY_CHECKS = 1;
