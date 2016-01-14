//
//  URL.h
//  kang
//
//  Created by WSGG on 15/11/16.
//  Copyright © 2015年 XJY. All rights reserved.
//

#ifndef URL_h
#define URL_h

#define URLPrefix @"http://10.0.0.177:8888/kangzhanggui/" //URL前缀
#define ImagePrefixURL @"http://10.0.0.177:8888/kangzhanggui/upload/" //图片前缀

//#define URLPrefix @"http://imocoo.cn:8080/kangzhanggui/" //URL前缀
//#define ImagePrefixURL @"http://imocoo.cn:8080/kangzhanggui/upload/" //图片前缀


//注册和登录接口----------111111111111111111
#define GetCodeURL @"mobile/get_pcode"  //登录
#define RegusterUserURL @"mobile/reg_user"  //注册用户
#define IsRegusterThisUserURL @"mobile/unique_uname"  //用户是否已经存在
#define LoginUserURL @"mobile/user_login"  //用户登入
#define LoginOutUserURL @"mobile/user_logout"  //用户登出
#define CheckCodeURL @"mobile/check_pcode"  //校验验证码
#define ResetPwdURL @"mobile/reset_passwd2"  //重置密码



//个人账户信息-------------------222222222222222222222222
#define GetUserInfoURL @"mobile/get_account"  //用户个人信息
#define GetMembersListURL @"mobile/get_members"  //家庭成员列表
#define GetMemberDetailURL @"mobile/get_member"  //家庭成员详细
#define AddMemberURL @"mobile/add_member"  //添加家庭成员
#define ModifyMemberURL @"mobile/modify_member"  //修改家庭成员
#define RemoveMemberURL @"mobile/remove_member"  //删除家庭成员
#define ModifyMemberNickURL @"mobile/modify_account"  //修改昵称


//订单中心信息-------------------3333333333333333333333333333
#define ModifyOrderUserTimeURL @"mobile/modify_order_user_time"  //修改家庭成员体检时间
#define GetAllOrderListURL @"mobile/get_orders"//获取所有订单
#define GetOrderDetailURL @"mobile/get_order"//获取订单详情
#define DeleteOrderURL @"mobile/modify_order"//删除订单


//客户服务信息---收藏、咨询等----------------444444444444444444444444
#define AddCollectURL @"mobile/add_collect"//加入收藏
#define GetCollectsURL @"mobile/get_collects"//获取收藏列表
#define DeleteCollectURL @"mobile/remove_collect"//移除收藏


//医院和套餐接口----------5555555555555555555555555555555
#define GetHospitalListURL @"mobile/get_hospitals"  //医院列表
#define GetHospitalDetailURL @"mobile/get_hospital"  //医院详情
#define GetHospitalMealURL @"mobile/get_hospital_packages"  //医院里的套餐
#define GetHospitalCommentsURL @"mobile/get_hospital_comments"  //医院里的评价


#define GetMealURL @"mobile/get_packages"  //套餐列表
#define GetPackageDetailURL @"mobile/get_package"  //套餐详情
#define GetPackageCommentsURL @"mobile/get_package_comments"  //对套餐的评价



//其他接口----------7777777777777777777777777777777
#define GetRegionsURL @"mobile/get_regions"  //县级分区数
#define GetHospitalGradeURL @"/mobile/get_dicts"  //医院等级数据
#define GetDictsURL @"/mobile/get_dicts"  //获取各种字典数据
#define GetBannerListURL @"mobile/get_carousel"  //获取轮播图片数组
#define GetHealthInfoListURL @"mobile/get_infos"  //获取资讯列表数组
#define GetHealthInfoDetailURL @"mobile/get_info"  //获取资讯详情
#define GetCityListURL @"mobile/get_regions"  //获取城市列表
#define GetMyGPSURL @"mobile/get_my_gps"  //获取我的位置


//购物车接口----------6666666666666666666666
#define AddToCarURL @"mobile/add_item"  //加入购物车
#define CarListURL @"mobile/list_cart"  //购物车列表
#define ClearingCarListURL @"mobile/clearing_cart"  //结算购物车
#define RemoveCarListMealURL @"mobile/remove_item"  //删除购物车套餐
#define LookClearingCarListURL @"mobile/list_clearing"  //查看结算列表
#define AddMemberToOrderURL @"mobile/mod_cart_user"  //添加体检人到订单
#define SubmitOrderURL @"mobile/submit_cart"  //提交订单


#endif /* URL_h */
