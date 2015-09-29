//
//  HYQInterfaceMethod.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/21.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQInterfaceMethod.h"

@implementation HYQInterfaceMethod
// * 登录 *
NSString *const LOGIN_INTERFACE                 =       @"http://192.168.1.93:90/app/appInterface!Login.action";
// * 验证码 *
NSString *const SEND_VER_INTERFACE              =       @"http://192.168.1.93:90/app/appInterface!yzm.action";
// * 注册 *
NSString *const REGIST_INTERFACE                =       @"http://192.168.1.93:90/app/appInterface!register.action";
// * 找回密码验证码*
NSString *const REST_VER_INTERFACE              =       @"http://192.168.1.93:90/app/appInterface!yzmGetBack.action";
// * 找回密码 *
NSString *const RESET_INTERFACE                 =       @"http://192.168.1.93:90/app/appInterface!retrievePwd.action";
// *修改密码*
NSString *const REPLACE_PSW_INTERFACE           =       @"http://192.168.1.93:90/app/appInterface!updatePwd.action";
// *修改头像*
NSString *const REPLACE_AVATAR_INTERFACE        =       @"http://192.168.1.93:90/WebUploader.html";
// *修改头像后上传uid*
NSString *const REPLACE_UID_INTERFACE           =       @"http://192.168.1.93:90/app/appInterface!upload.action";
// *修改昵称*
NSString *const REPLACE_NAME_INTERFACE          =       @"http://192.168.1.93:90/app/appInterface!updateName.action";
// *获取二维码图*
NSString *const GET_QRURL_INTERFACE             =       @"http://www.souqian.com/SuccessServlet2?mobile=";
//--------------------
// * 首页 *
NSString *const MAIN_INTERFACE                  =       @"http://192.168.1.93:90/app/appInterface!index.action";
//--------------------
// * 资讯类别*
NSString *const INFORMATION_TITLE_INTERFACE     =       @"http://192.168.1.93:90/app/appInterface!newType.action";
// * 咨询详情 *
NSString *const INFORMATION_DETAIL_INTERFACE    =       @"http://192.168.1.93:90/app/appInterface!news.action";


//--------------------
//产品服务类别
NSString *const PRODUCT_TITLE_INTERFACE         =       @"http://192.168.1.93:90/app/appInterface!proType.action";
//产品服务类别下的产品
NSString *const PRODUCT_LIST_INTERFACE          =       @"http://192.168.1.93:90/app/appInterface!products.action";
//产品服务详情页
NSString *const PRODUCT_DETAIL_INTERFACE        =       @"http://m.haoyuanqu.com/web/weixinpay2/product!view.action?id=";
//产品信息详情页
NSString *const SERVICE_INFO_INTERFACE          =       @"http://192.168.1.93:90/app/appInterface!productDetail.action";
//收藏操作
NSString *const COLLECT_OPERATION_INTERFACE     =       @"http://192.168.1.93:90/app/appInterface!isCollection.action";


//-----------------------
//我的订单
NSString *const MY_ORDER_INTERFACE              =       @"http://192.168.1.93:90/app/appInterfaceUser!myOrders.action";
//订单评价
NSString *const ORDER_EVALUATE_INTERFACE        =       @"http://192.168.1.93:90/app/appInterfaceUser!saveEvaluate.action";
//订单删除
NSString *const ORDER_DELETE_INTERFACE          =       @"http://192.168.1.93:90/app/appInterfaceUser!delOrder.action";
//我的优惠券
NSString *const MY_DISCOUNT_INTERFACE           =       @"http://192.168.1.93:90/app/appInterfaceUser!myCoupons.action";
//我的提成（收益记录 和 交易记录）
NSString *const MY_TRADE_INTERFACE              =       @"http://192.168.1.93:90/app/appInterfaceUser!myDeduct.action";
//我的提成（我的推广）
NSString *const MY_EXTEND_INTERFACE             =       @"http://192.168.1.93:90/app/appInterfaceUser!myPromotion.action";
//我的提成（转入余额）
NSString *const MY_WITHDRAW_INTERFACE           =       @"http://192.168.1.93:90/app/appInterfaceUser!zhuanRu.action";
//我的收藏
NSString *const MY_COLLECT_INTERFACE            =       @"http://192.168.1.93:90/app/appInterfaceUser!myFavorites.action";
//我的收藏夹删除
NSString *const MY_COLLECT_DELETE_INTERFACE     =       @"http://192.168.1.93:90/app/appInterfaceUser!delFavorite.action";


//----------------------------
//地址管理
NSString *const MY_ADDRESS_INTERFACE            =       @"http://192.168.1.93:90/app/appInterfaceUser!addressManage.action";
//地址修改
NSString *const ADDRESS_MODIFI_INTERFACE        =       @"http://192.168.1.93:90/app/appInterfaceUser!saveAddress.action";
//地址删除
NSString *const ADDRESS_DELETE_INTERFACE        =       @"http://192.168.1.93:90/app/appInterfaceUser!delAddress.action";


//-----------------------------
//优创计划
NSString *const EXCELLENT_PLAN_INTERFACE        =       @"http://m.haoyuanqu.com/plan/planlist/YCJH2";
//优创金融方案
NSString *const EXCELLENT_FINANTIAL_INTERFACE   =       @"http://m.haoyuanqu.com/plan/planlist/YCJRFA";
//优创基地
NSString *const EXCELLENT_BASE_INTERFACE        =       @"http://m.haoyuanqu.com/plan/planlist/YCJD";
//优创训练营
NSString *const EXCELLENT_CAMP_INTERFACE        =       @"http://m.haoyuanqu.com/plan/planlist/YCXLY";
//优创开放日
NSString *const EXCELLENT_OPEN_INTERFACE        =       @"http://m.haoyuanqu.com/plan/planlist/YCKFR";

//-----------------------------
//立即购买
NSString *const GET_PAYORDER_INTERFACE          =       @"http://192.168.1.93:90/app/appInterface!buy.action";
//支付宝回调
NSString *const ALIPAY_CALLBACK_INTERFACE       =       @"http://192.168.1.93:90/app/appInterface!paySuccess.action";

@end