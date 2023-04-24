/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : stdc

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 24/04/2023 17:53:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `address_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int(0) UNSIGNED NOT NULL,
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `consignee` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`address_id`) USING BTREE,
  INDEX `fk_address_user_on_userid`(`user_id`) USING BTREE,
  CONSTRAINT `fk_address_user_on_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES (1, 1, '图书馆四楼', '张三', '13857003220');
INSERT INTO `address` VALUES (3, 1, '图书馆ssanlpu ', '张三', '13857003220');
INSERT INTO `address` VALUES (8, 1, '凌云2#222', '罗san', '12221');
INSERT INTO `address` VALUES (9, 2, '图书馆', '张楠', '12345');
INSERT INTO `address` VALUES (10, 2, '南安1', '张楠', '11111111');
INSERT INTO `address` VALUES (11, 2, '南安6', '张楠', '18859648985');

-- ----------------------------
-- Table structure for canteen
-- ----------------------------
DROP TABLE IF EXISTS `canteen`;
CREATE TABLE `canteen`  (
  `canteen_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `floor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `canteen_pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`canteen_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of canteen
-- ----------------------------
INSERT INTO `canteen` VALUES (1, '北区', '一楼', '/static/logo.png', 'b1admin', '123');
INSERT INTO `canteen` VALUES (2, '北区', '二楼', '/static/logo.png', 'b2admin', '123');
INSERT INTO `canteen` VALUES (3, '北区', '三楼', '/static/logo.png', 'b3admin', '123');
INSERT INTO `canteen` VALUES (4, '中区', '一楼', '/static/logo.png', 'z1admin', '123');
INSERT INTO `canteen` VALUES (5, '中区', '二楼', '/static/logo.png', 'z2admin', '123');
INSERT INTO `canteen` VALUES (6, '南区', '一楼', '/static/logo.png', 'n1admin', '123');
INSERT INTO `canteen` VALUES (7, '南区', '二楼', '/static/logo.png', 'n2admin', '123');
INSERT INTO `canteen` VALUES (8, '北区', '嘉园餐厅', '/static/logo.png', 'b4admin', '123');
INSERT INTO `canteen` VALUES (9, '北区', '南墙餐厅', '/static/logo.png', 'nqadmin', '123');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int(0) UNSIGNED NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `comment_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `comment` int(0) NULL DEFAULT 5,
  `user_id` int(0) UNSIGNED NOT NULL,
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `fk_comment_torder_on_orderid`(`order_id`) USING BTREE,
  INDEX `fk_comment_user_on_userid`(`user_id`) USING BTREE,
  CONSTRAINT `fk_comment_torder_on_orderid` FOREIGN KEY (`order_id`) REFERENCES `torder` (`order_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_user_on_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (3, 8, '很好吃', '2022/11/21 13:16', 3, 1);
INSERT INTO `comment` VALUES (4, 8, '挺好吃的', '2022/11/21 14:05', 3, 1);
INSERT INTO `comment` VALUES (6, 19, '很不错', '2022-12-25 14:43:35', 4, 2);

-- ----------------------------
-- Table structure for cuisine
-- ----------------------------
DROP TABLE IF EXISTS `cuisine`;
CREATE TABLE `cuisine`  (
  `cuisine_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `canteen_id` int(0) UNSIGNED NOT NULL,
  `cuisine_price` double NOT NULL,
  `classes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `status` int(0) NULL DEFAULT NULL,
  `cuisine_pic_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cuisine_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`cuisine_id`) USING BTREE,
  INDEX `fk_cuisine_canteen_on_canteen_id`(`canteen_id`) USING BTREE,
  CONSTRAINT `fk_cuisine_canteen_on_canteen_id` FOREIGN KEY (`canteen_id`) REFERENCES `canteen` (`canteen_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 174 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cuisine
-- ----------------------------
INSERT INTO `cuisine` VALUES (2, 1, 1.5, '小炒', 1, '/static/logo.png', '炒土豆丝');
INSERT INTO `cuisine` VALUES (3, 1, 4.5, '小炒', 1, '/static/logo.png', '青椒肉丝');
INSERT INTO `cuisine` VALUES (4, 1, 1.5, '小炒', 1, '/static/logo.png', '醋溜白菜');
INSERT INTO `cuisine` VALUES (5, 1, 3, '红烧', 1, '/static/logo.png', '红烧肉');
INSERT INTO `cuisine` VALUES (6, 1, 2, '红烧', 1, '/static/logo.png', '麻婆豆腐');
INSERT INTO `cuisine` VALUES (7, 1, 6, '红烧', 1, '/static/logo.png', '番茄土豆烧牛腩');
INSERT INTO `cuisine` VALUES (8, 1, 6, '红烧', 1, '/static/logo.png', '啤酒烧鸭腿');
INSERT INTO `cuisine` VALUES (9, 1, 4.5, '蒸菜', 1, '/static/logo.png', '豆豉蒸排骨');
INSERT INTO `cuisine` VALUES (10, 1, 5, '蒸菜', 1, '/static/logo.png', '黄豆酱蒸鱼');
INSERT INTO `cuisine` VALUES (11, 1, 4, '蒸菜', 1, '/static/logo.png', '粉蒸肉');
INSERT INTO `cuisine` VALUES (12, 1, 4, '蒸菜', 1, '/static/logo.png', '蒜蓉蒸鲍鱼');
INSERT INTO `cuisine` VALUES (14, 1, 3, '凉菜', 0, '/static/logo.png', '拍黄瓜');
INSERT INTO `cuisine` VALUES (15, 1, 3, '凉菜', 1, '/static/logo.png', '凉拌茄子');
INSERT INTO `cuisine` VALUES (16, 1, 3, '凉菜', 1, '/static/logo.png', '京酱肉丝');
INSERT INTO `cuisine` VALUES (17, 1, 6, '汤', 1, '/static/logo.png', '鲫鱼豆腐汤');
INSERT INTO `cuisine` VALUES (18, 1, 4, '汤', 1, '/static/logo.png', '豆腐蛤蜊汤');
INSERT INTO `cuisine` VALUES (19, 1, 4, '汤', 1, '/static/logo.png', '黄豆猪脚汤');
INSERT INTO `cuisine` VALUES (20, 1, 5, '汤', 1, '/static/logo.png', '老鸭汤');
INSERT INTO `cuisine` VALUES (21, 1, 6, '小炒', 1, '/static/logo.png', '清炒虾仁');
INSERT INTO `cuisine` VALUES (22, 1, 4, '红烧', 1, '/static/logo.png', '红烧鸡翅');
INSERT INTO `cuisine` VALUES (23, 1, 2, '蒸菜', 1, '/static/logo.png', '蒸蛋');
INSERT INTO `cuisine` VALUES (24, 1, 6, '汤', 1, '/static/logo.png', '猴头菇骨头汤');
INSERT INTO `cuisine` VALUES (25, 2, 4, '小炒', 1, '/static/logo.png', '西红柿炒蛋');
INSERT INTO `cuisine` VALUES (26, 2, 1.5, '小炒', 1, '/static/logo.png', '炒土豆丝');
INSERT INTO `cuisine` VALUES (27, 2, 4.5, '小炒', 1, '/static/logo.png', '青椒肉丝');
INSERT INTO `cuisine` VALUES (28, 2, 1.5, '小炒', 1, '/static/logo.png', '醋溜白菜');
INSERT INTO `cuisine` VALUES (29, 2, 3, '红烧', 1, '/static/logo.png', '红烧肉');
INSERT INTO `cuisine` VALUES (30, 2, 2, '红烧', 1, '/static/logo.png', '麻婆豆腐');
INSERT INTO `cuisine` VALUES (31, 2, 6, '红烧', 1, '/static/logo.png', '番茄土豆烧牛腩');
INSERT INTO `cuisine` VALUES (32, 2, 6, '红烧', 1, '/static/logo.png', '啤酒烧鸭腿');
INSERT INTO `cuisine` VALUES (33, 2, 4.5, '蒸菜', 1, '/static/logo.png', '豆豉蒸排骨');
INSERT INTO `cuisine` VALUES (34, 2, 5, '蒸菜', 1, '/static/logo.png', '黄豆酱蒸鱼');
INSERT INTO `cuisine` VALUES (35, 2, 4, '蒸菜', 1, '/static/logo.png', '粉蒸肉');
INSERT INTO `cuisine` VALUES (36, 2, 4, '蒸菜', 1, '/static/logo.png', '蒜蓉蒸鲍鱼');
INSERT INTO `cuisine` VALUES (37, 2, 3, '凉菜', 1, '/static/logo.png', '凉拌藕片');
INSERT INTO `cuisine` VALUES (38, 2, 3, '凉菜', 1, '/static/logo.png', '拍黄瓜');
INSERT INTO `cuisine` VALUES (39, 2, 3, '凉菜', 1, '/static/logo.png', '凉拌茄子');
INSERT INTO `cuisine` VALUES (40, 2, 3, '凉菜', 1, '/static/logo.png', '京酱肉丝');
INSERT INTO `cuisine` VALUES (41, 2, 6, '汤', 1, '/static/logo.png', '鲫鱼豆腐汤');
INSERT INTO `cuisine` VALUES (42, 2, 4, '汤', 1, '/static/logo.png', '豆腐蛤蜊汤');
INSERT INTO `cuisine` VALUES (43, 2, 4, '汤', 1, '/static/logo.png', '黄豆猪脚汤');
INSERT INTO `cuisine` VALUES (44, 2, 5, '汤', 1, '/static/logo.png', '老鸭汤');
INSERT INTO `cuisine` VALUES (45, 2, 6, '小炒', 1, '/static/logo.png', '清炒虾仁');
INSERT INTO `cuisine` VALUES (46, 2, 4, '红烧', 1, '/static/logo.png', '红烧鸡翅');
INSERT INTO `cuisine` VALUES (47, 2, 2, '蒸菜', 1, '/static/logo.png', '蒸蛋');
INSERT INTO `cuisine` VALUES (48, 2, 6, '汤', 1, '/static/logo.png', '猴头菇骨头汤');
INSERT INTO `cuisine` VALUES (49, 3, 3, '小炒', 1, '/static/logo.png', '西红柿炒蛋');
INSERT INTO `cuisine` VALUES (50, 3, 1.5, '小炒', 1, '/static/logo.png', '炒土豆丝');
INSERT INTO `cuisine` VALUES (51, 3, 4.5, '小炒', 1, '/static/logo.png', '青椒肉丝');
INSERT INTO `cuisine` VALUES (52, 3, 1.5, '小炒', 1, '/static/logo.png', '醋溜白菜');
INSERT INTO `cuisine` VALUES (53, 3, 3, '红烧', 1, '/static/logo.png', '红烧肉');
INSERT INTO `cuisine` VALUES (54, 3, 2, '红烧', 1, '/static/logo.png', '麻婆豆腐');
INSERT INTO `cuisine` VALUES (55, 3, 6, '红烧', 1, '/static/logo.png', '番茄土豆烧牛腩');
INSERT INTO `cuisine` VALUES (56, 3, 6, '红烧', 1, '/static/logo.png', '啤酒烧鸭腿');
INSERT INTO `cuisine` VALUES (57, 3, 4.5, '蒸菜', 1, '/static/logo.png', '豆豉蒸排骨');
INSERT INTO `cuisine` VALUES (58, 3, 5, '蒸菜', 1, '/static/logo.png', '黄豆酱蒸鱼');
INSERT INTO `cuisine` VALUES (59, 3, 4, '蒸菜', 1, '/static/logo.png', '粉蒸肉');
INSERT INTO `cuisine` VALUES (60, 3, 4, '蒸菜', 1, '/static/logo.png', '蒜蓉蒸鲍鱼');
INSERT INTO `cuisine` VALUES (61, 3, 3, '凉菜', 1, '/static/logo.png', '凉拌藕片');
INSERT INTO `cuisine` VALUES (62, 3, 3, '凉菜', 1, '/static/logo.png', '拍黄瓜');
INSERT INTO `cuisine` VALUES (63, 3, 3, '凉菜', 1, '/static/logo.png', '凉拌茄子');
INSERT INTO `cuisine` VALUES (64, 3, 3, '凉菜', 1, '/static/logo.png', '京酱肉丝');
INSERT INTO `cuisine` VALUES (65, 3, 6, '汤', 1, '/static/logo.png', '鲫鱼豆腐汤');
INSERT INTO `cuisine` VALUES (66, 3, 4, '汤', 1, '/static/logo.png', '豆腐蛤蜊汤');
INSERT INTO `cuisine` VALUES (67, 3, 4, '汤', 1, '/static/logo.png', '黄豆猪脚汤');
INSERT INTO `cuisine` VALUES (68, 3, 5, '汤', 1, '/static/logo.png', '老鸭汤');
INSERT INTO `cuisine` VALUES (69, 3, 6, '小炒', 1, '/static/logo.png', '清炒虾仁');
INSERT INTO `cuisine` VALUES (70, 3, 4, '红烧', 1, '/static/logo.png', '红烧鸡翅');
INSERT INTO `cuisine` VALUES (71, 3, 2, '蒸菜', 1, '/static/logo.png', '蒸蛋');
INSERT INTO `cuisine` VALUES (72, 3, 6, '汤', 1, '/static/logo.png', '猴头菇骨头汤');
INSERT INTO `cuisine` VALUES (73, 4, 3, '小炒', 1, '/static/logo.png', '西红柿炒蛋');
INSERT INTO `cuisine` VALUES (74, 4, 1.5, '小炒', 1, '/static/logo.png', '炒土豆丝');
INSERT INTO `cuisine` VALUES (75, 4, 4.5, '小炒', 1, '/static/logo.png', '青椒肉丝');
INSERT INTO `cuisine` VALUES (76, 4, 1.5, '小炒', 1, '/static/logo.png', '醋溜白菜');
INSERT INTO `cuisine` VALUES (77, 4, 3, '红烧', 1, '/static/logo.png', '红烧肉');
INSERT INTO `cuisine` VALUES (78, 4, 2, '红烧', 1, '/static/logo.png', '麻婆豆腐');
INSERT INTO `cuisine` VALUES (79, 4, 6, '红烧', 1, '/static/logo.png', '番茄土豆烧牛腩');
INSERT INTO `cuisine` VALUES (80, 4, 6, '红烧', 1, '/static/logo.png', '啤酒烧鸭腿');
INSERT INTO `cuisine` VALUES (81, 4, 4.5, '蒸菜', 1, '/static/logo.png', '豆豉蒸排骨');
INSERT INTO `cuisine` VALUES (82, 4, 5, '蒸菜', 1, '/static/logo.png', '黄豆酱蒸鱼');
INSERT INTO `cuisine` VALUES (83, 4, 4, '蒸菜', 1, '/static/logo.png', '粉蒸肉');
INSERT INTO `cuisine` VALUES (84, 4, 4, '蒸菜', 1, '/static/logo.png', '蒜蓉蒸鲍鱼');
INSERT INTO `cuisine` VALUES (85, 4, 3, '凉菜', 1, '/static/logo.png', '凉拌藕片');
INSERT INTO `cuisine` VALUES (86, 4, 3, '凉菜', 1, '/static/logo.png', '拍黄瓜');
INSERT INTO `cuisine` VALUES (87, 4, 3, '凉菜', 1, '/static/logo.png', '凉拌茄子');
INSERT INTO `cuisine` VALUES (88, 4, 3, '凉菜', 1, '/static/logo.png', '京酱肉丝');
INSERT INTO `cuisine` VALUES (89, 4, 6, '汤', 1, '/static/logo.png', '鲫鱼豆腐汤');
INSERT INTO `cuisine` VALUES (90, 4, 4, '汤', 1, '/static/logo.png', '豆腐蛤蜊汤');
INSERT INTO `cuisine` VALUES (91, 4, 4, '汤', 1, '/static/logo.png', '黄豆猪脚汤');
INSERT INTO `cuisine` VALUES (92, 4, 5, '汤', 1, '/static/logo.png', '老鸭汤');
INSERT INTO `cuisine` VALUES (93, 4, 6, '小炒', 1, '/static/logo.png', '清炒虾仁');
INSERT INTO `cuisine` VALUES (94, 4, 4, '红烧', 1, '/static/logo.png', '红烧鸡翅');
INSERT INTO `cuisine` VALUES (95, 4, 2, '蒸菜', 1, '/static/logo.png', '蒸蛋');
INSERT INTO `cuisine` VALUES (96, 4, 6, '汤', 1, '/static/logo.png', '猴头菇骨头汤');
INSERT INTO `cuisine` VALUES (97, 5, 3, '小炒', 1, '/static/logo.png', '西红柿炒蛋');
INSERT INTO `cuisine` VALUES (98, 5, 1.5, '小炒', 1, '/static/logo.png', '炒土豆丝');
INSERT INTO `cuisine` VALUES (99, 5, 4.5, '小炒', 1, '/static/logo.png', '青椒肉丝');
INSERT INTO `cuisine` VALUES (100, 5, 1.5, '小炒', 1, '/static/logo.png', '醋溜白菜');
INSERT INTO `cuisine` VALUES (101, 5, 3, '红烧', 1, '/static/logo.png', '红烧肉');
INSERT INTO `cuisine` VALUES (102, 5, 2, '红烧', 1, '/static/logo.png', '麻婆豆腐');
INSERT INTO `cuisine` VALUES (103, 5, 6, '红烧', 1, '/static/logo.png', '番茄土豆烧牛腩');
INSERT INTO `cuisine` VALUES (104, 5, 6, '红烧', 1, '/static/logo.png', '啤酒烧鸭腿');
INSERT INTO `cuisine` VALUES (105, 5, 4.5, '蒸菜', 1, '/static/logo.png', '豆豉蒸排骨');
INSERT INTO `cuisine` VALUES (106, 5, 5, '蒸菜', 1, '/static/logo.png', '黄豆酱蒸鱼');
INSERT INTO `cuisine` VALUES (107, 5, 4, '蒸菜', 1, '/static/logo.png', '粉蒸肉');
INSERT INTO `cuisine` VALUES (108, 5, 4, '蒸菜', 1, '/static/logo.png', '蒜蓉蒸鲍鱼');
INSERT INTO `cuisine` VALUES (109, 5, 3, '凉菜', 1, '/static/logo.png', '凉拌藕片');
INSERT INTO `cuisine` VALUES (110, 5, 3, '凉菜', 1, '/static/logo.png', '拍黄瓜');
INSERT INTO `cuisine` VALUES (111, 5, 3, '凉菜', 1, '/static/logo.png', '凉拌茄子');
INSERT INTO `cuisine` VALUES (112, 5, 3, '凉菜', 1, '/static/logo.png', '京酱肉丝');
INSERT INTO `cuisine` VALUES (113, 5, 6, '汤', 1, '/static/logo.png', '鲫鱼豆腐汤');
INSERT INTO `cuisine` VALUES (114, 5, 4, '汤', 1, '/static/logo.png', '豆腐蛤蜊汤');
INSERT INTO `cuisine` VALUES (115, 5, 4, '汤', 1, '/static/logo.png', '黄豆猪脚汤');
INSERT INTO `cuisine` VALUES (116, 5, 5, '汤', 1, '/static/logo.png', '老鸭汤');
INSERT INTO `cuisine` VALUES (117, 5, 6, '小炒', 1, '/static/logo.png', '清炒虾仁');
INSERT INTO `cuisine` VALUES (118, 5, 4, '红烧', 1, '/static/logo.png', '红烧鸡翅');
INSERT INTO `cuisine` VALUES (119, 5, 2, '蒸菜', 1, '/static/logo.png', '蒸蛋');
INSERT INTO `cuisine` VALUES (120, 5, 6, '汤', 1, '/static/logo.png', '猴头菇骨头汤');
INSERT INTO `cuisine` VALUES (121, 6, 3, '小炒', 1, '/static/logo.png', '西红柿炒蛋');
INSERT INTO `cuisine` VALUES (122, 6, 1.5, '小炒', 1, '/static/logo.png', '炒土豆丝');
INSERT INTO `cuisine` VALUES (123, 6, 4.5, '小炒', 1, '/static/logo.png', '青椒肉丝');
INSERT INTO `cuisine` VALUES (124, 6, 1.5, '小炒', 1, '/static/logo.png', '醋溜白菜');
INSERT INTO `cuisine` VALUES (125, 6, 3, '红烧', 1, '/static/logo.png', '红烧肉');
INSERT INTO `cuisine` VALUES (126, 6, 2, '红烧', 1, '/static/logo.png', '麻婆豆腐');
INSERT INTO `cuisine` VALUES (127, 6, 6, '红烧', 1, '/static/logo.png', '番茄土豆烧牛腩');
INSERT INTO `cuisine` VALUES (128, 6, 6, '红烧', 1, '/static/logo.png', '啤酒烧鸭腿');
INSERT INTO `cuisine` VALUES (129, 6, 4.5, '蒸菜', 1, '/static/logo.png', '豆豉蒸排骨');
INSERT INTO `cuisine` VALUES (130, 6, 5, '蒸菜', 1, '/static/logo.png', '黄豆酱蒸鱼');
INSERT INTO `cuisine` VALUES (131, 6, 4, '蒸菜', 1, '/static/logo.png', '粉蒸肉');
INSERT INTO `cuisine` VALUES (132, 6, 4, '蒸菜', 1, '/static/logo.png', '蒜蓉蒸鲍鱼');
INSERT INTO `cuisine` VALUES (133, 6, 3, '凉菜', 1, '/static/logo.png', '凉拌藕片');
INSERT INTO `cuisine` VALUES (134, 6, 3, '凉菜', 1, '/static/logo.png', '拍黄瓜');
INSERT INTO `cuisine` VALUES (135, 6, 3, '凉菜', 1, '/static/logo.png', '凉拌茄子');
INSERT INTO `cuisine` VALUES (136, 6, 3, '凉菜', 1, '/static/logo.png', '京酱肉丝');
INSERT INTO `cuisine` VALUES (137, 6, 6, '汤', 1, '/static/logo.png', '鲫鱼豆腐汤');
INSERT INTO `cuisine` VALUES (138, 6, 4, '汤', 1, '/static/logo.png', '豆腐蛤蜊汤');
INSERT INTO `cuisine` VALUES (139, 6, 4, '汤', 1, '/static/logo.png', '黄豆猪脚汤');
INSERT INTO `cuisine` VALUES (140, 6, 5, '汤', 1, '/static/logo.png', '老鸭汤');
INSERT INTO `cuisine` VALUES (141, 6, 6, '小炒', 1, '/static/logo.png', '清炒虾仁');
INSERT INTO `cuisine` VALUES (142, 6, 4, '红烧', 1, '/static/logo.png', '红烧鸡翅');
INSERT INTO `cuisine` VALUES (143, 6, 2, '蒸菜', 1, '/static/logo.png', '蒸蛋');
INSERT INTO `cuisine` VALUES (144, 6, 6, '汤', 1, '/static/logo.png', '猴头菇骨头汤');
INSERT INTO `cuisine` VALUES (145, 7, 3, '小炒', 1, '/static/logo.png', '西红柿炒蛋');
INSERT INTO `cuisine` VALUES (146, 7, 1.5, '小炒', 1, '/static/logo.png', '炒土豆丝');
INSERT INTO `cuisine` VALUES (147, 7, 4.5, '小炒', 1, '/static/logo.png', '青椒肉丝');
INSERT INTO `cuisine` VALUES (148, 7, 1.5, '小炒', 1, '/static/logo.png', '醋溜白菜');
INSERT INTO `cuisine` VALUES (149, 7, 3, '红烧', 1, '/static/logo.png', '红烧肉');
INSERT INTO `cuisine` VALUES (150, 7, 2, '红烧', 1, '/static/logo.png', '麻婆豆腐');
INSERT INTO `cuisine` VALUES (151, 7, 6, '红烧', 1, '/static/logo.png', '番茄土豆烧牛腩');
INSERT INTO `cuisine` VALUES (152, 7, 6, '红烧', 1, '/static/logo.png', '啤酒烧鸭腿');
INSERT INTO `cuisine` VALUES (153, 7, 4.5, '蒸菜', 1, '/static/logo.png', '豆豉蒸排骨');
INSERT INTO `cuisine` VALUES (154, 7, 5, '蒸菜', 1, '/static/logo.png', '黄豆酱蒸鱼');
INSERT INTO `cuisine` VALUES (155, 7, 4, '蒸菜', 1, '/static/logo.png', '粉蒸肉');
INSERT INTO `cuisine` VALUES (156, 7, 4, '蒸菜', 1, '/static/logo.png', '蒜蓉蒸鲍鱼');
INSERT INTO `cuisine` VALUES (157, 7, 3, '凉菜', 1, '/static/logo.png', '凉拌藕片');
INSERT INTO `cuisine` VALUES (158, 7, 3, '凉菜', 1, '/static/logo.png', '拍黄瓜');
INSERT INTO `cuisine` VALUES (159, 7, 3, '凉菜', 1, '/static/logo.png', '凉拌茄子');
INSERT INTO `cuisine` VALUES (160, 7, 3, '凉菜', 1, '/static/logo.png', '京酱肉丝');
INSERT INTO `cuisine` VALUES (161, 7, 6, '汤', 1, '/static/logo.png', '鲫鱼豆腐汤');
INSERT INTO `cuisine` VALUES (162, 7, 4, '汤', 1, '/static/logo.png', '豆腐蛤蜊汤');
INSERT INTO `cuisine` VALUES (163, 7, 4, '汤', 1, '/static/logo.png', '黄豆猪脚汤');
INSERT INTO `cuisine` VALUES (164, 7, 5, '汤', 1, '/static/logo.png', '老鸭汤');
INSERT INTO `cuisine` VALUES (165, 7, 6, '小炒', 1, '/static/logo.png', '清炒虾仁');
INSERT INTO `cuisine` VALUES (166, 7, 4, '红烧', 1, '/static/logo.png', '红烧鸡翅');
INSERT INTO `cuisine` VALUES (167, 7, 2, '蒸菜', 1, '/static/logo.png', '蒸蛋');
INSERT INTO `cuisine` VALUES (168, 7, 6, '汤', 1, '/static/logo.png', '猴头菇骨头汤');
INSERT INTO `cuisine` VALUES (169, 1, 8, '炖菜', 1, '/static/logo.png', '小鸡炖蘑菇');
INSERT INTO `cuisine` VALUES (170, 1, 3, '好吃的', 1, '/static/logo.png', '好吃的菜');
INSERT INTO `cuisine` VALUES (171, 2, 5, '凉菜', 1, '/static/logo.png', '凉拌皮蛋');
INSERT INTO `cuisine` VALUES (172, 2, 7, '红烧', 1, '/static/logo.png', '红烧猪蹄');
INSERT INTO `cuisine` VALUES (173, 9, 1, '12', 1, '/static/logo.png', '12-23');

-- ----------------------------
-- Table structure for tco
-- ----------------------------
DROP TABLE IF EXISTS `tco`;
CREATE TABLE `tco`  (
  `co_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int(0) UNSIGNED NOT NULL,
  `cuisine_id` int(0) UNSIGNED NOT NULL,
  `quantity` int(0) UNSIGNED NULL DEFAULT 1,
  `cuisine_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`co_id`) USING BTREE,
  INDEX `fk_tco_torder_on_orderid`(`order_id`) USING BTREE,
  INDEX `fk_tco_cuisine_on_cuisineid`(`cuisine_id`) USING BTREE,
  CONSTRAINT `fk_tco_cuisine_on_cuisineid` FOREIGN KEY (`cuisine_id`) REFERENCES `cuisine` (`cuisine_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_tco_torder_on_orderid` FOREIGN KEY (`order_id`) REFERENCES `torder` (`order_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tco
-- ----------------------------
INSERT INTO `tco` VALUES (15, 8, 85, 4, '凉拌藕片');
INSERT INTO `tco` VALUES (16, 8, 86, 3, '拍黄瓜');
INSERT INTO `tco` VALUES (17, 8, 88, 4, '京酱肉丝');
INSERT INTO `tco` VALUES (18, 8, 87, 3, '凉拌茄子');
INSERT INTO `tco` VALUES (19, 9, 85, 1, '凉拌藕片');
INSERT INTO `tco` VALUES (20, 9, 86, 3, '拍黄瓜');
INSERT INTO `tco` VALUES (21, 9, 88, 3, '京酱肉丝');
INSERT INTO `tco` VALUES (22, 9, 87, 2, '凉拌茄子');
INSERT INTO `tco` VALUES (23, 10, 73, 4, '西红柿炒蛋');
INSERT INTO `tco` VALUES (24, 10, 74, 3, '炒土豆丝');
INSERT INTO `tco` VALUES (25, 10, 75, 6, '青椒肉丝');
INSERT INTO `tco` VALUES (26, 11, 85, 2, '凉拌藕片');
INSERT INTO `tco` VALUES (27, 11, 86, 2, '拍黄瓜');
INSERT INTO `tco` VALUES (28, 11, 88, 1, '京酱肉丝');
INSERT INTO `tco` VALUES (29, 11, 83, 1, '粉蒸肉');
INSERT INTO `tco` VALUES (30, 13, 37, 3, '凉拌藕片');
INSERT INTO `tco` VALUES (31, 13, 39, 3, '凉拌茄子');
INSERT INTO `tco` VALUES (32, 14, 133, 2, '凉拌藕片');
INSERT INTO `tco` VALUES (33, 14, 135, 2, '凉拌茄子');
INSERT INTO `tco` VALUES (34, 16, 133, 2, '凉拌藕片');
INSERT INTO `tco` VALUES (35, 16, 134, 2, '拍黄瓜');
INSERT INTO `tco` VALUES (36, 17, 86, 1, '拍黄瓜');
INSERT INTO `tco` VALUES (37, 17, 90, 1, '豆腐蛤蜊汤');
INSERT INTO `tco` VALUES (38, 17, 83, 1, '粉蒸肉');
INSERT INTO `tco` VALUES (39, 18, 173, 3, '12-23');
INSERT INTO `tco` VALUES (40, 19, 85, 1, '凉拌藕片');
INSERT INTO `tco` VALUES (41, 19, 86, 2, '拍黄瓜');
INSERT INTO `tco` VALUES (42, 19, 87, 2, '凉拌茄子');
INSERT INTO `tco` VALUES (43, 20, 14, 2, '拍黄瓜');

-- ----------------------------
-- Table structure for torder
-- ----------------------------
DROP TABLE IF EXISTS `torder`;
CREATE TABLE `torder`  (
  `order_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_price` double NULL DEFAULT 0,
  `order_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` int(0) UNSIGNED NOT NULL,
  `canteen_id` int(0) UNSIGNED NOT NULL,
  `order_check` int(0) NULL DEFAULT NULL,
  `address_id` int(0) NOT NULL,
  `order_status` enum('false','true') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'false',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `fk_torder_canteen_on_canteenid`(`canteen_id`) USING BTREE,
  INDEX `fk_torder_user_on_userid`(`user_id`) USING BTREE,
  CONSTRAINT `fk_torder_canteen_on_canteenid` FOREIGN KEY (`canteen_id`) REFERENCES `canteen` (`canteen_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_torder_user_on_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of torder
-- ----------------------------
INSERT INTO `torder` VALUES (8, 42, '2022/11/20 19:06', 1, 4, 9769, 1, 'false');
INSERT INTO `torder` VALUES (9, 27, '2022/11/20 19:08', 1, 4, 9334, 1, 'false');
INSERT INTO `torder` VALUES (10, 43.5, '2022/11/21 10:34', 1, 4, 1986, 8, 'false');
INSERT INTO `torder` VALUES (11, 19, '2022/11/23 19:57', 1, 4, 4298, 1, 'false');
INSERT INTO `torder` VALUES (12, 12, '2022/11/29 10:46', 1, 4, 3223, 1, 'false');
INSERT INTO `torder` VALUES (13, 18, '2022/12/1 8:37', 1, 2, 9223, 3, 'false');
INSERT INTO `torder` VALUES (14, 12, '2022/12/1 8:41', 1, 2, 4048, 3, 'true');
INSERT INTO `torder` VALUES (16, 12, '2022-12-03 22:59:17', 1, 6, 4259, 1, 'false');
INSERT INTO `torder` VALUES (17, 11, '2022-12-23 20:16:38', 2, 4, 3299, 9, 'false');
INSERT INTO `torder` VALUES (18, 3, '2022-12-23 20:23:26', 2, 9, 5220, 9, 'true');
INSERT INTO `torder` VALUES (19, 15, '2022-12-25 14:42:49', 2, 4, 5762, 9, 'false');
INSERT INTO `torder` VALUES (20, 6, '2023-04-21 17:19:29', 1, 1, 4132, 1, 'false');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '姓名未定义',
  `balance` double NULL DEFAULT 0,
  `student_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '学号未定义',
  `pay_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'root', '123', '张三', 494, 'swe001', '888888');
INSERT INTO `user` VALUES (2, 'zn', '123', '张楠', 92, 'mda002', NULL);
INSERT INTO `user` VALUES (3, '555', '555', NULL, 0, NULL, NULL);
INSERT INTO `user` VALUES (4, '123', '123', NULL, 0, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
