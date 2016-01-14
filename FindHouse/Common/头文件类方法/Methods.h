//
//  Methods.h
//  ServicingOfCar
//
//  Created by zmx on 15/4/28.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MBProgressHUD.h"       //菊花
#import "AppDelegate.h"


@interface Methods : NSObject

//获取 window
+ (UIWindow *)window;
//获取 AppDelegate
+ (AppDelegate *)appDelegate;

//判断手机格式是否正确
+ (BOOL)CheckPhoneNumInput:(NSString *)phone;
//判断邮箱格式是否正确
+ (BOOL)isValidateEmail:(NSString *)email;
#pragma mark ---------------------------------------------- 验证码计时器
+ (void)startCodeTime:(NSInteger)time sendAuthCodeBtn:(UIButton *)sendAuthCodeBtn;

//延迟执行
+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;

//在主线程（延迟）执行
+ (void)updateOnMainThread:(void(^)())mainBlock;
+ (void)updateOnMainThread:(void(^)())mainBlock afterDelay:(NSTimeInterval)delay;

//添加缩放动画效果
+ (void)scaleAnimationFromScale:(float)scale1
                        toScale:(float)scale2
                   autoreverses:(BOOL)autoreverses
                    repeatCount:(int)repeatCount
                       duration:(float)duration
                        forView:(UIView *)aView
                    removeDelay:(float)delay;

//文字指示器 - 默认1.5秒自动消失
+ (void)showAlertWithText:(NSString *)text;

//登录
//+ (void)loginAtVC:(BaseVC *)vc callback:(void(^)(void))callback;
//+ (void)doSthAtVC:(BaseVC *)vc afterLogin:(void(^)(void))loginCallback;

//设置tableView header的高度
+ (void)setHeaderHeight:(float)height forTableView:(UITableView *)tableView;
//设置tableView footer的高度 及 scroll滚动条的bottom edgeInset
+ (void)setFooterHeight:(float)height forTableView:(UITableView *)tableView adjustScrollIndicatorInsets:(BOOL)flag;

+ (CGFloat)textHeight:(NSString *)str andW:(CGFloat)width andTextFont:(CGFloat)textFont;

//字典 ----> 字符串
+ (NSString *)jsonStrWithDic:(NSDictionary*)dic;
//json字符串 ----> 字典 / 数组
+ (id)jsonObjectFromJsonStr:(NSString *)jsonStr;


#pragma -mark showMBProgress
+(void)showMBProgress:(NSString*)str withView:(UIView*)view;
+(void)dismissMBProgressWithView:(UIView*)view;

@end
