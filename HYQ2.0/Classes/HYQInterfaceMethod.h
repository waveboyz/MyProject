//
//  HYQInterfaceMethod.h
//  HYQ2.0
//
//  Created by waveboyz on 15/8/21.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
    接口路径
 */
@interface HYQInterfaceMethod : NSObject
// * 登录 *
extern NSString *const LOGIN_INTERFACE;
// * 验证码 *
extern NSString *const SEND_VER_INTERFACE;
// * 注册 *
extern NSString *const REGIST_INTERFACE;
// * 找回密码验证码*
extern NSString *const REST_VER_INTERFACE;
// * 找回密码*
extern NSString *const RESET_INTERFACE;
// *修改密码*
extern NSString *const REPLACE_PSW_INTERFACE;
// *修改头像*
extern NSString *const REPLACE_AVATAR_INTERFACE;
// *修改头像后上传uid*
extern NSString *const REPLACE_UID_INTERFACE;
// *修改昵称*
extern NSString *const REPLACE_NAME_INTERFACE;
// *获取二维码图*
extern NSString *const GET_QRURL_INTERFACE;
//* 启动广告*
extern NSString *const LAUNCH_ADVERTISE_INTERFACE;
//---------------------------------
// * 首页 *
extern NSString *const MAIN_INTERFACE;
//---------------------------------
// * 资讯类别*
extern NSString *const INFORMATION_TITLE_INTERFACE;
// * 咨询详情*
extern NSString *const INFORMATION_DETAIL_INTERFACE;
//产品服务类别
extern NSString *const PRODUCT_TITLE_INTERFACE;
//产品服务类别下的产品
extern NSString *const PRODUCT_LIST_INTERFACE;
//产品服务详情页
extern NSString *const PRODUCT_DETAIL_INTERFACE;
//产品信息详情页
extern NSString *const SERVICE_INFO_INTERFACE;
//是否收藏
extern NSString *const COLLECT_OPERATION_INTERFACE;

//-------------------------------------
//我的订单
extern NSString *const MY_ORDER_INTERFACE;
//订单评价
extern NSString *const ORDER_EVALUATE_INTERFACE;
//订单删除
extern NSString *const ORDER_DELETE_INTERFACE;
//我的优惠券
extern NSString *const MY_DISCOUNT_INTERFACE;
//我的提成（收益记录 和 交易记录）
extern NSString *const MY_TRADE_INTERFACE;
//我的提成（我的推广）
extern NSString *const MY_EXTEND_INTERFACE;
//我的提成(转入余额)
extern NSString *const MY_WITHDRAW_INTERFACE;
//我的收藏
extern NSString *const MY_COLLECT_INTERFACE;
//我的收藏夹（删除）
extern NSString *const MY_COLLECT_DELETE_INTERFACE;
//我的积分
extern NSString *const MY_SIGN_IN_INTERFACE;
//--------------------------------------
//地址管理
extern NSString *const MY_ADDRESS_INTERFACE;
//地址修改
extern NSString *const ADDRESS_MODIFI_INTERFACE;
//地址删除
extern NSString *const ADDRESS_DELETE_INTERFACE;

//------------------------------------
//优创计划
extern NSString *const EXCELLENT_PLAN_INTERFACE;
//优创金融方案
extern NSString *const EXCELLENT_FINANTIAL_INTERFACE;
//优创基地
extern NSString *const EXCELLENT_BASE_INTERFACE;
//优创训练营
extern NSString *const EXCELLENT_CAMP_INTERFACE;
//优创开放日
extern NSString *const EXCELLENT_OPEN_INTERFACE;

//------------------------------------
//立即购买
extern NSString *const GET_PAYORDER_INTERFACE;
//订单金额为0接口
extern NSString *const PAYORDER_FREE_INTERFACE;
//支付宝回调
extern NSString *const ALIPAY_CALLBACK_INTERFACE;
//提现接口
extern NSString *const  BANK_WITHDRAW_INTERFACE;
//订单详情
extern NSString *const ORDER_DETAIL_INTERFACE;

//-----------------------------------
//子订单评论
extern NSString *const SUBORDER_COMMENT_INTERFACE;
//查看子订单评论
extern NSString *const SUBORDER_CHECK_INTERFACE;
//申请退款
extern NSString *const REFUND_SAVE_INTERFACE;
//退款进度
extern NSString *const REFUND_PROGRESS_INTERFACE;
//取消退款
extern NSString *const CANCEL_REFUND_INTERFACE;

@end