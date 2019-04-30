/*
Navicat MySQL Data Transfer

Source Server         : mysql57
Source Server Version : 50724
Source Host           : 127.0.0.1:3306
Source Database       : device_iotp_server_dev

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2019-04-28 11:47:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for device_group
-- ----------------------------
DROP TABLE IF EXISTS `device_group`;
CREATE TABLE `device_group` (
  `dgroup_id` int(11) NOT NULL COMMENT '设备分组id',
  `dgroup_name` varbinary(30) NOT NULL COMMENT '设备分组名，大小限制在4-30',
  `dgroup_parent_id` int(11) DEFAULT NULL COMMENT '该组的父组id',
  `dgroup_disc` varchar(100) DEFAULT NULL COMMENT '该组的描述',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`dgroup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='阿里云iot设备有分组的概念，分组有父组子组的概念';

-- ----------------------------
-- Records of device_group
-- ----------------------------

-- ----------------------------
-- Table structure for dev_module
-- ----------------------------
DROP TABLE IF EXISTS `dev_module`;
CREATE TABLE `dev_module` (
  `module_id` int(11) NOT NULL COMMENT '模组id',
  `module_busi` varchar(32) NOT NULL COMMENT '模组商',
  `module_detail` varchar(32) NOT NULL COMMENT '模组信息',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='设备拓展信息，模组';

-- ----------------------------
-- Records of dev_module
-- ----------------------------

-- ----------------------------
-- Table structure for dev_sdk
-- ----------------------------
DROP TABLE IF EXISTS `dev_sdk`;
CREATE TABLE `dev_sdk` (
  `sdk_id` int(11) NOT NULL COMMENT 'sdk语言id',
  `sdk_name` varchar(10) NOT NULL COMMENT 'sdk_语言',
  `sdk_version` varchar(10) NOT NULL COMMENT 'sdk版本',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`sdk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dev_sdk
-- ----------------------------

-- ----------------------------
-- Table structure for dev_status
-- ----------------------------
DROP TABLE IF EXISTS `dev_status`;
CREATE TABLE `dev_status` (
  `status_id` int(11) NOT NULL COMMENT '设备状态id',
  `status_name` varchar(10) NOT NULL COMMENT '设备状态名',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dev_status
-- ----------------------------

-- ----------------------------
-- Table structure for dis_con_dev_ring
-- ----------------------------
DROP TABLE IF EXISTS `dis_con_dev_ring`;
CREATE TABLE `dis_con_dev_ring` (
  `pk_condr_id` varchar(64) NOT NULL COMMENT '序列号,64位唯一标识符',
  `fk_device_id` varchar(64) DEFAULT NULL COMMENT '设备id, 64位唯一标识',
  `fk_ring_id` varchar(64) DEFAULT NULL COMMENT '铃声id，32位唯一标识',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_condr_id`),
  KEY `idx_fk_dev_drcon_01` (`fk_device_id`) USING BTREE,
  KEY `idx_fk_ring_drcon_01` (`fk_ring_id`) USING BTREE,
  CONSTRAINT `FK_fk_dev_drcon_01` FOREIGN KEY (`fk_device_id`) REFERENCES `dis_device` (`pk_dev_id`),
  CONSTRAINT `FK_fk_ring_drcon_01` FOREIGN KEY (`fk_ring_id`) REFERENCES `dis_ring` (`pk_ring_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dis_con_dev_ring
-- ----------------------------

-- ----------------------------
-- Table structure for dis_con_store_person
-- ----------------------------
DROP TABLE IF EXISTS `dis_con_store_person`;
CREATE TABLE `dis_con_store_person` (
  `pk_consp_id` varchar(64) NOT NULL COMMENT '连接序列号，64位唯一编码',
  `fk_store_id` varchar(64) DEFAULT NULL COMMENT '商店id64位唯一字符',
  `fk_person_id` varchar(64) DEFAULT NULL COMMENT '人员id，64位唯一标识符',
  `gtm_create` datetime NOT NULL COMMENT '创建时间',
  `gtm_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_consp_id`),
  KEY `idx_person_stoper_01` (`fk_person_id`) USING BTREE,
  KEY `idx_store_stoper_01` (`fk_store_id`) USING BTREE,
  CONSTRAINT `FK_person_stoper_01` FOREIGN KEY (`fk_person_id`) REFERENCES `dis_person_info` (`pk_person_id`),
  CONSTRAINT `FK_store_stoper_01` FOREIGN KEY (`fk_store_id`) REFERENCES `dis_store` (`pk_store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dis_con_store_person
-- ----------------------------

-- ----------------------------
-- Table structure for dis_data_format
-- ----------------------------
DROP TABLE IF EXISTS `dis_data_format`;
CREATE TABLE `dis_data_format` (
  `pk_df_id` int(11) NOT NULL COMMENT '数据格式id',
  `uk_df_name` varchar(15) NOT NULL COMMENT '数据格式名',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_df_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据格式，阿里云iot平台定义了两种，一是ICA 标准数据格式 (Alink JSON)，二是自定义数据格式';

-- ----------------------------
-- Records of dis_data_format
-- ----------------------------

-- ----------------------------
-- Table structure for dis_device
-- ----------------------------
DROP TABLE IF EXISTS `dis_device`;
CREATE TABLE `dis_device` (
  `pk_dev_id` varchar(64) NOT NULL COMMENT '设备id, 64位唯一标识',
  `uk_dev_name` varchar(32) NOT NULL COMMENT '设备名支持英文字母、数字和特殊字符-_@.:，长度限制4~32',
  `uh_dev_secret` varchar(16) NOT NULL COMMENT '阿里云生成的16位唯一设备密钥',
  `dev_nickname` varchar(32) NOT NULL COMMENT '备注名称4-32位',
  `uk_dev_ip` varchar(15) DEFAULT NULL COMMENT '设备的ip地址',
  `dev_firmware_version` varchar(32) DEFAULT NULL COMMENT '固件版本',
  `is_ID2` tinyint(4) NOT NULL COMMENT '是否是ID2验证，0：否 1：是',
  `fk_dgroup_id` int(11) DEFAULT NULL COMMENT '设备分组id',
  `fk_sdk_id` int(11) DEFAULT NULL COMMENT 'sdk语言id',
  `fk_module_id` int(11) DEFAULT NULL COMMENT '模组id',
  `fk_status_id` int(11) DEFAULT NULL COMMENT '设备状态id',
  `fk_product_key` varchar(11) DEFAULT NULL COMMENT '阿里云生成的11位的唯一产品号,',
  `fk_store_id` varchar(64) DEFAULT NULL COMMENT '商店id64位唯一字符',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `gmt_last_online` datetime DEFAULT NULL COMMENT '最后上线时间',
  PRIMARY KEY (`pk_dev_id`),
  UNIQUE KEY `idx_device_name` (`uk_dev_name`,`dev_nickname`) USING BTREE,
  KEY `idx_dev_store` (`fk_store_id`) USING BTREE,
  KEY `idx_devg_dev_01` (`fk_dgroup_id`) USING BTREE,
  KEY `idx_devmo_dev_01` (`fk_module_id`) USING BTREE,
  KEY `idx_devsdk_dev_01` (`fk_sdk_id`) USING BTREE,
  KEY `idx_devst_dev_01` (`fk_status_id`) USING BTREE,
  KEY `idx_pd_dev_01` (`fk_product_key`) USING BTREE,
  CONSTRAINT `FK_dev_store` FOREIGN KEY (`fk_store_id`) REFERENCES `dis_store` (`pk_store_id`),
  CONSTRAINT `FK_devg_dev_01` FOREIGN KEY (`fk_dgroup_id`) REFERENCES `device_group` (`dgroup_id`),
  CONSTRAINT `FK_devmo_dev_01` FOREIGN KEY (`fk_module_id`) REFERENCES `dev_module` (`module_id`),
  CONSTRAINT `FK_devsdk_dev_01` FOREIGN KEY (`fk_sdk_id`) REFERENCES `dev_sdk` (`sdk_id`),
  CONSTRAINT `FK_devst_dev_01` FOREIGN KEY (`fk_status_id`) REFERENCES `dev_status` (`status_id`),
  CONSTRAINT `FK_pd_dev_01` FOREIGN KEY (`fk_product_key`) REFERENCES `dis_product` (`pk_product_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dis_device
-- ----------------------------

-- ----------------------------
-- Table structure for dis_devupload_face_info
-- ----------------------------
DROP TABLE IF EXISTS `dis_devupload_face_info`;
CREATE TABLE `dis_devupload_face_info` (
  `pk_duf_curface_id` varchar(64) NOT NULL COMMENT '当前的人脸id',
  `duf_action` varchar(12) NOT NULL COMMENT '动作类型',
  `gmt_upload` datetime NOT NULL COMMENT '上传时间',
  `duf_sex` tinyint(4) NOT NULL COMMENT '性别 0女 1男',
  `duf_age` int(11) NOT NULL COMMENT '年龄 范围0-130',
  `duf_nation` varchar(20) NOT NULL COMMENT '民族',
  `is_hat` tinyint(4) NOT NULL COMMENT '是否佩戴帽子 0佩戴1没有佩戴',
  `is_glass` tinyint(4) NOT NULL COMMENT '是否佩戴眼镜 0佩戴1没有佩戴',
  `is_mask` tinyint(4) NOT NULL COMMENT '是否佩戴口罩0佩戴1没有佩戴',
  `duf_extands` varchar(500) DEFAULT NULL COMMENT '拓展字段',
  `duf_libface_id` varchar(64) DEFAULT NULL COMMENT '本地库人脸id',
  `duf_person_id` varchar(64) DEFAULT NULL COMMENT '本地库人员id',
  `device_id` varchar(64) NOT NULL COMMENT '设备id',
  PRIMARY KEY (`pk_duf_curface_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='设备上传的人脸信息，';

-- ----------------------------
-- Records of dis_devupload_face_info
-- ----------------------------

-- ----------------------------
-- Table structure for dis_instrcb_status
-- ----------------------------
DROP TABLE IF EXISTS `dis_instrcb_status`;
CREATE TABLE `dis_instrcb_status` (
  `pk_instrcb_status_id` int(11) NOT NULL COMMENT '回调状态码id',
  `instrcb_status_detail` varchar(32) NOT NULL COMMENT '状态码类型详情',
  PRIMARY KEY (`pk_instrcb_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='类型有SUCCESS\r\nEXP-DELETEPERSON\r\nEXP-DELETERING\r\n                                       -&#&';

-- ----------------------------
-- Records of dis_instrcb_status
-- ----------------------------

-- ----------------------------
-- Table structure for dis_instruction
-- ----------------------------
DROP TABLE IF EXISTS `dis_instruction`;
CREATE TABLE `dis_instruction` (
  `id` varchar(64) NOT NULL COMMENT '指令id，64位唯一编码',
  `pk_instr_type_id` int(11) DEFAULT NULL COMMENT '指令类型id',
  `pk_dev_id` varchar(64) DEFAULT NULL COMMENT '设备id, 64位唯一标识',
  `data` varchar(500) DEFAULT NULL COMMENT '指令内容，是json格式的数据',
  `gmt_create` datetime NOT NULL COMMENT '下发时间',
  PRIMARY KEY (`id`),
  KEY `idx_dev_instr_01` (`pk_dev_id`) USING BTREE,
  KEY `idx_instr_instrtype_01` (`pk_instr_type_id`) USING BTREE,
  CONSTRAINT `FK_dev_instr_01` FOREIGN KEY (`pk_dev_id`) REFERENCES `dis_device` (`pk_dev_id`),
  CONSTRAINT `FK_instr_instrtype_01` FOREIGN KEY (`pk_instr_type_id`) REFERENCES `dis_instr_type` (`pk_instr_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='云端下发指令的集合，包含一下字段，id，action，下派人id，设备id，data，gmt_create';

-- ----------------------------
-- Records of dis_instruction
-- ----------------------------

-- ----------------------------
-- Table structure for dis_instr_callback_info
-- ----------------------------
DROP TABLE IF EXISTS `dis_instr_callback_info`;
CREATE TABLE `dis_instr_callback_info` (
  `pk_instrcb_id` varchar(64) NOT NULL COMMENT '指令回调信息的id，64位唯一',
  `pk_instrdb_status_id` int(11) DEFAULT NULL COMMENT '回调状态码id',
  `id` varchar(64) DEFAULT NULL COMMENT '指令id，64位唯一编码',
  `instrcb_msg` varchar(500) DEFAULT NULL COMMENT '指令回调的额外信息',
  `gmt_create` datetime NOT NULL COMMENT '回调时间',
  PRIMARY KEY (`pk_instrcb_id`),
  KEY `idx_icbstatus_instrcb_01` (`pk_instrdb_status_id`) USING BTREE,
  KEY `idx_instr_instrcb_01` (`id`) USING BTREE,
  CONSTRAINT `FK_icbstatus_instrcb_01` FOREIGN KEY (`pk_instrdb_status_id`) REFERENCES `dis_instrcb_status` (`pk_instrcb_status_id`),
  CONSTRAINT `FK_instr_instrcb_01` FOREIGN KEY (`id`) REFERENCES `dis_instruction` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指令回调信息';

-- ----------------------------
-- Records of dis_instr_callback_info
-- ----------------------------

-- ----------------------------
-- Table structure for dis_instr_type
-- ----------------------------
DROP TABLE IF EXISTS `dis_instr_type`;
CREATE TABLE `dis_instr_type` (
  `pk_instr_type_id` int(11) NOT NULL COMMENT '指令类型id',
  `instr_type_detail` varchar(32) NOT NULL COMMENT '指令类型详情',
  PRIMARY KEY (`pk_instr_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='指令类型有\r\nAUTO_EXECUTE\r\nCALLBACK_DELETEPERSON\r\nC';

-- ----------------------------
-- Records of dis_instr_type
-- ----------------------------

-- ----------------------------
-- Table structure for dis_network_protocal
-- ----------------------------
DROP TABLE IF EXISTS `dis_network_protocal`;
CREATE TABLE `dis_network_protocal` (
  `pk_np_id` int(11) NOT NULL COMMENT '联网协议id',
  `uk_np_name` varchar(15) NOT NULL COMMENT '联网协议名',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_np_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='联网协议，指设备通过哪种协议连接到iot平台的, 有一下几种 wifi，蜂窝，以太网，LoRaWAN，其他';

-- ----------------------------
-- Records of dis_network_protocal
-- ----------------------------

-- ----------------------------
-- Table structure for dis_node_type
-- ----------------------------
DROP TABLE IF EXISTS `dis_node_type`;
CREATE TABLE `dis_node_type` (
  `pk_nt_id` int(11) NOT NULL COMMENT '节点类型id',
  `uk_nt_name` varchar(10) NOT NULL COMMENT '节点类型名种类名',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_nt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='节点类型，阿里云iot平台定义了两种一个是网关，一个设备';

-- ----------------------------
-- Records of dis_node_type
-- ----------------------------

-- ----------------------------
-- Table structure for dis_person_info
-- ----------------------------
DROP TABLE IF EXISTS `dis_person_info`;
CREATE TABLE `dis_person_info` (
  `pk_person_id` varchar(64) NOT NULL COMMENT '人员id，64位唯一标识符',
  `person_age` int(11) NOT NULL COMMENT '年龄',
  `person_sex` tinyint(4) NOT NULL COMMENT '性别',
  PRIMARY KEY (`pk_person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dis_person_info
-- ----------------------------

-- ----------------------------
-- Table structure for dis_per_face
-- ----------------------------
DROP TABLE IF EXISTS `dis_per_face`;
CREATE TABLE `dis_per_face` (
  `pk_face_id` varchar(64) NOT NULL COMMENT '人脸信息id，64位唯一编号',
  `pk_person_id` varchar(64) DEFAULT NULL COMMENT '人员id，64位唯一标识符',
  `uk_face_url` varchar(200) NOT NULL COMMENT '脸部图片保存地址',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gnt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_face_id`),
  KEY `idx_person_perface_01` (`pk_person_id`) USING BTREE,
  CONSTRAINT `FK_person_perface_01` FOREIGN KEY (`pk_person_id`) REFERENCES `dis_person_info` (`pk_person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of dis_per_face
-- ----------------------------

-- ----------------------------
-- Table structure for dis_product
-- ----------------------------
DROP TABLE IF EXISTS `dis_product`;
CREATE TABLE `dis_product` (
  `pk_product_key` varchar(11) NOT NULL COMMENT '阿里云生成的11位的唯一产品号,',
  `uk_product_secret` varchar(16) NOT NULL COMMENT '阿里云生成的16位的唯一产品编号产品密钥',
  `uk_product_name` varchar(30) NOT NULL COMMENT '产品名, 4-30位，中文算两',
  `fk_pCate_id` int(11) NOT NULL COMMENT '产品种类',
  `fk_nt_id` int(11) NOT NULL COMMENT '节点类型',
  `fk_region_id` int(11) NOT NULL COMMENT '地区',
  `fk_protocal_id` int(11) NOT NULL COMMENT '协议',
  `fk_df_id` int(11) NOT NULL COMMENT '数据格式',
  `fk_np_id` int(11) NOT NULL COMMENT '联网协议',
  `product_disc` varchar(100) DEFAULT NULL COMMENT '产品描述',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_product_key`),
  UNIQUE KEY `idx_product_name` (`uk_product_name`) USING BTREE,
  KEY `idx_df_pd_01` (`fk_df_id`) USING BTREE,
  KEY `idx_np_pd_01` (`fk_np_id`) USING BTREE,
  KEY `idx_nt_pd_01` (`fk_nt_id`) USING BTREE,
  KEY `idx_pdc_pd_01` (`fk_pCate_id`) USING BTREE,
  KEY `idx_pt_pd_01` (`fk_protocal_id`) USING BTREE,
  KEY `idx_rg_pd_01` (`fk_region_id`) USING BTREE,
  CONSTRAINT `FK_df_pd_01` FOREIGN KEY (`fk_df_id`) REFERENCES `dis_data_format` (`pk_df_id`),
  CONSTRAINT `FK_np_pd_01` FOREIGN KEY (`fk_np_id`) REFERENCES `dis_network_protocal` (`pk_np_id`),
  CONSTRAINT `FK_nt_pd_01` FOREIGN KEY (`fk_nt_id`) REFERENCES `dis_node_type` (`pk_nt_id`),
  CONSTRAINT `FK_pdc_pd_01` FOREIGN KEY (`fk_pCate_id`) REFERENCES `dis_product_category` (`pk_pc_id`),
  CONSTRAINT `FK_pt_pd_01` FOREIGN KEY (`fk_protocal_id`) REFERENCES `dis_protocal` (`pk_protocal_id`),
  CONSTRAINT `FK_rg_pd_01` FOREIGN KEY (`fk_region_id`) REFERENCES `dis_region` (`pk_region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='阿里云平台定义的产品';

-- ----------------------------
-- Records of dis_product
-- ----------------------------

-- ----------------------------
-- Table structure for dis_product_category
-- ----------------------------
DROP TABLE IF EXISTS `dis_product_category`;
CREATE TABLE `dis_product_category` (
  `pk_pc_id` int(11) NOT NULL COMMENT '产品种类id',
  `uk_pc_name` varchar(10) NOT NULL COMMENT '产品种类名',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_pc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='产品种类，该应用场景下的种类为网络摄像机，业务简单没有层级关系';

-- ----------------------------
-- Records of dis_product_category
-- ----------------------------

-- ----------------------------
-- Table structure for dis_protocal
-- ----------------------------
DROP TABLE IF EXISTS `dis_protocal`;
CREATE TABLE `dis_protocal` (
  `pk_protocal_id` int(11) NOT NULL COMMENT '协议id',
  `uk_protocal_name` varchar(6) NOT NULL COMMENT '协议名',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_protocal_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='这里的协议主要是阿里云物联网平台和企业服务器对接的协议，有http2和mns';

-- ----------------------------
-- Records of dis_protocal
-- ----------------------------

-- ----------------------------
-- Table structure for dis_region
-- ----------------------------
DROP TABLE IF EXISTS `dis_region`;
CREATE TABLE `dis_region` (
  `pk_region_id` int(11) NOT NULL COMMENT '地区id',
  `uk_region_name` varchar(20) NOT NULL COMMENT '地区名',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='地区是指阿里云平台注册的设备所在的地区，目前大中华地区只有华东-2上海';

-- ----------------------------
-- Records of dis_region
-- ----------------------------

-- ----------------------------
-- Table structure for dis_ring
-- ----------------------------
DROP TABLE IF EXISTS `dis_ring`;
CREATE TABLE `dis_ring` (
  `pk_ring_id` varchar(64) NOT NULL COMMENT '铃声id，32位唯一标识',
  `ring_name` varchar(32) NOT NULL COMMENT '铃声名',
  `uk_ring_url` varchar(64) NOT NULL COMMENT '当前铃声的下载地址',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_ring_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='铃声，是业务场景中很重要的一部分，它在我的应用场景中包含id，url地址，创建时间';

-- ----------------------------
-- Records of dis_ring
-- ----------------------------

-- ----------------------------
-- Table structure for dis_store
-- ----------------------------
DROP TABLE IF EXISTS `dis_store`;
CREATE TABLE `dis_store` (
  `pk_store_id` varchar(64) NOT NULL COMMENT '商店id64位唯一字符',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='门店，这里只需要用到当前门店的id，其他字段不予列出';

-- ----------------------------
-- Records of dis_store
-- ----------------------------

-- ----------------------------
-- Table structure for dis_store_role
-- ----------------------------
DROP TABLE IF EXISTS `dis_store_role`;
CREATE TABLE `dis_store_role` (
  `pk_sr_id` int(11) NOT NULL COMMENT '门店角色id',
  `fk_store_id` varchar(64) DEFAULT NULL COMMENT '商店id64位唯一字符',
  `role_name` varchar(32) NOT NULL COMMENT '角色名',
  `gmt_create` datetime NOT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`pk_sr_id`),
  KEY `idx_store_srole_01` (`fk_store_id`) USING BTREE,
  CONSTRAINT `FK_store_srole_01` FOREIGN KEY (`fk_store_id`) REFERENCES `dis_store` (`pk_store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='有专属于每一个门店的角色分类，比如会员，店员，黑名单等等';

-- ----------------------------
-- Records of dis_store_role
-- ----------------------------
