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
NSString *const LOGIN_INTERFACE                 =       @"http://www.haoyuanqu.com/app/appInterface!Login.action";
// * 验证码 *
NSString *const SEND_VER_INTERFACE              =       @"http://www.haoyuanqu.com/app/appInterface!yzm.action";
// * 注册 *
NSString *const REGIST_INTERFACE                =       @"http://www.haoyuanqu.com/app/appInterface!register.action";
// * 找回密码验证码*
NSString *const REST_VER_INTERFACE              =       @"http://www.haoyuanqu.com/app/appInterface!yzmGetBack.action";
// * 找回密码 *
NSString *const RESET_INTERFACE                 =       @"http://www.haoyuanqu.com/app/appInterface!retrievePwd.action";
// *修改密码*
NSString *const REPLACE_PSW_INTERFACE           =       @"http://www.haoyuanqu.com/app/appInterface!updatePwd.action";
// *修改头像*
NSString *const REPLACE_AVATAR_INTERFACE        =       @"http://www.haoyuanqu.com/WebUploader.html";
// *修改头像后上传uid*
NSString *const REPLACE_UID_INTERFACE           =       @"http://www.haoyuanqu.com/app/appInterface!upload.action";
// *修改昵称*
NSString *const REPLACE_NAME_INTERFACE          =       @"http://www.haoyuanqu.com/app/appInterface!updateName.action";
// *获取二维码图*
NSString *const GET_QRURL_INTERFACE             =       @"http://www.haoyuanqu.com/r/";
//* 启动banner*
NSString *const LAUNCH_ADVERTISE_INTERFACE         =       @"http://www.haoyuanqu.com/app/appInterfaceProject!homePhotoIOS.action";
//--------------------
// * 首页 *
NSString *const MAIN_INTERFACE                  =       @"http://www.haoyuanqu.com/app/appInterface!index.action";
//--------------------
// * 资讯类别*
NSString *const INFORMATION_TITLE_INTERFACE     =       @"http://www.haoyuanqu.com/app/appInterface!newType.action";
// * 咨询详情 *
NSString *const INFORMATION_DETAIL_INTERFACE    =       @"http://www.haoyuanqu.com/app/appInterface!news.action";


//--------------------
//产品服务类别
NSString *const PRODUCT_TITLE_INTERFACE         =       @"http://www.haoyuanqu.com/app/appInterface!proType.action";
//产品服务类别下的产品
NSString *const PRODUCT_LIST_INTERFACE          =       @"http://www.haoyuanqu.com/app/appInterface!products.action";
//产品服务详情页
NSString *const PRODUCT_DETAIL_INTERFACE        =       @"http://www.haoyuanqu.com/web/weixinpay2/product!view.action?id=";
//产品信息详情页
NSString *const SERVICE_INFO_INTERFACE          =       @"http://www.haoyuanqu.com/app/appInterface!productDetail.action";
//收藏操作
NSString *const COLLECT_OPERATION_INTERFACE     =       @"http://www.haoyuanqu.com/app/appInterface!isCollection.action";


//-----------------------
//我的订单
NSString *const MY_ORDER_INTERFACE              =       @"http://www.haoyuanqu.com/app/appInterfaceUser!myOrders.action";
//订单评价
NSString *const ORDER_EVALUATE_INTERFACE        =       @"http://www.haoyuanqu.com/app/appInterfaceUser!saveEvaluate.action";
//订单删除
NSString *const ORDER_DELETE_INTERFACE          =       @"http://www.haoyuanqu.com/app/appInterfaceUser!delOrder.action";
//我的优惠券
NSString *const MY_DISCOUNT_INTERFACE           =       @"http://www.haoyuanqu.com/app/appInterfaceUser!myCoupons.action";
//我的提成（收益记录 和 交易记录）
NSString *const MY_TRADE_INTERFACE              =       @"http://www.haoyuanqu.com/app/appInterfaceUser!myDeduct.action";
//我的提成（我的推广）
NSString *const MY_EXTEND_INTERFACE             =       @"http://www.haoyuanqu.com/app/appInterfaceUser!myPromotion.action";
//我的提成（转入余额）
NSString *const MY_WITHDRAW_INTERFACE           =       @"http://www.haoyuanqu.com/app/appInterfaceUser!zhuanRu.action";
//我的收藏
NSString *const MY_COLLECT_INTERFACE            =       @"http://www.haoyuanqu.com/app/appInterfaceUser!myFavorites.action";
//我的收藏夹删除
NSString *const MY_COLLECT_DELETE_INTERFACE     =       @"http://www.haoyuanqu.com/app/appInterfaceUser!delFavorite.action";
//我的积分
NSString *const MY_SIGN_IN_INTERFACE            =       @"http://www.haoyuanqu.com/app/appInterfaceUser!myPoints.action";

//----------------------------
//地址管理
NSString *const MY_ADDRESS_INTERFACE            =       @"http://www.haoyuanqu.com/app/appInterfaceUser!addressManage.action";
//地址修改
NSString *const ADDRESS_MODIFI_INTERFACE        =       @"http://www.haoyuanqu.com/app/appInterfaceUser!saveAddress.action";
//地址删除
NSString *const ADDRESS_DELETE_INTERFACE        =       @"http://www.haoyuanqu.com/app/appInterfaceUser!delAddress.action";

//-----------------------------
//优创计划
NSString *const EXCELLENT_PLAN_INTERFACE        =       @"http://www.haoyuanqu.com/m/plan/planlist/YCJH2?biaoshi=iOS";
//优创金融方案
NSString *const EXCELLENT_FINANTIAL_INTERFACE   =       @"http://www.haoyuanqu.com/m/plan/planlist/YCJRFA?biaoshi=iOS";
//优创基地
NSString *const EXCELLENT_BASE_INTERFACE        =       @"http://www.haoyuanqu.com/m/plan/planlist/YCJD?biaoshi=iOS";
//优创训练营
NSString *const EXCELLENT_CAMP_INTERFACE        =       @"http://www.haoyuanqu.com/m/plan/planlist/YCXLY?biaoshi=iOS";
//优创开放日
NSString *const EXCELLENT_OPEN_INTERFACE        =       @"http://www.haoyuanqu.com/m/plan/planlist/YCKFR?biaoshi=iOS";

//-----------------------------
//立即购买
NSString *const GET_PAYORDER_INTERFACE          =       @"http://www.haoyuanqu.com/app/appInterface!buy.action";
//订单金额为0接口
NSString *const PAYORDER_FREE_INTERFACE         =       @"http://www.haoyuanqu.com/app/appInterface!buynoAlipay.action";
//支付宝回调
NSString *const ALIPAY_CALLBACK_INTERFACE       =       @"http://www.haoyuanqu.com/app/appInterface!paySuccess.action";
//订单详情
NSString *const ORDER_DETAIL_INTERFACE          =       @"http://www.haoyuanqu.com/app/appInterfaceUser!orderDetail.action";

//------------------------------
//子订单评论
NSString *const SUBORDER_COMMENT_INTERFACE      =       @"http://www.haoyuanqu.com/app/appInterfaceUser!orderDetailEvaluate.action";
//查看子订单评论
NSString *const SUBORDER_CHECK_INTERFACE        =       @"http://www.haoyuanqu.com/app/appInterfaceUser!orderDetailviewEvaluate.action";
//申请退款
NSString *const REFUND_SAVE_INTERFACE           =       @"http://www.haoyuanqu.com/app/appInterfaceUser!saveTuikuan.action";
//退款进度
NSString *const REFUND_PROGRESS_INTERFACE       =       @"http://www.haoyuanqu.com/app/appInterfaceUser!tuikuanDetail.action";
//取消退款
NSString *const CANCEL_REFUND_INTERFACE         =       @"http://www.haoyuanqu.com/app/appInterfaceUser!updateTuikuan.action";
@end