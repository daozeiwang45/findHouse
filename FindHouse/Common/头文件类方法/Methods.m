//
//  Methods.m
//  ServicingOfCar
//
//  Created by zmx on 15/4/28.
//  Copyright (c) 2015年 LJH. All rights reserved.
//

#import "Methods.h"
//#import "MBProgressHUD.h"       //菊花

@implementation Methods

+ (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
+ (UIWindow *)window
{
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark ---------------------------------------------- 延迟执行
+ (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}
#pragma mark ---------------------------------------------- 在主线程（延迟）执行 
+ (void)updateOnMainThread:(void(^)())mainBlock
{
    dispatch_async(dispatch_get_main_queue(), mainBlock);
}
+ (void)updateOnMainThread:(void(^)())mainBlock afterDelay:(NSTimeInterval)delay
{
    [Methods performBlock:^{
        [Methods updateOnMainThread:mainBlock];
    } afterDelay:delay];
}

+(void)scaleAnimationFromScale:(float)scale1
                       toScale:(float)scale2
                  autoreverses:(BOOL)autoreverses
                   repeatCount:(int)repeatCount
                      duration:(float)duration
                       forView:(UIView *)aView
                   removeDelay:(float)delay
{
    //缩放
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:scale1];
    scaleAnimation.toValue = [NSNumber numberWithFloat:scale2];
    scaleAnimation.duration = duration;
    scaleAnimation.autoreverses = autoreverses;
    scaleAnimation.repeatCount = repeatCount;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [aView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    [Methods performBlock:^{
        [aView.layer removeAllAnimations];
    } afterDelay:delay];
}
////登录
//+ (void)loginAtVC:(BaseVC *)vc callback:(void(^)(void))callback
//{
//    LoginVC *loginVC = [[LoginVC alloc] init];
//    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    loginVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    loginVC.callback = ^(BOOL isSucceed)
//    {
//        if(isSucceed)//只有登录成功才回调
//        {
//            if(callback)
//            {
//                callback();
//            }
//        }
//    };
//    [vc presentViewController:loginVC animated:YES completion:nil];
//}
//+ (void)doSthAtVC:(BaseVC *)vc afterLogin:(void(^)(void))loginCallback
//{
//    [self loginAtVC:vc callback:^{//执行到此处说明登录成功
//        if(loginCallback)
//        {
//            loginCallback();
//        }
//    }];
//}

+ (void)setHeaderHeight:(float)height forTableView:(UITableView *)tableView
{
    [UIView animateWithDuration:0.2 animations:^{
        //改变footer高度
        UIView *v = tableView.tableHeaderView;
        CGRect frame = v.frame;
        frame.size.height = height;
        v.frame = frame;
        tableView.tableHeaderView = v;
    }];
}
+ (void)setFooterHeight:(float)height forTableView:(UITableView *)tableView adjustScrollIndicatorInsets:(BOOL)flag
{
    [UIView animateWithDuration:0.2 animations:^{
        
        //改变footer高度
        UIView *v = tableView.tableFooterView;
        CGRect frame = v.frame;
        frame.size.height = height;
        v.frame = frame;
        tableView.tableFooterView = v;
        
        //改变
        if(flag)
        {
            UIEdgeInsets scrollIndicatorInsets = tableView.scrollIndicatorInsets;
            scrollIndicatorInsets.bottom = height;
            tableView.scrollIndicatorInsets = scrollIndicatorInsets;
        }
    }];
}

+ (NSString *)jsonStrWithDic:(NSDictionary*)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil)
    {
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    else
    {
        return @"";
    }
}
+ (id)jsonObjectFromJsonStr:(NSString *)jsonStr
{
    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    return jsonData;
}


 
// //
// //  Methods.m
// //  APP
// //
// //  Created by zmx on 14-1-13.
// //  Copyright (c) 2014年 zmx. All rights reserved.
// //
// 
// #import "Methods.h"
// 
// @implementation Methods
// 
// #pragma mark ---------------------------------------------- md5加密
// + (NSString *)md5Digest:(NSString *)digestStr
// {
//	NSString *astr = [NSString stringWithFormat:@"%@",digestStr];
//	const char *cStr = [astr cStringUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
// unsigned char result[CC_MD5_DIGEST_LENGTH];
// CC_MD5( cStr, (unsigned int)strlen(cStr), result );
// NSString *str = [NSString stringWithFormat:
// @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
// result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
// result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
// ];
//	
//	NSString *str2 = [str substringWithRange:NSMakeRange(0, 32)];
// return str2;
// }
 #pragma mark ---------------------------------------------- 判断邮箱格式
 + (BOOL)isValidateEmail:(NSString *)email
 {
 NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
 NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
 return [emailTest evaluateWithObject:email];
 }
 #pragma mark ---------------------------------------------- 判断手机号码
 + (BOOL)CheckPhoneNumInput:(NSString *)phone
 {
 NSString *Regex = @"(13[0-9]|14[57]|15[012356789]|18[012356789])\\d{8}";
 NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
 return [mobileTest evaluateWithObject:phone];
 }
#pragma mark ---------------------------------------------- 验证码计时器
+ (void)startCodeTime:(NSInteger)time sendAuthCodeBtn:(UIButton *)sendAuthCodeBtn
{
    if (time > 59 || time < 1) {
        time = 59;
    }
    __block NSInteger timeout = time; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0) { //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                sendAuthCodeBtn.userInteractionEnabled = YES;
                sendAuthCodeBtn.alpha = 1.0f;
                if (Is_iOS_8)
                {
                    [sendAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                }
                else
                {
                    //设置界面的按钮显示
                    sendAuthCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                    sendAuthCodeBtn.titleLabel.text = @"获取验证码";
                }
                
                //                [sendAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                //                // iOS 7
                //                [sendAuthCodeBtn setTitle:@"获
                sendAuthCodeBtn.enabled = YES;
            });
        } else {
            NSInteger seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%0.2ld", (long)seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (Is_iOS_8)
                {
                    [sendAuthCodeBtn setTitle:[NSString stringWithFormat:@"重发(%@)",strTime] forState:UIControlStateNormal];
                }
                else
                {
                    sendAuthCodeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
                    sendAuthCodeBtn.titleLabel.text = [NSString stringWithFormat:@"重发(%@)",strTime];
                }
                //                [sendAuthCodeBtn setTitle:[NSString stringWithFormat:@"重发(%@)",strTime] forState:UIControlStateNormal];
                //                // iOS 7
                //                [sendAuthCodeBtn setTitle:[NSString stringWithFormat:@"重发(%@)",strTime] forState:UIControlStateDisabled];
                sendAuthCodeBtn.enabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
#pragma mark ---菊花
//+(MBProgressHUD *)juhua:(UIView *)v
//{
//    [Methods appDelegate].HD = [MBProgressHUD showHUDAddedTo:v animated:YES];
//    return [Methods appDelegate].HD;
//}
#pragma mark ---从配置文件中获取数据
//获取性别
+(NSString *)sex
{
    NSString *sexPath = [[NSBundle mainBundle] pathForResource:@"map_sex_type" ofType:@"json"];
    NSString *str = [NSString stringWithContentsOfFile:sexPath encoding:NSUTF8StringEncoding error:nil];
    return str;
//    return [Methods jsonObjectFromJsonStr:str];
}
//获取健身类型
+(NSArray *)fitnessType
{
    NSString *sexPath = [[NSBundle mainBundle] pathForResource:@"map_fitness_type" ofType:@"json"];
    NSString *str = [NSString stringWithContentsOfFile:sexPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *arr = [self jsonObjectFromJsonStr:str];
    return arr;
}

//
// 
// 
// #pragma mark ---------------------------------------------- 活动指示器（ 版本1.0 ）
// +(void)disPlayProgressHUD
// {
// [Methods closeProgressHUD];
// if ([[[UIDevice currentDevice] systemVersion] floatValue]  >= 7.0)
// {
// MRProgressOverlayView *progressView = [MRProgressOverlayView new];
// progressView.titleLabelText=@"请稍等...";
// progressView.titleLabel.textColor=RGB(2, 196,155 , 1);
// progressView.tintColor=RGB(2, 196, 155 , 1);
// [[UIApplication sharedApplication].keyWindow addSubview:progressView];
// [progressView show:YES];
// }
// else
// {
// [[UIApplication sharedApplication].keyWindow addSubview:[ProgressHUD shared]];
// [ProgressHUD show:@"请稍后..."];
// }
// }
// +(void)disPlayProgressHUDWith:(NSString*)str
// {
// [Methods closeProgressHUD];
// if ([[[UIDevice currentDevice] systemVersion] floatValue]  >= 7.0)
// {
// MRProgressOverlayView *progressView = [MRProgressOverlayView showOverlayAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
// progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
// progressView.titleLabelText = str;
// 
// [progressView show:YES];
// }
// else
// {
// [[UIApplication sharedApplication].keyWindow addSubview:[ProgressHUD shared]];
// [ProgressHUD showError:str];
// }
// }
// +(void)disAtmHUDWithStr:(NSString*)str withTime:(int)time
// {
// [Methods closeProgressHUD];
// if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
// {
// MRProgressOverlayView *progressView = [MRProgressOverlayView showOverlayAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
// progressView.mode = MRProgressOverlayViewModeIndeterminateSmall;
// progressView.titleLabelText = str;
// 
// [progressView show:YES];
// 
// [Methods performBlock:^{
// [Methods closeProgressHUD];
// } afterDelay:time];
// }
// else
// {
// [[UIApplication sharedApplication].keyWindow addSubview:[ProgressHUD shared]];
// [ProgressHUD showError:str];
// }
// }
// +(void)closeProgressHUD
// {
// if ([[[UIDevice currentDevice] systemVersion] floatValue]  >= 7.0)
// {
// UIWindow *view = [UIApplication sharedApplication].keyWindow;
// UIView *viewToRemove = nil;
// for (UIView *v in [view subviews])
// {
// if ([v isKindOfClass:[MRProgressOverlayView class]])
// {
// viewToRemove = v;
// }
// }
// if (viewToRemove != nil)
// {
// MRProgressOverlayView *HUD = (MRProgressOverlayView *)viewToRemove;
// 
// [HUD dismiss:YES];
// HUD = nil;
// }
// }
// else
// {
// [ProgressHUD dismiss];
// }
// }
// 
// 
// #pragma mark ---------------------------------------------- 开启、关闭网络请求指示器 ---- 在网络请求中使用
// +(void)showHUD:(BOOL)flag
// {
// [UIApplication sharedApplication].networkActivityIndicatorVisible = flag;
// if(flag)
// {
// [Methods showDefaultHUD];
// }
// }
// + (void)closeHUD:(BOOL)flag
// {
// [UIApplication sharedApplication].networkActivityIndicatorVisible = !flag;
// if(flag)
// {
// [Methods closeDefaultHUD];
// }
// }
// 
// 
// 
// #pragma mark ---------------------------------------------- 提示框 ( UIAlertView )
// +(void)displayDXAlertView:(NSString*)str
// {
// if (IsIOS7)
// {
// [[[UIAlertView alloc]initWithTitle:@"提示"
// message:str
// delegate:nil
// cancelButtonTitle:@"确定"
// otherButtonTitles:nil] show];
// }
// else
// {
// DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示"
// contentText:str
// leftButtonTitle:nil
// rightButtonTitle:@"确定"];
// alert.Type = DXAlertViewTypeForBig;
// [alert show];
// alert.rightBlock = ^()
// {
// 
// };
// }
// }
// #pragma mark ---------------------------------------------- 延迟执行
// + (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay
// {
// dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
// dispatch_after(popTime, dispatch_get_main_queue(), block);
// }
// #pragma mark ---------------------------------------------- 在主线程（延迟）执行
// + (void)uploadOnMainThread:(void(^)())mainBlock
// {
// dispatch_async(dispatch_get_main_queue(), mainBlock);
// }
// + (void)uploadOnMainThread:(void(^)())mainBlock afterDelay:(NSTimeInterval)delay
// {
// [Methods performBlock:^{
// [Methods uploadOnMainThread:mainBlock];
// } afterDelay:delay];
// }
// 
// #pragma mark - GCD 线程异步操作
// + (void)performGCD:(void(^)())newThread completion:(void(^)(BOOL done))completion
// {
// const char *queueName = [[[NSDate date] description] UTF8String];
// dispatch_queue_t myQueue = dispatch_queue_create(queueName, NULL);
// dispatch_queue_t mainQueue = dispatch_get_main_queue();
// 
// dispatch_async(myQueue, ^
// {
// //新线程中要操作的（例如数据库的读取，存储等）
// if(newThread)
// {
// newThread();
// }
// dispatch_async(mainQueue, ^
// {
// //主线程中要操作的（例如UI页面刷新）
// if(completion)
// {
// completion(YES);
// }
// });
// });
// 
// /*
// //测试代码
// [Methods performGCD:^{
// CLog(@"执行操作");
// } completion:^(BOOL done) {
// CLog(@"更新UI");
// }];
// */
//}
//
//
//#pragma mark ---------------------------------------------- 计算文本尺寸（ iOS 6.0 及以前可用 ）
//+(CGFloat)heightForText:(NSString*)text withFont:(int)f withWidth:(float)w
//{
//    UIFont *font = [UIFont systemFontOfSize:f];
//    //指定文本的显示宽度
//    CGSize preSize = CGSizeMake(w,CGFLOAT_MAX);
//    CGRect tmpFrame2 = [text boundingRectWithSize:preSize
//                                          options:NSStringDrawingUsesLineFragmentOrigin
//                                       attributes:@{ NSFontAttributeName : font }
//                                          context:nil];
//    CGSize textSize = tmpFrame2.size;
//    return textSize.height;
//}
//
//#pragma mark ---------------------------------------------- 套餐信息拼接 - 作请求参数
//+(NSString *)appendTaocanStringByUsingArray:(NSMutableArray *)taocanArray
//{
//    NSString *taocanStr = @"";
//    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
//    
//    //去除填写不完整的套餐信息
//    for(YuYueTaoCanModel *model in taocanArray)
//    {
//        if(model.taocanName != nil && model.taocanPrice)
//        {
//            [tempArray addObject:model];
//        }
//    }
//    //将套餐信息拼接成字符串
//    for(int i = 0; i < tempArray.count; i++)
//    {
//        YuYueTaoCanModel *model = tempArray[i];
//        
//        taocanStr = [NSString stringWithFormat:@"%@%d@%@@%f@%@@%@@%@->",
//                     taocanStr,
//                     model.taocanID,
//                     model.taocanName,
//                     model.taocanPrice,
//                     model.taocanExplanation,
//                     model.taocanEffect_start,
//                     model.taocanEffect_end];
//        
//        if(i == tempArray.count - 1)
//        {
//            taocanStr = [taocanStr substringToIndex:taocanStr.length-2];
//        }
//    }
//    CLog(@"套餐信息 - %@",taocanStr);
//    
//    return taocanStr;
//}
//
//+ (BOOL)isNull:(NSString *)str
//{
//    if (str == nil)
//    {
//        return YES;
//    }
//    if (str == NULL)
//    {
//        return YES;
//    }
//    if ([str isKindOfClass:[NSNull class]])
//    {
//        return YES;
//    }
//    //if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
//    //{
//    //    return YES;
//    //}
//    return NO;
//}
//+ (BOOL)isValidString:(NSString *)string
//{
//    if([string isEqualToString:@""] || string == nil || string.length == 0)
//        return NO;
//    return YES;
//}
//
//
//#pragma mark ---------------------------------------------- 用经纬度计算两地距离
////通过2个地点的经纬度计算2地距离
////------返回 - 小数，单位km，如：0.75
//+ (double)distanceByLong1:(NSString *)Long1 lat1:(NSString *)Lat1 long2:(NSString *)Long2 lat2:(NSString *)Lat2
//{
//    double longitude1 = [Long1 doubleValue];
//    double latitude1   = [Lat1 doubleValue];
//    
//    double longitude2 = [Long2 doubleValue];
//    double latitude2   = [Lat2 doubleValue];
//    
//    CLLocation *orig = [[CLLocation alloc] initWithLatitude:latitude1  longitude:longitude1];
//    CLLocation *dist = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
//    
//    CLLocationDistance kilometers = [orig distanceFromLocation:dist]/1000;
//    
//    return kilometers;
//}
////------返回 - 字符串，如：“0.76km”
//+ (NSString *)distanceStrByLong1:(NSString *)Long1 lat1:(NSString *)Lat1 long2:(NSString *)Long2 lat2:(NSString *)Lat2
//{
//    double longitude1 = [Long1 doubleValue];
//    double latitude1   = [Lat1 doubleValue];
//    
//    double longitude2 = [Long2 doubleValue];
//    double latitude2   = [Lat2 doubleValue];
//    
//    CLLocation *orig = [[CLLocation alloc] initWithLatitude:latitude1  longitude:longitude1];
//    CLLocation *dist = [[CLLocation alloc] initWithLatitude:latitude2 longitude:longitude2];
//    
//    CLLocationDistance kilometers = [orig distanceFromLocation:dist]/1000.0;
//    
//    NSString *str = [NSString stringWithFormat:@"%.2lfkm",kilometers];
//    
//    return str;
//}
//
//
//#pragma mark ---------------------------------------------- 地址信息（省份、城市、区域）获取
////从plist文件中读取省份列表
//+ (NSArray *)provinces
//{
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"citydata" ofType:@"plist"];
//    return [[NSArray alloc] initWithContentsOfFile:plistPath];
//}
////反定位，通过经纬度获取城市名
//+(void)cityNameByLongitude:(NSString *)longitude latitude:(NSString *)latitude block:(void (^)(NSString *cityName))block
//{
//    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//    CLLocationDegrees LONGITUDE = [longitude doubleValue];
//    CLLocationDegrees LATITUDE = [latitude doubleValue];
//    CLLocation *location = [[CLLocation alloc] initWithLatitude:LATITUDE longitude:LONGITUDE];
//    
//    //根据经纬度解析成位置
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemark,NSError *error)
//     {
//         if(placemark.count != 0)
//         {
//             CLPlacemark *mark = [placemark objectAtIndex:0];
//             
//             //CLog(@"address - %@",[NSString stringWithFormat:@"%@",mark.locality]);
//             //=========================================================
//             //  mark的属性                         解释
//             //  -------------------------------------------------------
//             //  CLLocation *location              与地标相对应的经纬度坐标
//             //  CLRegion *region                  与地标相对应的地理区域
//             //  NSDictionary *addressDictionary
//             //  name                              位置完整名称
//             //  thoroughfare                      大道
//             //  subThoroughfare                   低一级的街道
//             //  locality
//             //  subLocality
//             //  administrativeArea
//             //  subAdministrativeArea
//             //  postalCode
//             //  ISOcountryCode
//             //  country
//             //  inlandWater
//             //  ocean
//             //  areasOfInterest
//             //==========================================================
//             
//             if(block)
//             {
//                 block(mark.locality);
//             }
//         }
//     }];
//}
//+(NSString *)cityNameByCityID:(NSString *)cityID
//{
//    NSString *cityName = nil;
//    NSArray *provinceList = [Methods provinces];
//    
//    for(NSDictionary *provinceInfo in provinceList)
//    {
//        NSDictionary *cityList = [provinceInfo objectForKey:@"citylist"];
//        for(NSDictionary *cityInfo in cityList)
//        {
//            NSString *cID = [Methods objToStr:[cityInfo objectForKey:@"id"]];
//            if(cID == cityID)
//            {
//                //取出城市名
//                cityName = [cityInfo objectForKey:@"cityName"];
//                break;
//            }
//        }
//    }
//    return cityName;
//}
//
////区域列表（包含区域编码、区域名称）
//+(NSDictionary *)areaListByCityName:(NSString *)cityName
//{
//    NSDictionary *dic = nil;
//    NSArray *provinces = [Methods provinces];
//    
//    for(NSDictionary *province in provinces)
//    {
//        NSArray *cities = [province objectForKey:@"citylist"];
//        for(NSDictionary *city in cities)
//        {
//            NSString *CityName = [city objectForKey:@"cityName"];
//            if([cityName isEqualToString:CityName])
//            {
//                dic = city;
//            }
//        }
//    }
//    return dic;
//}
////区域列表（包含区域编码、区域名称）
//+(NSDictionary *)areaListWithProvinceID:(NSString *)ProID cityID:(NSString *)CityID
//{
//    NSDictionary *dic = nil;
//    NSArray *provinces = [Methods provinces];
//    
//    for(NSDictionary *province in provinces)
//    {
//        NSString *pID = [NSString stringWithFormat:@"%@",[province objectForKey:@"id"]];
//        if([pID isEqualToString:ProID])
//        {
//            dic = province;
//        }
//    }
//    return dic;
//}
//
////地址（格式如：福建-厦门市-思明区）
//+ (NSString *)addressWithProvinceID:(NSString *)pID
//                             cityID:(NSString *)cID
//                             areaID:(NSString *)aID
//{
//    NSString *pName = nil;
//    NSString *cName = nil;
//    NSString *aName = nil;
//    NSString *addressStr = nil;
//    
//    //provinceList包含所有省份信息
//    NSArray *provinceList = [self provinces];
//    
//    for(NSDictionary *provinceInfo in provinceList)
//    {
//        NSString *pid = [provinceInfo objectForKey:@"id"];
//        if([pid isEqualToString:pID])
//        {
//            //取出省份名
//            pName = [provinceInfo objectForKey:@"provinceName"];
//            
//            //cityList包含一个省份的所有城市信息
//            NSDictionary *cityList = [provinceInfo objectForKey:@"citylist"];
//            for(NSDictionary *cityInfo in cityList)
//            {
//                NSString *cid = [cityInfo objectForKey:@"id"];
//                if([cid isEqualToString:cID])
//                {
//                    //取出城市名
//                    cName = [cityInfo objectForKey:@"cityName"];
//                    
//                    //areaList包含一个城市的所有区域信息
//                    NSDictionary *areaList = [cityInfo objectForKey:@"arealist"];
//                    for(NSDictionary *areaInfo in areaList)
//                    {
//                        NSString *aid = [areaInfo objectForKey:@"id"];
//                        if([aid isEqualToString:aID])
//                        {
//                            //取出地名
//                            aName = [areaInfo objectForKey:@"areaName"];
//                            break;
//                        }
//                    }
//                }
//            }
//        }
//    }
//    if((aName != nil) && (cName != nil) && (pName != nil))
//    {
//        addressStr = [NSString stringWithFormat:@"%@-%@-%@",pName,cName,aName];
//    }
//    else
//    {
//        if(pName == nil)
//        {
//            addressStr = @"无地址信息";
//        }
//        else if(cName == nil)
//        {
//            addressStr = [NSString stringWithFormat:@"%@",pName];
//        }
//        else if(aName == nil)
//        {
//            addressStr = [NSString stringWithFormat:@"%@-%@",pName,cName];
//        }
//    }
//    return addressStr;
//}
////地址（格式如：福建-厦门市-思明区）
//+(NSString *)addressStrWithAddressInfo:(NSDictionary *)addressInfo
//{
//    NSString *pID = [addressInfo objectForKey:@"province"];
//    NSString *cID = [addressInfo objectForKey:@"city"];
//    NSString *aID = [addressInfo objectForKey:@"area"];
//    
//    NSString *provinceName = nil;
//    NSString *cityName = nil;
//    NSString *areaName = nil;
//    NSString *addressStr = nil;
//    
//    NSArray *provinceList = [self provinces];
//    
//    for(NSDictionary *provinceInfo in provinceList)
//    {
//        NSString *pid = [provinceInfo objectForKey:@"id"];
//        if([pid isEqualToString:pID])
//        {
//            //取出省份名
//            provinceName = [provinceInfo objectForKey:@"provinceName"];
//            
//            NSDictionary *cityList = [provinceInfo objectForKey:@"citylist"];
//            for(NSDictionary *cityInfo in cityList)
//            {
//                NSString *cid = [cityInfo objectForKey:@"id"];
//                if([cid isEqualToString:cID])
//                {
//                    //取出城市名
//                    cityName = [cityInfo objectForKey:@"cityName"];
//                    
//                    NSDictionary *areaList = [cityInfo objectForKey:@"arealist"];
//                    for(NSDictionary *areaInfo in areaList)
//                    {
//                        NSString *aid = [areaInfo objectForKey:@"id"];
//                        if([aid isEqualToString:aID])
//                        {
//                            //取出地名
//                            areaName = [areaInfo objectForKey:@"areaName"];
//                            break;
//                        }
//                    }
//                }
//            }
//        }
//    }
//    if(areaName != nil && cityName != nil & provinceName != nil)
//    {
//        addressStr = [NSString stringWithFormat:@"%@-%@-%@",provinceName,cityName,areaName];
//    }
//    else
//    {
//        if(provinceName == nil)
//        {
//            addressStr = @"无地址信息";
//        }
//        else if(cityName == nil)
//        {
//            addressStr = [NSString stringWithFormat:@"%@",provinceName];
//        }
//        else if(areaName == nil)
//        {
//            addressStr = [NSString stringWithFormat:@"%@-%@",provinceName,cityName];
//        }
//    }
//    return addressStr;
//}
////返回形如：“福建-厦门市-思明区” 的字符串
//+ (NSString *)addressStrWithAreaID:(NSString *)areaID
//{
//    NSString *addressStr = @"暂无信息";
//    AddressInfo *addInfo = [AddressInfo addressWithAreaID:areaID];
//    if(addInfo)
//    {
//        if(addInfo.proName == nil)
//        {
//            //addressStr = @"暂无信息";
//            return addressStr;
//        }
//        else if(addInfo.proName != nil && addInfo.cityName == nil)
//        {
//            addressStr = addInfo.proName;
//        }
//        else if(addInfo.proName != nil && addInfo.cityName != nil && addInfo.areaID == nil)
//        {
//            addressStr = [NSString stringWithFormat:@"%@-%@",addInfo.proName,addInfo.cityName];
//        }
//        else if(addInfo.proName != nil && addInfo.cityName != nil && addInfo.areaID != nil)
//        {
//            addressStr = [NSString stringWithFormat:@"%@-%@-%@",addInfo.proName,addInfo.cityName,addInfo.areaName];
//        }
//    }
//    return addressStr;
//}
//
//
//
//#pragma mark ---------------------------------------------- appDelegate、window
//+ (AppDelegate *)appDelegate
//{
//    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    
//    return myDelegate;
//}
//+(UIWindow *)window
//{
//    return [UIApplication sharedApplication].keyWindow;
//}
//
//
//#pragma mark ---------------------------------------------- 拼接网络图片url（ url不完整时使用 ）
//+(NSString *)imgURL:(NSString *)sourceStr
//{
//    NSString *tempStr = nil;
//    if([sourceStr hasPrefix:@"http://"])
//    {
//        tempStr = sourceStr;
//    }
//    else
//    {
//        tempStr = [NSString stringWithFormat:@"%@%@",ZmxRootPicPath,sourceStr];
//    }
//    return tempStr;
//}
//
//
//#pragma mark ---------------------------------------------- 整数、小数判断
//+ (BOOL)isPureInt:(NSString *)string
//{
//    NSScanner *scan = [NSScanner scannerWithString:string];
//    int val;
//    return [scan scanInt:&val] && [scan isAtEnd];
//}
//+ (BOOL)isPureFloat:(NSString *)string
//{
//    NSScanner* scan = [NSScanner scannerWithString:string];
//    float val;
//    return [scan scanFloat:&val] && [scan isAtEnd];
//}
//
//
//#pragma mark ----------------------------------------------
//+(NSMutableArray *)imagesWithString:(NSString *)sourceStr
//{
//    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:2];
//    
//    NSDictionary *tmpDic = [Methods jsonDicFromJsonString:sourceStr];
//    for(NSDictionary *dic in tmpDic)
//    {
//        NSString *imgUrl = dic[@"showpic"];
//        [resultArr addObject:imgUrl];
//    }
//    return resultArr;
//}
//
//+ (NSMutableArray *)textContentWithString:(NSString *)sourceStr
//{
//    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
//    
//    NSDictionary *tmpDic = [Methods jsonDicFromJsonString:sourceStr];
//    for(NSDictionary *dic in tmpDic)
//    {
//        NSString *content = dic[@"content"];
//        [array addObject:content];
//    }
//    /*
//     NSString *temp = sourceStr;
//     if([temp rangeOfString:@"\""].location != NSNotFound)
//     {
//     temp = [temp stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//     }
//     
//     CLog(@"%@",temp);
//     temp = [temp substringFromIndex:1];
//     temp = [temp substringToIndex:temp.length-1];
//     
//     CLog(@"%@",temp);
//     
//     NSRange range = [temp rangeOfString:@"},{"];
//     //只有一条信息
//     if(range.location == NSNotFound)
//     {
//     temp = [temp substringFromIndex:1];
//     temp = [temp substringToIndex:temp.length-1];
//     NSArray *arr2 = [temp componentsSeparatedByString:@"content:"];
//     [array addObject:[arr2 objectAtIndex:1]];
//     }
//     //信息不止一条
//     else
//     {
//     NSArray *arr3 = [temp componentsSeparatedByString:@"},{"];
//     for(NSString *str in arr3)
//     {
//     if([str rangeOfString:@"{"].location != NSNotFound)
//     {
//     NSString *str_ = [str stringByReplacingOccurrencesOfString:@"{" withString:@""];
//     NSArray *arr4 = [str_ componentsSeparatedByString:@"content:"];
//     [array addObject:[arr4 objectAtIndex:1]];
//     }
//     else if([str rangeOfString:@"}"].location != NSNotFound)
//     {
//     NSString *str_ = [str stringByReplacingOccurrencesOfString:@"}" withString:@""];
//     NSArray *arr5 = [str_ componentsSeparatedByString:@"content:"];
//     [array addObject:[arr5 objectAtIndex:1]];
//     }
//     else
//     {
//     NSArray *arr5 = [str componentsSeparatedByString:@"content:"];
//     [array addObject:[arr5 objectAtIndex:1]];
//     }
//     }
//     }
//     
//     CLog(@"%@",array);
//     */
//    return array;
//}
//
//
//#pragma mark ---------------------------------------------- 判断是否登录，是执行代码块，否，登录
//+ (void)doSthInController:(UIViewController *)controller callBack:(void(^)(BOOL isLogin))block
//{
//    if([SettingsManager isLoggedIn] == 0)
//    {
//        [Methods gotoLoginPageAtViewController:controller];
//    }
//    else
//    {
//        if(block)  block(YES);
//    }
//}
//#pragma mark ---------------------------------------------- 跳转到登录界面
//+(void)gotoLoginPageAtViewController:(UIViewController *)controller
//{
//    //    //old
//    //    EnterViewController *loginVC = [[EnterViewController alloc] init];
//    //    loginVC.hidesBottomBarWhenPushed = YES;
//    //    [controller.navigationController pushViewController:loginVC animated:YES];
//    
//    //new
//    //    LoginVC *loginVC = [[LoginVC alloc] init];
//    //    loginVC.hidesBottomBarWhenPushed = YES;
//    //    [controller.navigationController pushViewController:loginVC animated:YES];
//    
//    //v2
//    LoginVC_v2 *loginVC = [[LoginVC_v2 alloc] init];
//    loginVC.hidesBottomBarWhenPushed = YES;
//    [controller.navigationController pushViewController:loginVC animated:YES];
//}
//
//#pragma mark ---------------------------------------------- 跳转到顾客、发型师主页（ 模态、非模态视图控制器 ）
//+ (void)gotoGukeHomePageWithGukeID:(NSString *)gukeID headImg:(NSString *)headImg atController:(UIViewController *)controller
//{
//    CusHomePageVC *homePage = [[CusHomePageVC alloc] initWithGukeID:gukeID headImg:headImg];
//    homePage.hidesBottomBarWhenPushed = YES;
//    [controller.navigationController pushViewController:homePage animated:YES];
//}
//+ (void)gotoGukeHomePageWithGukeID:(NSString *)gukeID headImg:(NSString *)headImg atModalController:(UIViewController *)controller
//{
//    CusHomePageVC *homePage = [[CusHomePageVC alloc] initWithGukeID:gukeID headImg:headImg];
//    homePage.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [controller presentViewController:homePage animated:YES completion:nil];
//}
//+ (void)gotoFxsHomePageWithFxsID:(NSString *)fxsID headImg:(NSString *)headimg atController:(UIViewController *)controller
//{
//    FxsHomePageVC *homePage = [[FxsHomePageVC alloc] initWithFxsId:fxsID headImg:headimg];
//    homePage.hidesBottomBarWhenPushed = YES;
//    [controller.navigationController pushViewController:homePage animated:YES];
//}
//+ (void)gotoFxsHomePageWithFxsID:(NSString *)fxsID headImg:(NSString *)headimg atModalController:(UIViewController *)controller
//{
//    FxsHomePageVC *homePage = [[FxsHomePageVC alloc] initWithFxsId:fxsID headImg:nil];
//    homePage.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [controller presentViewController:homePage animated:YES completion:nil];
//}
//
//
//#pragma mark ---------------------------------------------- 播放提示音、音频文件
//+ (void)playSoundWithFileName:(NSString *)fileName
//{
//    static SystemSoundID soundIDTest = 100;
//    //NSString *path1 = [[NSBundle mainBundle] pathForResource:@"bomb" ofType:@"mp3"];
//    NSString *path2 = [NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] resourcePath], [NSString stringWithFormat:@"/%@",fileName]];
//    CLog(@"%@",path2);
//    if(path2)
//    {
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path2 isDirectory:NO],&soundIDTest);
//    }
//    AudioServicesPlaySystemSound(soundIDTest);
//}
//+ (void)playSystemSound:(unsigned int)soundID
//{
//    //登录 1035
//    
//    //手机震动 + 提示音
//    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    //AudioServicesPlaySystemSound(1304);
//    
//    if(soundID == 0)
//    {
//        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//    }
//    else
//    {
//        AudioServicesPlaySystemSound(soundID);
//    }
//}
//
//
//#pragma mark ---------------------------------------------- 礼物动画（ 一 ）
//+ (void)rotationAnimationForView:(UIView *)aView withKey:(NSString *)animationKey
//{
//    //"z"还可以是“x”“y”，表示沿z轴旋转
//    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 3];
//    rotationAnimation.duration = 15.0f;
//    rotationAnimation.autoreverses = NO;
//    //rotationAnimation2.repeatCount = 1;
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //缓入缓出
//    [aView.layer addAnimation:rotationAnimation forKey:animationKey];
//}
//
//+ (void)groupAnimationForView:(UIView *)aView
//                     position:(BOOL)position
//                        scale:(BOOL)scale
//                       bounds:(BOOL)bounds
//                      opacity:(BOOL)opacity
//                     rotation:(BOOL)rotation
//                      withKey:(NSString *)animationkey
//{
//    //位置移动
//    CABasicAnimation *positionAnimation  = [CABasicAnimation animationWithKeyPath:@"position"];
//    positionAnimation.fromValue =  [NSValue valueWithCGPoint: CGPointMake(40, ScreenHeight-35)];
//    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(ScreenWidth/2, ScreenHeight/2-50)];
//    positionAnimation.duration = 2.0;
//    positionAnimation.autoreverses = NO;
//    positionAnimation.repeatCount = 1;
//    
//    //缩放
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//    scaleAnimation.toValue = [NSNumber numberWithFloat:15.0];
//    scaleAnimation.duration = 1.0f;
//    scaleAnimation.autoreverses = YES;
//    scaleAnimation.repeatCount = 1;
//    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    
//    //                        //bound 边界
//    //                        CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
//    //                        boundsAnimation.fromValue = [NSValue valueWithCGRect: targetView.layer.bounds];
//    //                        boundsAnimation.toValue = [NSValue valueWithCGRect:CGRectZero];
//    //                        boundsAnimation.autoreverses = YES;
//    //                        boundsAnimation.duration = 2.0f;
//    
//    //透明度变化
//    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//    opacityAnimation.toValue = [NSNumber numberWithFloat:0.5];
//    opacityAnimation.autoreverses = YES;
//    opacityAnimation.duration = 2.0;
//    
//    //旋转动画
//    CABasicAnimation* rotationAnimation =
//    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
//    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 5];
//    rotationAnimation.duration = 2.0f;
//    rotationAnimation.autoreverses = YES;
//    rotationAnimation.repeatCount = 2;
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //缓入缓出
//    
//    NSMutableArray *animationArray = [NSMutableArray arrayWithCapacity:1];
//    if(position)
//        [animationArray addObject:positionAnimation];
//    if(scale)
//        [animationArray addObject:scaleAnimation];
//    //if(bounds)
//    //    [animationArray addObject:boundsAnimation];
//    if(opacity)
//        [animationArray addObject:opacityAnimation];
//    if(rotation)
//        [animationArray addObject:rotationAnimation];
//    
//    //组合动画
//    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
//    animationGroup.duration = 2.0f;
//    animationGroup.autoreverses = NO;                    //是否重播，原动画的倒播
//    //animationGroup.repeatCount = NSNotFound;//HUGE_VALF;     //HUGE_VALF,源自math.h
//    [animationGroup setAnimations:animationArray];
//    
//    [aView.layer addAnimation:animationGroup forKey:animationkey];
//}
//+(void)scaleAnimationFromScale:(float)scale1
//                       toScale:(float)scale2
//                   repeatCount:(int)repeatCount
//                      duration:(float)duration
//                       forView:(UIView *)aView
//                   removeDelay:(float)delay
//{
//    //缩放
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.fromValue = [NSNumber numberWithFloat:scale1];
//    scaleAnimation.toValue = [NSNumber numberWithFloat:scale2];
//    scaleAnimation.duration = duration;
//    
//    if([aView isKindOfClass:[UITableViewCell class]] ||
//       [aView isKindOfClass:[NSClassFromString(@"TMQuiltViewCell") class]] ||
//       [aView isKindOfClass:[NSClassFromString(@"UiCollectionViewCell") class]] )
//        scaleAnimation.autoreverses = NO;
//    else
//        scaleAnimation.autoreverses = YES;
//    
//    scaleAnimation.repeatCount = repeatCount;
//    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    
//    [aView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//    
//    [Methods performBlock:^{
//        [aView.layer removeAllAnimations];
//    } afterDelay:delay];
//}
//+(void)scaleAnimationFromScale:(float)scale1
//                       toScale:(float)scale2
//                  autoreverses:(BOOL)autoreverses
//                   repeatCount:(int)repeatCount
//                      duration:(float)duration
//                       forView:(UIView *)aView
//                   removeDelay:(float)delay
//{
//    //缩放
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.fromValue = [NSNumber numberWithFloat:scale1];
//    scaleAnimation.toValue = [NSNumber numberWithFloat:scale2];
//    scaleAnimation.duration = duration;
//    scaleAnimation.autoreverses = autoreverses;
//    scaleAnimation.repeatCount = repeatCount;
//    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    
//    [aView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//    
//    [Methods performBlock:^{
//        [aView.layer removeAllAnimations];
//    } afterDelay:delay];
//}
//
//+(void)scaleAnimationFromScale:(float)scale1
//                       toScale:(float)scale2
//                  autoreverses:(BOOL)autoreverses
//                   repeatCount:(int)repeatCount
//                      duration:(float)duration
//                       forView:(UIView *)aView
//                   removeDelay:(float)delay
//                    completion:(void(^)(BOOL finished))completion
//{
//    //缩放
//    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    scaleAnimation.fromValue = [NSNumber numberWithFloat:scale1];
//    scaleAnimation.toValue = [NSNumber numberWithFloat:scale2];
//    scaleAnimation.duration = duration;
//    scaleAnimation.autoreverses = autoreverses;
//    scaleAnimation.repeatCount = repeatCount;
//    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    
//    [aView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//    
//    [Methods performBlock:^{
//        [aView.layer removeAllAnimations];
//        if(completion)
//        {
//            completion(YES);
//        }
//    } afterDelay:delay];
//}
//
//+(void)opacityAnimationFromValue1:(float)value1
//                         toValue2:(float)value2
//                      repeatCount:(int)repeatCount
//                         duration:(float)duration
//                          forView:(UIView *)aView
//                      removeDelay:(float)delay
//{
//    //透明度变化
//    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    opacityAnimation.fromValue = [NSNumber numberWithFloat:value1];
//    opacityAnimation.toValue = [NSNumber numberWithFloat:value2];
//    opacityAnimation.duration = duration;
//    
//    if([aView isKindOfClass:[UITableViewCell class]] ||
//       [aView isKindOfClass:[NSClassFromString(@"TMQuiltViewCell") class]] ||
//       [aView isKindOfClass:[NSClassFromString(@"UiCollectionViewcELL") class]])
//        opacityAnimation.autoreverses = NO;
//    else
//        opacityAnimation.autoreverses = YES;
//    
//    opacityAnimation.repeatCount = repeatCount;
//    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//    
//    [aView.layer addAnimation:opacityAnimation forKey:@"opacityAnimation"];
//    
//    [Methods performBlock:^{
//        [aView.layer removeAllAnimations];
//    } afterDelay:delay];
//}
//
//#pragma mark ---------------------------------------------- 图文混排（ 计算frame，非富文本 ）
//#define     FacialSizeWidth     18
//#define     FacialSizeHeight    18
//#define     MAX_WIDTH_          228
//#define     BEGIN_FLAG_         @"<-emoji_"
//#define     END_FLAG_           @"->"
////计算文本和表情位置，返回一个UIView
//+(UIView *)viewWithMessage:(NSString *)message
//{
//    //获取处理后的字符串信息（文本 与 表情字符 已分开）
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [Methods splitMessage:message saveToArray:array];
//    
//    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
//    
//    NSArray *data = array;
//    UIFont *font = [UIFont systemFontOfSize:12.0f];
//    CGFloat upX = 0; //当前要显示文字的label 或者 要显示表情的imageView 的 frame.origin.x
//    CGFloat upY = 0; //当前要显示文字的label 或者 要显示表情的imageView 的 frame.origin.y
//    CGFloat X = 0;   //用来记录最后视图的 width
//    CGFloat Y = 0;   //用来记录最后视图的 height
//    
//    //字符串数组不为空
//    if (data)
//    {
//        //将字符串逐个取出，分别计算其所占的位置和大小
//        for (int i = 0;i < [data count];i++)
//        {
//            //取出一个字符串
//            NSString *str = [data objectAtIndex:i];
//            //NSLog(@"str--->%@",str);
//            
//            //所取字符串为表情字符
//            if ([str hasPrefix: BEGIN_FLAG_] && [str hasSuffix: END_FLAG_])
//            {
//                //如果当(前行的width) >= 180 或者 (当前行的width)+(一个表情的宽度)的总和比180大超过5 ,换行
//                if (upX >= MAX_WIDTH_ || upX + FacialSizeWidth - MAX_WIDTH_ > 5.0f)
//                {
//                    upY = upY + FacialSizeHeight;
//                    upX = 0;
//                    X = 0;
//                    Y = upY;
//                }
//                
//                //取出图片名，显示图片，将图片添加到最终视图上
//                NSString *imageName = [str substringWithRange:NSMakeRange(2, str.length - 4)];
//                UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
//                img.frame = CGRectMake(upX, upY, FacialSizeWidth, FacialSizeHeight);
//                
//                upX = upX + FacialSizeWidth;
//                if(upY > 18.0)
//                    X = 228.0f;
//                else
//                {
//                    if (X < 228)
//                        X = upX;
//                }
//                
//                [returnView addSubview:img];
//            }
//            //所取字符串为普通文本
//            else
//            {
//                for (int j = 0; j < [str length]; j++)
//                {
//                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
//                    //计算文本显示的位置和大小
//                    CGRect tmpFrame2 = [temp boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, FacialSizeWidth)
//                                                          options:NSStringDrawingUsesLineFragmentOrigin
//                                                       attributes:@{ NSFontAttributeName : font }
//                                                          context:nil];
//                    CGSize size = tmpFrame2.size;
//                    
//                    if (upX > MAX_WIDTH_ || upX + size.width - MAX_WIDTH_ > 5.0f)
//                    {
//                        upY = upY + FacialSizeHeight;
//                        upX = 0;
//                        X = 228;
//                        Y = upY;
//                    }
//                    //CLog(@"(text)---->%@",str);
//                    //CLog(@"【%@】-------(%.2f,%.2f)",temp,size.width,size.height);
//                    
//                    UILabel *label = [[UILabel alloc] init];
//                    label.frame = CGRectMake(upX,upY,size.width,size.height);
//                    label.font = font;
//                    label.text = temp;
//                    label.backgroundColor = [UIColor clearColor];
//                    
//                    upX = upX + size.width;
//                    if(upY > 18.0)
//                        X = 228.0f;
//                    else
//                    {
//                        if (X < 228)
//                            X = upX;
//                    }
//                    [returnView addSubview:label];
//                }
//            }
//        }
//    }
//    Y += 18;
//    
//    //@ 需要将该view的尺寸记下，方便以后使用
//    returnView.frame = CGRectMake(0.0f,0.0f, X, Y);
//    //CLog(@"----------------(%.2f,%.2f)",X,Y);
//    
//    return returnView;
//}
//
//+(UIView *)viewWithMessage:(NSString *)message //内容
//                  maxWidth:(float)maxWidth     //文本最大宽度
//                emojiWidth:(float)emojiWidth   //表情宽度（ 高度 ）
//                  textFont:(float)textFont     //字体尺寸
//                     color:(UIColor *)color    //字体颜色
//{
//    //获取处理后的字符串信息（文本 与 表情字符 已分开）
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    [Methods splitMessage:message saveToArray:array];
//    
//    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
//    
//    NSArray *data = array;
//    UIFont *font = [UIFont systemFontOfSize:textFont];
//    CGFloat upX = 0; //当前要显示文字的label 或者 要显示表情的imageView 的 frame.origin.x
//    CGFloat upY = 0; //当前要显示文字的label 或者 要显示表情的imageView 的 frame.origin.y
//    CGFloat X = 0;   //用来记录最后视图的 width
//    CGFloat Y = 0;   //用来记录最后视图的 height
//    
//    //字符串数组不为空
//    if (data)
//    {
//        //将字符串逐个取出，分别计算其所占的位置和大小
//        for (int i = 0;i < [data count];i++)
//        {
//            //取出一个字符串
//            NSString *str = [data objectAtIndex:i];
//            //NSLog(@"str--->%@",str);
//            
//            //所取字符串为表情字符
//            if ([str hasPrefix: BEGIN_FLAG_] && [str hasSuffix: END_FLAG_])
//            {
//                //如果当(前行的width) >= 180 或者 (当前行的width)+(一个表情的宽度)的总和比180大超过5 ,换行
//                if (upX >= maxWidth || upX + emojiWidth - maxWidth > 5.0f)
//                {
//                    upY = upY + emojiWidth;
//                    upX = 0;
//                    X = 0;
//                    Y = upY;
//                }
//                
//                //取出图片名，显示图片，将图片添加到最终视图上
//                NSString *imageName = [str substringWithRange:NSMakeRange(2, str.length - 4)];
//                UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
//                img.frame = CGRectMake(upX, upY, emojiWidth, emojiWidth);
//                
//                upX = upX + emojiWidth;
//                if(upY > 18.0)
//                    X = maxWidth;
//                else
//                {
//                    if (X < maxWidth)
//                        X = upX;
//                }
//                
//                [returnView addSubview:img];
//            }
//            //所取字符串为普通文本
//            else
//            {
//                for (int j = 0; j < [str length]; j++)
//                {
//                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
//                    //计算文本显示的位置和大小
//                    CGRect tmpFrame2 = [temp boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, emojiWidth)
//                                                          options:NSStringDrawingUsesLineFragmentOrigin
//                                                       attributes:@{ NSFontAttributeName : font  }
//                                                          context:nil];
//                    CGSize size = tmpFrame2.size;
//                    
//                    if (upX > maxWidth || upX + size.width - maxWidth > 5.0f)
//                    {
//                        upY = upY + emojiWidth;
//                        upX = 0;
//                        X = maxWidth;
//                        Y = upY;
//                    }
//                    //CLog(@"(text)---->%@",str);
//                    //CLog(@"【%@】-------(%.2f,%.2f)",temp,size.width,size.height);
//                    
//                    UILabel *label = [[UILabel alloc] init];
//                    label.frame = CGRectMake(upX,upY,size.width,size.height);
//                    label.font = font;
//                    label.text = temp;
//                    label.backgroundColor = [UIColor clearColor];
//                    if(color != nil)
//                        label.textColor = color;
//                    
//                    upX = upX + size.width;
//                    if(upY > 18.0)
//                        X = maxWidth;
//                    else
//                    {
//                        if (X < maxWidth)
//                            X = upX;
//                    }
//                    [returnView addSubview:label];
//                }
//            }
//        }
//    }
//    Y += 18;
//    
//    //@ 需要将该view的尺寸记下，方便以后使用
//    returnView.frame = CGRectMake(0.0f,0.0f, X, Y);
//    //CLog(@"----------------(%.2f,%.2f)",X,Y);
//    
//    return returnView;
//}
//
////截取信息，将文本与表情标志分开
//+(void)splitMessage:(NSString*)message saveToArray:(NSMutableArray*)array
//{
//    NSRange range = [message rangeOfString: BEGIN_FLAG_];
//    NSRange range1 = [message rangeOfString: END_FLAG_];
//    //判断当前字符串是否还有表情的标志。
//    
//    //字符串 message 中包含 "<-emoji_" 和 "->"
//    if (range.length > 0 && range1.length > 0)
//    {
//        //第一个表情标志前还有其他文本
//        if (range.location > 0)
//        {
//            //截取文本，存入数组
//            [array addObject:[message substringToIndex:range.location]];
//            [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location + range1.length - range.location)]];
//            NSString *str = [message substringFromIndex:range1.location + range1.length];
//            [Methods splitMessage:str saveToArray:array];
//            
//            //NSLog(@"array - %@",array);
//        }
//        //刚开始就是表情字符
//        else
//        {
//            NSString *nextstr = [message substringWithRange:NSMakeRange(range.location, range1.location + range1.length - range.location)];
//            //排除文字是“”的
//            if (![nextstr isEqualToString:@""])
//            {
//                [array addObject:nextstr];
//                NSString *str = [message substringFromIndex:range1.location + range1.length];
//                [self splitMessage:str saveToArray:array];
//            }
//            else
//            {
//                return;
//            }
//        }
//    }
//    //不包含表情字符（标志）
//    else if (message != nil)
//    {
//        [array addObject:message];
//    }
//}
//
////========================================
//
//
//#pragma mark ---------------------------------------------- 计算日期间隔、时间间隔
//+ (NSInteger)numberOfDaysFromDate:(id)date1 toDate:(id)date2
//{
//    //两日期相减
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    
//    NSDate *dateA,*dateB;
//    if([date1 isKindOfClass:[NSDate class]])
//    {
//        dateA = date1;
//    }
//    else
//    {
//        dateA = [dateFormatter dateFromString:(NSString *)date1];
//    }
//    
//    if([date2 isKindOfClass:[NSDate class]])
//    {
//        dateB = date2;
//    }
//    else
//    {
//        dateB = [dateFormatter dateFromString:(NSString *)date2];
//    }
//    
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
//    unsigned int unitFlags = NSDayCalendarUnit;
//    NSDateComponents *comps = [gregorian components:unitFlags fromDate:dateA  toDate:dateB  options:0];
//    
//    int days = (int)[comps day];
//    
//    //    if(days < 0)
//    //        days = 0;
//    
//    return days;
//}
//+ (NSInteger)numberOfHoursFromDate:(id)date1 toDate:(id)date2;
//{
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    
//    NSDate *dateA,*dateB;
//    if([date1 isKindOfClass:[NSDate class]])
//    {
//        dateA = date1;
//    }
//    else
//    {
//        dateA = [dateFormatter dateFromString:(NSString *)date1];
//    }
//    
//    if([date2 isKindOfClass:[NSDate class]])
//    {
//        dateB = date2;
//    }
//    else
//    {
//        dateB = [dateFormatter dateFromString:(NSString *)date2];
//    }
//    
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
//    unsigned int unitFlags = NSHourCalendarUnit;
//    NSDateComponents *comps = [gregorian components:unitFlags fromDate:dateA toDate:dateB options:0];
//    
//    int hours = (int)[comps hour];
//    
//    int flag = 1;
//    if(hours < 0)
//        flag = -1;
//    
//    while (abs(hours) >= 24)
//    {
//        hours = hours - 24;
//    }
//    
//    return hours * flag;
//}
//+ (NSInteger)numberOfMinutesFromDate:(id)date1 toDate:(id)date2;
//{
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    
//    NSDate *dateA,*dateB;
//    if([date1 isKindOfClass:[NSDate class]])
//    {
//        dateA = date1;
//    }
//    else
//    {
//        dateA = [dateFormatter dateFromString:(NSString *)date1];
//    }
//    
//    if([date2 isKindOfClass:[NSDate class]])
//    {
//        dateB = date2;
//    }
//    else
//    {
//        dateB = [dateFormatter dateFromString:(NSString *)date2];
//    }
//    
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
//    unsigned int unitFlags = NSMinuteCalendarUnit;
//    NSDateComponents *comps = [gregorian components:unitFlags fromDate:dateA toDate:dateB options:0];
//    
//    int minutes = (int)[comps minute];
//    
//    
//    int flag = 1;
//    if(minutes < 0)
//        flag = -1;
//    
//    while (abs(minutes) >= 60)
//    {
//        minutes = minutes - 60;
//    }
//    return minutes * flag;
//}
//+ (NSInteger)numberOfSecondsFromDate:(id)date1 toDate:(id)date2;
//{
//    //实例化一个NSDateFormatter对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
//    
//    NSDate *dateA,*dateB;
//    if([date1 isKindOfClass:[NSDate class]])
//    {
//        dateA = date1;
//    }
//    else
//    {
//        dateA = [dateFormatter dateFromString:(NSString *)date1];
//    }
//    
//    if([date2 isKindOfClass:[NSDate class]])
//    {
//        dateB = date2;
//    }
//    else
//    {
//        dateB = [dateFormatter dateFromString:(NSString *)date2];
//    }
//    
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
//    unsigned int unitFlags = NSSecondCalendarUnit;
//    NSDateComponents *comps = [gregorian components:unitFlags fromDate:dateA toDate:dateB options:0];
//    
//    int seconds = (int)[comps second];
//    
//    return seconds;
//}
//
//
//#pragma mark ---------------------------------------------- URLEncode 转码
//+ (NSString *)URLEncodeWithString:(NSString *)string
//{
//    NSString *encodedString = (NSString *)
//    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                              (CFStringRef)string,
//                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
//                                                              NULL,
//                                                              kCFStringEncodingUTF8));
//    return encodedString;
//}
//
//#pragma mark ---------------------------------------------- 微信支付相关参数生成（ package、签名、随机码 ）
//+(NSString *)createPackageStrWithParams:(NSMutableDictionary *)params
//{
//    NSMutableDictionary *tempParams1 = [NSMutableDictionary dictionaryWithDictionary:params];
//    NSMutableDictionary *tempParams2 = [NSMutableDictionary dictionaryWithDictionary:params];
//    
//    //对所有传入参数按照字段名的 ASCII 码从小到大排序(字典序)后,使用 URL 键值对的格 式(即 key1=value1&key2=value2...)拼接成字符串 string1;
//    NSArray *keysAfterSort1 = [tempParams1 allKeys];
//    //CLog(@"排序后的字段名 - %@",keysAfterSort);
//    keysAfterSort1 = [keysAfterSort1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
//                      {
//                          NSComparisonResult result = [obj1 compare:obj2];
//                          return result == NSOrderedDescending;
//                      }];
//    //CLog(@"排序后 - %@",tempParams1);
//    
//    NSMutableString *sourceStr1 = [NSMutableString string];
//    for(int i = 0 ; i < keysAfterSort1.count ; i ++ )
//    {
//        NSString *key = [keysAfterSort1 objectAtIndex:i];
//        
//        [sourceStr1 appendString:key];
//        [sourceStr1 appendString:@"="];
//        [sourceStr1 appendString:[tempParams1 objectForKey:key]];
//        [sourceStr1 appendString:@"&"];
//    }
//    NSString *string1 = sourceStr1;
//    //CLog(@"拼接后的字段 - %@",string1);
//    
//    //在 string1 最后拼接上 key=partnerKey 得到 stringSignTemp
//    NSString *stringSignTemp = [NSString stringWithFormat:@"%@key=%@",string1,wx_partnerKey];
//    
//    //对 stringSignTemp 进行 md5 运算,再将得到的字符串所有字符转换为大写,得到 sign 值 signValue
//    NSString *signValue = [[stringSignTemp md5_] uppercaseString];
//    CLog(@"sign(MD5) - %@",signValue);
//    
//    
//    //排序
//    NSArray *keysAfterSort2 = [tempParams2 allKeys];
//    keysAfterSort2 = [keysAfterSort2 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
//                      {
//                          NSComparisonResult result = [obj1 compare:obj2];
//                          return result == NSOrderedDescending;
//                      }];
//    NSMutableString *sourceStr2 = [NSMutableString string];
//    //urlencode 转码
//    for (NSString *key in keysAfterSort2)
//    {
//        NSString *str = [tempParams2 objectForKey:key];
//        NSString *encodedString = [str URLEncodedString];
//        [tempParams2 setObject:encodedString forKey:key];
//    }
//    for(int i = 0 ; i < keysAfterSort2.count ; i ++ )
//    {
//        NSString *key = [keysAfterSort2 objectAtIndex:i];
//        
//        [sourceStr2 appendString:key];
//        [sourceStr2 appendString:@"="];
//        [sourceStr2 appendString:[tempParams2 objectForKey:key]];
//        [sourceStr2 appendString:@"&"];
//    }
//    NSString *string2 = sourceStr2;
//    //CLog(@"urlencode后的字段 - %@",string2);
//    
//    //将 sign=signValue 拼接到 string2 后面得到最终的 package 字符串
//    NSString *package = [NSString stringWithFormat:@"%@&sign=%@",string2,signValue];
//    CLog(@"package - %@",package);
//    
//    return package;
//}
//+(NSString *)createAppSignatureWithParams:(NSMutableDictionary *)params
//{
//    //排序
//    NSArray *keysAfterSort = [params allKeys];
//    keysAfterSort = [keysAfterSort sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
//                     {
//                         NSComparisonResult result = [obj1 compare:obj2];
//                         return result == NSOrderedDescending;
//                     }];
//    
//    NSMutableString *temp1 = [NSMutableString string];
//    for(int i = 0 ; i < keysAfterSort.count ; i ++ )
//    {
//        NSString *key = [keysAfterSort objectAtIndex:i];
//        
//        [temp1 appendString:key];
//        [temp1 appendString:@"="];
//        [temp1 appendString:[params objectForKey:key]];
//        [temp1 appendString:@"&"];
//    }
//    
//    NSString *string1 = [temp1 substringToIndex:temp1.length-1];
//    NSString *paySign = [string1 sha1];
//    
//    CLog(@"paySign(sha1) - %@",paySign);
//    
//    return paySign;
//}
//
////生成订单ID（由商家自行制定） - 随机生成15位订单编号
//+ (NSString *)generateRandomCode
//{
//    const int N = 32;
//    
//    NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    NSMutableString *result = [[NSMutableString alloc] init];
//    srand((unsigned)time(0));
//    for (int i = 0; i < N; i++)
//    {
//        //unsigned index = rand() % [sourceString length];
//        unsigned index = arc4random() % 32;
//        NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
//        [result appendString:s];
//    }
//    return result;
//}
//
//
//#pragma mark ---------------------------------------------- 本地持久化（ NSUserDefaults ）
//+ (NSUserDefaults *)userDefault
//{
//    return [NSUserDefaults standardUserDefaults];
//}
//+ (id)objectForKey:(NSString *)key
//{
//    return [[Methods userDefault] objectForKey:key];
//}
//+ (void)setObject:(id)object forKey:(NSString *)key
//{
//    [[Methods userDefault] setObject:object forKey:key];
//    [[Methods userDefault] synchronize];
//}
//+ (void)removeObjectForKey:(NSString *)key
//{
//    [[Methods userDefault] removeObjectForKey:key];
//    [[Methods userDefault] synchronize];
//}
//
//
//
//#pragma mark ---------------------------------------------- 改变 button背景色、字体颜色，label字体颜色
//+ (void)changeBtnStatus:(UIButton *)sender
//{
//    [sender setBackgroundColor:RGB(200, 200, 200, 0.5)];
//    sender.userInteractionEnabled = NO;
//    [Methods performBlock:^{
//        [sender setBackgroundColor:[UIColor clearColor]];
//        sender.userInteractionEnabled = YES;
//    } afterDelay:0.2];
//}
//+ (void)changeBtnTextColor:(UIButton *)sender
//{
//    UIColor *color = sender.titleLabel.textColor;
//    [sender setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//    [Methods performBlock:^{
//        [sender setTitleColor:color forState:UIControlStateNormal];
//    } afterDelay:0.2];
//}
//+ (void)changeLblTextColor:(UILabel *)sender
//{
//    UIColor *color = sender.textColor;
//    sender.textColor = [UIColor orangeColor];
//    [Methods performBlock:^{
//        sender.textColor = color;
//    } afterDelay:0.2];
//}
//
//
//#pragma mark ---------------------------------------------- 拨打电话
//+ (void)callThePhone:(NSString *)phoneNumber
//{
//    NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",phoneNumber];
//    [[UIApplication sharedApplication] openURL:URL(num)];
//}
//
//
//#pragma mark ---------------------------------------------- return键关闭键盘（ UITextView ）
//+ (BOOL)closeTextViewKeyboard_1_WhenPressedReturnOfTextView:(UITextView *)textView replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"])
//    {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}
//+ (void)closeTextViewKeyboard_2_WhenPressedReturnOfTextView:(UITextView *)textView
//{
//    NSString *str = textView.text;
//    if([str hasSuffix:@"\n"])
//    {
//        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//        textView.text = str;
//        [textView resignFirstResponder];
//    }
//}
//
//
//#pragma mark ---------------------------------------------- 获取图片尺寸（ png、jpg ）
//+ (CGSize)pngImageSizeWithHeaderData:(NSData *)data
//{
//    int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
//    [data getBytes:&w1 range:NSMakeRange(0, 1)];
//    [data getBytes:&w2 range:NSMakeRange(1, 1)];
//    [data getBytes:&w3 range:NSMakeRange(2, 1)];
//    [data getBytes:&w4 range:NSMakeRange(3, 1)];
//    int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
//    int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
//    [data getBytes:&h1 range:NSMakeRange(4, 1)];
//    [data getBytes:&h2 range:NSMakeRange(5, 1)];
//    [data getBytes:&h3 range:NSMakeRange(6, 1)];
//    [data getBytes:&h4 range:NSMakeRange(7, 1)];
//    int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
//    
//    return CGSizeMake(w, h);
//}
//+ (CGSize)jpgImageSizeWithHeaderData:(NSData *)data
//{
//    if ([data length] <= 0x58)
//    {
//        return CGSizeZero;
//    }
//    if ([data length] < 210) {// 肯定只有一个DQT字段
//        short w1 = 0, w2 = 0;
//        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
//        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
//        short w = (w1 << 8) + w2;
//        short h1 = 0, h2 = 0;
//        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
//        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
//        short h = (h1 << 8) + h2;
//        return CGSizeMake(w, h);
//    }
//    else
//    {
//        short word = 0x0;
//        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
//        if (word == 0xdb)
//        {
//            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
//            if (word == 0xdb)
//            {
//                // 两个DQT字段
//                short w1 = 0, w2 = 0;
//                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
//                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
//                short w = (w1 << 8) + w2;
//                short h1 = 0, h2 = 0;
//                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
//                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
//                short h = (h1 << 8) + h2;
//                return CGSizeMake(w, h);
//            }
//            else
//            {
//                // 一个DQT字段
//                short w1 = 0, w2 = 0;
//                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
//                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
//                short w = (w1 << 8) + w2;
//                short h1 = 0, h2 = 0;
//                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
//                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
//                short h = (h1 << 8) + h2;
//                return CGSizeMake(w, h);
//            }
//        }
//        else
//        {
//            return CGSizeZero;
//        }
//    }
//}
//
//
//
//#pragma mark ---------------------------------------------- 取消网络请求（ AF ）
//+ (void)cancelReq:(AFHTTPRequestOperation *)anRequest
//{
//    if(anRequest != nil && ![anRequest isFinished])
//    {
//        [anRequest cancel];
//        anRequest = nil;
//    }
//}
//
//
//
//#pragma mark ---------------------------------------------- 字数统计
////字数计算方式
////==============================
//// 汉字 --------- 1
//// ascii字符 ---- 0.5
//// 空格 --------- 0.5
////==============================
////最后计算时，ascII字符 与 空格 之和取天花板数
//+ (int)countWord:(NSString*)str
//{
//    int i, n = (unsigned int)[str length], l = 0, a = 0, b = 0;
//    unichar c;
//    for(i = 0; i < n; i++){
//        c = [str characterAtIndex:i];
//        if(isblank(c)){
//            b++;
//        }
//        else if(isascii(c))
//        {
//            a++;
//        }
//        else
//        {
//            l++;
//        }
//    }
//    if(a==0 && l==0)
//        return 0;
//    return l+(int)ceilf((float)(a+b)/2.0);
//}
//
//
//#pragma mark ---------------------------------------------- 计算含表情字符的文本的字数
//#define  ExpString  @"[表情]"
//+ (int)countWord_2:(NSString *)str
//{
//    NSString *tmp = str;
//    int length = 0;
//    int expNum = 0;
//    BOOL hasExp = YES;
//    while(hasExp)
//    {
//        NSRange range = [tmp rangeOfString:ExpString];
//        if(range.location != NSNotFound)
//        {
//            expNum ++;
//            tmp = [tmp stringByReplacingCharactersInRange:range withString:@""];
//            hasExp = YES;
//        }
//        else
//        {
//            hasExp = NO;
//        }
//    }
//    length = (int)tmp.length + expNum;
//    return length;
//}
//#pragma mark ----------------------------------------------  将表情标志 "<-emoji_75->" 替换成 "[表情]"
//+ (NSString *)replaceExpStrWithExps:(NSMutableArray *)exps forStr:(NSString *)str
//{
//    NSString *tmp = str;
//    BOOL hasExp = YES;
//    int index = -1;
//    while(hasExp)
//    {
//        NSRange range = [tmp rangeOfString:ExpString];
//        if(range.location != NSNotFound)
//        {
//            index ++;
//            tmp = [tmp stringByReplacingCharactersInRange:range withString:exps[index]];
//            hasExp = YES;
//        }
//        else
//        {
//            hasExp = NO;
//        }
//    }
//    return tmp;
//}
//
//
//
//#pragma mark ---------------------------------------------- 版本更新
///*
// + (void)alertNewVersion:(BOOL)isAlert
// {
// NSUserDefaults *def = [self userDefault];
// [def setObject:[NSNumber numberWithBool:isAlert] forKey:@"AlertNewVersionNextTime"];
// [def synchronize];
// }
// + (BOOL)isAlertNewVersion
// {
// return [[[self userDefault] objectForKey:@"AlertNewVersionNextTime"] boolValue];
// }
// + (AFHTTPRequestOperation *)checkVersionAtViewController:(UIViewController *)controller
// {
// [[LoadingView2 loadingWithText:@"检测中..."] showWithNoTime];
// 
// return
// [DataModel requestWithType:@"post"
// url:APP_URL
// parameters:nil
// withHUD:NO
// callBack:^(NSDictionary *posts, NSError *error)
// {
// [Methods closeDefaultHUD];
// if(posts)
// {
// NSString *curVewsion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
// NSString *newVersion = nil;
// 
// NSMutableArray *arr = [posts objectForKey:@"results"];
// if(arr.count > 0)
// {
// NSDictionary *dic = [arr objectAtIndex:0];
// newVersion = [dic objectForKey:@"version"];
// }
// 
// CLog(@"线上版本 - %@",newVersion);
// CLog(@"当前版本 - %@",curVewsion);
// 
// //有新版本
// if([newVersion compare:curVewsion] > 0)
// {
// NSString *msg = [NSString stringWithFormat:@"发现新版本( %@ ) ！是否立即更新 ！",newVersion];
// PDYAlertView *alert = [[PDYAlertView alloc] initWithTitle:@"提 示"
// message:msg
// cancelBtnTitle:@"暂不更新"
// otherBtnTitles:@[@"更新"]];
// alert.clickedAlertViewButtonAtIndex = ^(int btnIndex)
// {
// if(btnIndex == 1)
// {
// StoreProductVC *storeProductVC = [[StoreProductVC alloc] init];
// [controller presentViewController:storeProductVC animated:YES completion:nil];
// }
// };
// [alert show];
// }
// else
// {
// [Methods displayDXAlertView:@"当前已是最新版本 ！！"];
// }
// }
// }];
// }
// */
//
//
//#pragma mark ---------------------------------------------- APP是否第一次运行
//#define  APPFirstRunKey @"isAppFirstRun"
//+ (void)setFirstRun:(BOOL)isFirstRun
//{
//    NSUserDefaults *def = [self userDefault];
//    [def setObject:[NSNumber numberWithBool:isFirstRun] forKey:APPFirstRunKey];
//    [def synchronize];
//}
//+ (BOOL)isAppFirstRun
//{
//    NSString *isFirstRun = [[self userDefault] objectForKey:APPFirstRunKey];
//    if(isFirstRun == nil)
//    {
//        return YES;
//    }
//    else
//    {
//        return [[[self userDefault] objectForKey:APPFirstRunKey] boolValue];
//    }
//}
//
//
//#pragma mark ---------------------------------------------- 获取网络类型
//+ (NSString *)networkType
//{
//    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
//    NSNumber *dataNetworkItemView = nil;
//    
//    for (id subview in subviews)
//    {
//        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])
//        {
//            dataNetworkItemView = subview;
//            break;
//        }
//    }
//    
//    NSString *networkType = nil;
//    switch ([[dataNetworkItemView valueForKey:@"dataNetworkType"] integerValue])
//    {
//        case 0: networkType = @"No wifi or cellular";   break;
//        case 1: networkType = @"2G";                    break;
//        case 2: networkType = @"3G";                    break;
//        case 3: networkType = @"4G";                    break;
//        case 4: networkType = @"LTE";                   break;
//        case 5: networkType = @"Wifi";                  break;
//        default:                                        break;
//    }
//    return networkType;
//}
//
//
//
//#pragma mark ---------------------------------------------- 数据类型、格式转换（ 目标类型：字符串 ）
//+ (NSString *)intToStr:(int)intValue
//{
//    return [NSString stringWithFormat:@"%d",intValue];
//}
//+ (NSString *)floatToStr:(float)floatValue
//{
//    return [NSString stringWithFormat:@"%f",floatValue];
//}
//+ (NSString *)floatToStr1:(float)floatValue
//{
//    return [NSString stringWithFormat:@"%.1f",floatValue];
//}
//+ (NSString *)floatToStr2:(float)floatValue
//{
//    return [NSString stringWithFormat:@"%.2f",floatValue];
//}
//+ (NSString *)floatToStr6:(float)floatValue
//{
//    return [NSString stringWithFormat:@"%.6f",floatValue];
//}
//+ (NSString *)RMBString:(NSString *)string
//{
//    return [NSString stringWithFormat:@"￥%.2f",string.floatValue];
//}
//+ (NSString *)doubleToStr:(double)doubleValue
//{
//    return [NSString stringWithFormat:@"%lf",doubleValue];
//}
//+ (NSString *)longToStr:(long)longValue
//{
//    return [NSString stringWithFormat:@"%ld",longValue];
//}
//+ (NSString *)longlongToStr:(long long)longLongValue
//{
//    return [NSString stringWithFormat:@"%lld",longLongValue];
//}
//+ (NSString *)boolToStr:(BOOL)boolValue
//{
//    return [NSString stringWithFormat:@"%@",(boolValue ? @"YES" : @"NO")];
//}
//// NSObject ------> string
//+ (NSString *)objToStr:(id)objValue
//{
//    return [NSString stringWithFormat:@"%@",objValue];
//}
//// bool ------> intStr
//+ (NSString *)boolToIntStr:(BOOL)boolValue
//{
//    return boolValue ? @"1" : @"0";
//}
//+ (BOOL)intStrToBool:(NSString *)stringValue
//{
//    return (stringValue.intValue == 0) ? NO : YES;
//}
//
//#pragma mark ---------------------------------------------- 检查对象的值，为空则赋予默认值
//+ (id)checkObj:(id)anObj
//{
//    NSString *strToReturn = nil;
//    if([anObj isKindOfClass:[NSNull class]])
//    {
//        strToReturn = @"";
//    }
//    if([anObj isKindOfClass:[NSNumber class]])
//    {
//        if([anObj isEqual:[NSNull null]])
//        {
//            strToReturn = @"0";
//        }
//        else
//        {
//            strToReturn = [Methods objToStr:anObj];
//        }
//    }
//    if([anObj isKindOfClass:[NSString class]])
//    {
//        if([anObj isEqual:[NSNull null]])
//        {
//            strToReturn = @"";
//        }
//        else
//        {
//            strToReturn = (NSString *)anObj;
//        }
//    }
//    if(anObj == nil)
//    {
//        strToReturn = @"";
//    }
//    return strToReturn;
//}
//
//#pragma mark ---------------------------------------------- 移除指定视图的子视图
//+(void)removeSubViewsForView:(UIView *)aView
//{
//    for(UIView *v in aView.subviews)
//    {
//        [v removeFromSuperview];
//    }
//}
//
//#pragma mark ---------------------------------------------- json字符串 转换成 字典
//+ (NSDictionary *)jsonDicFromJsonString:(NSString *)jsonStr
//{
//    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
//    
//    return jsonDic;
//}
//+ (id)jsonDataFromJsonString:(NSString *)jsonStr
//{
//    NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
//    id jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    
//    return jsonData;
//}
//
//
//#pragma mark ---------------------------------------------- 透明渐变显示、隐藏指定视图
//+ (void)hideView:(UIView *)aView animated:(BOOL)animated
//{
//    if(animated)
//    {
//        [UIView animateWithDuration:0.2f animations:^{
//            if(aView.alpha > 0.01)
//            {
//                aView.alpha = 0.0f;
//            }
//        } completion:nil];
//    }
//    else
//    {
//        aView.alpha = 0.0f;
//    }
//}
//+(void)showView:(UIView *)aView animated:(BOOL)animated
//{
//    if(animated)
//    {
//        [UIView animateWithDuration:0.2f animations:^{
//            if(aView.alpha < 0.01)
//            {
//                aView.alpha = 1.0f;
//            }
//        } completion:nil];
//    }
//    else
//    {
//        aView.alpha = 1.0f;
//    }
//}
//
//#pragma mark ---------------------------------------------- 输入条输入框（ 回复、评论 ）
//+ (void)initCommentBarWithPlaceholder:(NSString *)placeholder
//{
//    CommentReplyBar *commentBar = [CommentReplyBar getInstanceWithPreText:placeholder];
//    commentBar.tag = CommentBarTag;
//    [commentBar addToWindow];
//}
//+(CommentReplyBar *)getCommentBarWithPlaceholder:(NSString *)placeholder
//{
//    BOOL flag = [self existCommentBar];
//    if(!flag)
//    {
//        [self initCommentBarWithPlaceholder:placeholder];
//    }
//    return (CommentReplyBar *)[[self window] viewWithTag:CommentBarTag];
//}
//+ (BOOL)existCommentBar
//{
//    CommentReplyBar *commentBar = (CommentReplyBar *)[[self window] viewWithTag:CommentBarTag];
//    if(commentBar == nil)
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}
//+ (void)removeCommentBarFromWindow
//{
//    if([self existCommentBar] == YES)
//    {
//        CommentReplyBar *commentBar = (CommentReplyBar *)[[self window] viewWithTag:CommentBarTag];
//        if([commentBar.input_textView isFirstResponder])
//        {
//            [commentBar.input_textView resignFirstResponder];
//        }
//        [commentBar removeFromWindow];
//    }
//}
//
//#pragma mark ---------------------------------------------- 自定义表情输入法
//+ (void)initExpView
//{
//    ExpressionInputView_2 *expView = [[ExpressionInputView_2 alloc] initExpressionView];
//    expView.tag = ExpViewTag;
//    [[Methods window] addSubview:expView];
//}
//+ (ExpressionInputView_2 *)getExpView
//{
//    ExpressionInputView_2 *expView = (ExpressionInputView_2 *)[[self window] viewWithTag:ExpViewTag];
//    if(expView == nil)
//    {
//        [self initExpView];
//    }
//    return (ExpressionInputView_2 *)[[self window] viewWithTag:ExpViewTag];
//}
//+ (void)showExpView
//{
//    ExpressionInputView_2 *expView = [self getExpView];
//    if(expView == nil)
//    {
//        [self initExpView];
//    }
//    if([self isExpViewShow] == NO)
//    {
//        [UIView animateWithDuration:0.25f animations:^{
//            expView.frame = CGRectMake(0, ScreenHeight-ExpViewHeight, ScreenWidth, ExpViewHeight);
//        } completion:^(BOOL finished) {
//            
//        }];
//    }
//}
//+ (void)hideExpViewAndRemove:(BOOL)remove
//{
//    ExpressionInputView_2 *expView = [self getExpView];
//    if([self isExpViewShow] == YES)
//    {
//        [UIView animateWithDuration:0.25f animations:^{
//            expView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ExpViewHeight);
//        } completion:^(BOOL finished) {
//            if(remove)
//            {
//                [expView removeAllData];
//                [expView removeFromSuperview];
//            }
//        }];
//    }
//}
//+ (BOOL)isExpViewShow
//{
//    ExpressionInputView_2 *expView = [self getExpView];
//    if(expView == nil)
//        return NO;
//    else
//    {
//        CGPoint origin = expView.frame.origin;
//        if(origin.y >= ScreenHeight)
//            return NO;
//        else
//            return YES;
//    }
//}
//
//
//#pragma mark ---------------------------------------------- 礼物动画（ 二 ）
//#define GIFTS  @[@"", @"", @"一束玫瑰", @"一颗炸弹", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""]
//+ (NSString *)giftStr:(int)type
//{
//    return GIFTS[type];
//}
//+ (void)roseAnimationWithPoint1:(CGPoint)point1 point2:(CGPoint)point2 img:(NSString *)imgName completion:(void (^)(BOOL finished))completion
//{
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
//    imgView.frame = Frame(point1.x-110, point1.y-130, 220, 220);
//    imgView.tag = GiftImgTag;
//    imgView.alpha = 0;
//    [[self window] addSubview:imgView];
//    
//    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeDiscrete animations:^{
//        imgView.alpha = 1.0f;
//    } completion:^(BOOL finished) {
//        
//        [Methods scaleAnimationFromScale:1 toScale:1.5 repeatCount:1 duration:0.3 forView:imgView removeDelay:0.6];
//        
//        [Methods performBlock:^{
//            
//            //位置移动
//            CABasicAnimation *positionAnimation  = [CABasicAnimation animationWithKeyPath:@"position"];
//            positionAnimation.fromValue =  [NSValue valueWithCGPoint: point1];
//            positionAnimation.toValue = [NSValue valueWithCGPoint:point2];
//            positionAnimation.duration = 1.5;
//            positionAnimation.autoreverses = NO;
//            positionAnimation.repeatCount = 1;
//            
//            //缩放
//            CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//            scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//            scaleAnimation.toValue = [NSNumber numberWithFloat:0.1];
//            scaleAnimation.duration = 1.5f;
//            scaleAnimation.autoreverses = NO;
//            scaleAnimation.repeatCount = 1;
//            scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//            
//            //旋转动画
//            CABasicAnimation* rotationAnimation =
//            [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
//            rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 5];
//            rotationAnimation.duration = 1.5f;
//            rotationAnimation.autoreverses = NO;
//            rotationAnimation.repeatCount = 3;
//            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; //缓入缓出
//            
//            //透明度变化
//            CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//            opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
//            opacityAnimation.toValue = [NSNumber numberWithFloat:0];
//            opacityAnimation.autoreverses = YES;
//            opacityAnimation.duration = 1.5;
//            
//            NSMutableArray *animationArray = [NSMutableArray arrayWithCapacity:1];
//            [animationArray addObject:positionAnimation];
//            [animationArray addObject:scaleAnimation];
//            [animationArray addObject:rotationAnimation];
//            [animationArray addObject:opacityAnimation];
//            
//            //组合动画
//            CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
//            animationGroup.duration = 1.5f;
//            animationGroup.autoreverses = YES;                         //是否重播，原动画的倒播
//            //animationGroup.repeatCount = NSNotFound;//HUGE_VALF;     //HUGE_VALF,源自math.h
//            [animationGroup setAnimations:animationArray];
//            
//            [imgView.layer addAnimation:animationGroup forKey:@"groupAnimation"];
//            
//            [Methods performBlock:^{
//                
//                imgView.alpha = 0;
//                [Methods hideView:imgView animated:YES];
//                [imgView removeFromSuperview];
//                
//                if(completion)
//                {
//                    completion(YES);
//                }
//                
//            } afterDelay:1.5f];
//            
//        } afterDelay:0.6];
//    }];
//}
//
//
//#pragma mark ---------------------------------------------- 上传进度条
////注销进度条
//+ (void)removeAllProgressRecords
//{
//    [Methods removeObjectForKey:ProgressCenter];
//}
//
//#pragma mark ---------------------------------------------- 阴影效果
//+ (void)shadowWithColor:(UIColor *)color alpha:(float)alpha radius:(float)radius offset:(CGSize)offset forView:(UIView *)aView
//{
//    //导航条阴影
//    aView.layer.shadowColor = color.CGColor;
//    aView.layer.shadowOpacity = alpha;
//    aView.layer.shadowRadius = radius;
//    aView.layer.shadowOffset = offset;
//}
//
//+ (void)alertNoMoreData:(void(^)(BOOL done))block
//{
//    [Methods show_txt_HUD:@"没了哦 ！亲 ！"];
//    [Methods performBlock:^{
//        if(block) block(YES);
//    } afterDelay:1.5f];
//}
//+ (void)alertError:(void(^)(BOOL done))block
//{
//    [Methods show_txt_HUD:@"ERROR"];
//    [Methods performBlock:^{
//        if(block) block(YES);
//    } afterDelay:1.5f];
//}
//
//
//#pragma mark ---------------------------------------------- 登录、注销通知
////注册登录通知
//+ (id<NSObject>)registerLoginNotificationWithCallBack:(void(^)(NSNotification *note))login
//{
//    return [[NSNotificationCenter defaultCenter] addObserverForName:LoginNotification
//                                                             object:nil
//                                                              queue:[NSOperationQueue mainQueue]
//                                                         usingBlock:^(NSNotification *note)
//            {
//                if(login) login(note);
//            }];
//}
////注册退出通知
//+ (id<NSObject>)registerLogoutNotificationWithCallBack:(void(^)(NSNotification *note))logout
//{
//    return [[NSNotificationCenter defaultCenter] addObserverForName:LogoutNotification
//                                                             object:nil
//                                                              queue:[NSOperationQueue new]
//                                                         usingBlock:^(NSNotification *note)
//            {
//                if(logout) logout(note);
//            }];
//}
////发送登录通知
//+ (void)postLoginNotification
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:LoginNotification object:nil userInfo:nil];
//}
////发送注销通知
//+ (void)postLogoutNotification
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:LogoutNotification object:nil userInfo:nil];
//}
////移除[登录]通知
//+ (void)removeLoginNotification:(id)observer
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:observer name:LoginNotification object:nil];
//}
////移除[注销]通知
//+ (void)removeLogoutNotification:(id)observer
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:observer name:LogoutNotification object:nil];
//}
//
//
//#pragma mark ---------------------------------------------- 当前登录用户ID
//
//+ (NSString *)curUserID
//{
//    if([SettingsManager isLoggedIn] == 1)
//    {
//        NSString *userID = [SettingsManager settings].userID;
//        if(userID == nil || [userID isEqualToString:@""])
//        {
//            return @"0";
//        }
//        else
//        {
//            return userID;
//        }
//    }
//    else
//    {
//        return @"0";
//    }
//}
//
//
//#pragma mark ---------------------------------------------- 活动指示器（ 版本2.0 ）、提示视图、弹框
////只有【文本】 ---> 1.5秒自动关闭
//+ (void)show_txt_HUD:(NSString *)text
//{
//    if(useNewLoadingStyle == YES)
//    {
//        //新版 （ 2014-11-06 ）
//        NetworkAlertView *alert = [NetworkAlertView alertWithText:text time:1.5f];
//        [alert show];
//    }
//    else
//    {
//        //旧版 （ 2014-02-01 ）
//        [Methods disAtmHUDWithStr:text withTime:1.5f];
//    }
//}
////【文本】+【图片】 ---> 2秒自动关闭
//+ (void)show_txt_img_HUD:(LoadingViewType)type
//{
//    LoadingView2 *loadingView = [LoadingView2 loadingWithStyle:type];
//    [loadingView showWithTime:2.0f];
//}
////【文本】+【图片】 ---> delay秒自动关闭
//+ (void)show_txt_img_time_HUD:(LoadingViewType)type hideDelay:(float)delay
//{
//    LoadingView2 *loadingView = [LoadingView2 loadingWithStyle:type];
//    [loadingView showWithTime:delay];
//}
////默认样式的指示器 ---> 需调用方法关闭，或15秒自动关闭
//+ (void)showDefaultHUD
//{
//    LoadingView2 *loadingView = [LoadingView2 loadingWithStyle:LoadingViewType_Loading];
//    [loadingView showWithNoTime];
//}
////关闭默认样式的指示器
//+ (void)closeDefaultHUD
//{
//    LoadingView2 *loadingView = [LoadingView2 shareLoadingView];
//    [loadingView hide];
//}
//
//
//#pragma mark ----------------------------------------------
////将数字转化成以“万”“亿”为单位的字符串
//+ (NSString *)numStringWithString:(NSString *)numString
//{
//    NSString *str = @"";
//    long long num = [numString longLongValue];
//    if(num <= 10000)
//    {
//        str = numString;
//    }
//    else if(num > 10000 && num <= 1000000)
//    {
//        str = [NSString stringWithFormat:@"%.2f万",num/10000.00];
//    }
//    else if(num > 1000000)
//    {
//        str = [NSString stringWithFormat:@"%.2f亿",num/100000000.00];
//    }
//    return str;
//}
//
////去除字符串中的空格
//+ (NSString *)trimString:(NSString *)aString
//{
//    NSString *str = aString;
//    BOOL flag = YES;
//    while (flag)
//    {
//        NSRange range = [str rangeOfString:@" "];
//        if(range.location != NSNotFound)
//        {
//            str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
//            flag = YES;
//            continue;
//        }
//        else
//        {
//            flag = NO;
//            break;
//        }
//    }
//    return str;
//}
//
//
//#pragma mark -
//#pragma mark ---------------------------------------------- 消息推送及处理
////处理推送
//+ (void)handleRemoteNotificationWithType:(RemoteNotificationType)type      //推送类型
//                                   model:(RemoteNotificationModel *)model  //数据模型
//                                 jsonDic:(NSDictionary *)note              //从推送通知获取的初始数据
//{
//    //处理角标
//    [Methods handleAppIconBadgeWithType:type model:model];
//    
//    switch(type)
//    {
//        case RNT_ReceivedWhileAppActive:        //运行时收到推送消息 -----> 提示，显示 tab标签 红点，播放提示音
//        {
//            [Methods playSystemSound:1002];
//            [Methods show_txt_HUD:@"您有新的消息"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:NoReadMsgNotification object:nil userInfo:@{@"count":@"1"}];
//        }
//            break;
//        case RNT_ReceivedWhileAppInactive:      //APP未运行时收到推送消息 -----> 点击消息，打开APP后直接跳转到消息内容所指向的页面
//        case RNT_ReceivedWhileAppInBackground:  //后台收到推送消息 -----> 同上
//        {
//            [Methods playSystemSound:1002];
//            [[Methods appDelegate].rootTabBarVC setSelectedIndex:2];
//            [[NSNotificationCenter defaultCenter] postNotificationName:MyCenterNotification object:note];
//        }
//            break;
//    }
//}
////处理应用角标（未读数量）
//+ (void)handleAppIconBadgeWithType:(RemoteNotificationType)type model:(RemoteNotificationModel *)model
//{
//    switch(type)
//    {
//        case RNT_ReceivedWhileAppActive:        //收到通知时，APP处于运行状态
//        {
//            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//        }
//            break;
//        case RNT_ReceivedWhileAppInactive:      //收到通知时，APP未运行
//        case RNT_ReceivedWhileAppInBackground:  //收到通知时，APP处于后台
//        {
//            //int badge = (int)[UIApplication sharedApplication].applicationIconBadgeNumber;
//            //int curBadge = badge + [model.aps_badge intValue];
//            //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:curBadge];
//            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//        }
//            break;
//    }
//}
//
//
//#pragma mark -
////将形如@"2.6",@“0.4”且单位为：km 的距离描述转化成形如：@"2.6km",@"<500m"的字符串
//+ (NSString *)distanceStringWithDistance:(NSString *)distance
//{
//    float dist = [distance floatValue]*1000;
//    NSString *disStr = @"";
//    
//    if(dist >= 0 && dist < 100)
//        disStr = @"<100m";
//    else if(dist >= 100 && dist < 200)
//        disStr = @"<200m";
//    else if(dist >= 200 && dist < 300)
//        disStr = @"<300m";
//    else if(dist >= 300 && dist < 400)
//        disStr = @"<400m";
//    else if(dist >= 400 && dist < 500)
//        disStr = @"<500m";
//    else if(dist >= 500 && dist < 600)
//        disStr = @"<600m";
//    else if(dist >= 600 && dist < 700)
//        disStr = @"<700m";
//    else if(dist >= 700 && dist < 800)
//        disStr = @"<800m";
//    else if(dist >= 800 && dist < 900)
//        disStr = @"<900m";
//    else if(dist >= 900 && dist < 1000)
//        disStr = @"<1km";
//    else if(dist >= 1000)
//        disStr = [NSString stringWithFormat:@"%.2fkm",dist/1000.0];
//    else
//        disStr = @"error";
//    
//    return disStr;
//}
//
////将形如：@“350201,350202,350211” 这样的区域编码转化成形如：@"思明区,湖里区,同安区"的字符串
//+ (NSString *)areaNamesWithAreaIDString:(NSString *)areaIDString
//{
//    NSString *areaNames = @"";
//    if(areaIDString)
//    {
//        NSArray *ids = [areaIDString componentsSeparatedByString:@","];
//        
//        //一个 或 无 区域
//        if(ids.count == 1)
//        {
//            //一个区域
//            if(areaIDString.length > 0)
//            {
//                areaNames = [NSString stringWithFormat:@"%@",[AddressInfo areaNameWithAreaID:areaIDString]];
//            }
//            //无区域
//            else
//            {
//                areaNames = @"暂无区域";
//            }
//        }
//        //多个区域
//        else
//        {
//            for(NSString *anID in ids)
//            {
//                if([areaNames isEqualToString:@""])
//                {
//                    areaNames = [NSString stringWithFormat:@"%@",[AddressInfo areaNameWithAreaID:anID]];
//                }
//                else
//                {
//                    areaNames = [NSString stringWithFormat:@"%@,%@", areaNames, [AddressInfo areaNameWithAreaID:anID]];
//                }
//            }
//        }
//    }
//    return areaNames;
//}
//
//
////  0.未支付 --> 取消订单、去支付  --> 红色
////  1.待消费 --> 退款            --> 墨绿色
////  2.未点评 --> 去点评          --> 红色
////  3.已退款 --> 查看订单         --> 橘黄色
////  4.已取消 --> 查看订单、删除    --> 灰色
////  5.已点评 --> 查看订单         --> 灰色
//#ifndef RGB
//#define RGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a/1.0f]
//#endif
//#define PayStatusColor @[\
//RGB(240, 120, 120, 1),      \
//ZMXDefaultColor,        \
//RGB(100, 100, 100, 1),      \
//RGB(255, 177, 40, 1),       \
//[UIColor lightGrayColor]    \
//]
//+ (UIColor *)colorWithpayStatus:(NSString *)payStatus
//{
//    switch(payStatus.intValue)
//    {
//        case 0:  return PayStatusColor[0]; break;
//        case 1:  return PayStatusColor[1]; break;
//        case 2:  return PayStatusColor[0]; break;
//        case 3:  return PayStatusColor[3]; break;
//        case 4:  return PayStatusColor[2]; break;
//        case 5:  return PayStatusColor[2]; break;
//        case 6:  return PayStatusColor[0]; break;
//        case 7:  return PayStatusColor[0]; break;
//        default: return PayStatusColor[4]; break;
//    }
//}
//
//+ (UIView *)viewWithHeight:(CGFloat)height
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
//    view.backgroundColor = [UIColor clearColor];
//    return view;
//}
//+ (UIView *)tableHeaderWithHeight:(CGFloat)headerHeight
//{
//    UIView *header = [self viewWithHeight:headerHeight];
//    return header;
//}
//+ (UIView *)tableFooterWithHeight:(CGFloat)footerHeight
//{
//    UIView *footer = [self viewWithHeight:footerHeight];
//    return footer;
//}
//
//+ (void)disposeArray:(id)anArray
//{
//    if([anArray isKindOfClass:[NSMutableArray class]])
//    {
//        [anArray removeAllObjects];
//        anArray = nil;
//    }
//    if([anArray isKindOfClass:[NSArray class]])
//    {
//        anArray = nil;
//    }
//}
//
//
//+ (void)setNetworkTypeWithIndex:(int)index
//{
//    switch(index)
//    {
//        case 1:
//        {
//            [Methods setObject:ZmxRootPath_1 forKey:NetWorkTypeKey1];
//            [Methods setObject:ZmxRootPicPath_1 forKey:NetWorkTypeKey2];
//        }
//            break;
//        case 2:
//        {
//            [Methods setObject:ZmxRootPath_2 forKey:NetWorkTypeKey1];
//            [Methods setObject:ZmxRootPicPath_2 forKey:NetWorkTypeKey2];
//        }
//            break;
//        case 3:
//        {
//            [Methods setObject:ZmxRootPath_3 forKey:NetWorkTypeKey1];
//            [Methods setObject:ZmxRootPicPath_3 forKey:NetWorkTypeKey2];
//        }
//            break;
//        case 4:
//        {
//            [Methods setObject:ZmxRootPath_4 forKey:NetWorkTypeKey1];
//            [Methods setObject:ZmxRootPicPath_4 forKey:NetWorkTypeKey2];
//        }
//            break;
//    }
//    
//    [Methods displayDXAlertView:[NSString stringWithFormat:@"%@",[Methods getNetworkWithIndex:1]]];
//}
//+ (NSString *)getNetworkWithIndex:(int)index
//{
//    if(index == -1)
//    {
//        return ZmxRootPath_4;
//    }
//    else if(index == -2)
//    {
//        return ZmxRootPicPath_4;
//    }
//    else if(index == 1)
//    {
//        NSString *str = [Methods objectForKey:NetWorkTypeKey1];
//        if(str == nil)
//        {
//            str = ZmxRootPath_4;
//        }
//        return str;
//    }
//    else if(index == 2)
//    {
//        NSString *str = [Methods objectForKey:NetWorkTypeKey2];
//        if(str == nil)
//        {
//            str = ZmxRootPicPath_4;
//        }
//        return str;
//    }
//    else
//    {
//        return @"";
//    }
//}
//
//+ (void)showNetWorkSettingActionSheet
//{
//    PDYActionSheet *networkSelector = [[PDYActionSheet alloc] initWithTitle:@"网络切换"
//                                                                  cancelBtn:@"取消"
//                                                             destructiveBtn:@"内网1"
//                                                               otherButtons:@[@"内网2", @"测试外网", @"正式外网"]];
//    networkSelector.clickedButtonAtIndex = ^(int btnIndex)
//    {
//        int INDEX = -1;
//        switch(btnIndex)
//        {
//            case 0: INDEX = 1; break;
//            case 2: INDEX = 2; break;
//            case 3: INDEX = 3; break;
//            case 4: INDEX = 4; break;
//            default:           break;
//        }
//        if(INDEX != -1)
//        {
//            [Methods setNetworkTypeWithIndex:INDEX];
//        }
//    };
//    [networkSelector showInView:[UIApplication sharedApplication].keyWindow];
//}
//
////添加删除线 ( 仅限单行，多行用富文本 )
//+ (void)deleteLineForLabel:(UILabel *)label options:(id)options
//{
//    UILabel *line = [[UILabel alloc] init];
//    
//    NSString *offSet    = (options[@"OffSet"]  ? options[@"OffSet"]  : @"1");
//    if(label.text.length == 0)
//    {
//        offSet = @"0";
//    }
//    UIColor *lineColor  = (options[@"Color"]   ? options[@"Color"]   : [UIColor grayColor]);
//    
//    CGRect f = [label.text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, label.frame.size.height)
//                                        options:NSStringDrawingTruncatesLastVisibleLine
//                                     attributes:@{NSFontAttributeName : label.font}
//                                        context:NULL];
//    
//    line.frame = CGRectMake(- offSet.floatValue, label.frame.size.height/2.0, f.size.width + (2 * offSet.floatValue), 0.6);
//    line.backgroundColor = lineColor;
//    
//    [label addSubview:line];
//    
//    lineColor = nil;
//}
//
////登录加密 -（ 传入 登录名、密码 ）
//+ (NSString *)loginSafeStringWithParams:(id)params
//{
//    NSString *content   = [NSString stringWithFormat:@"%@:%@", params[@"loginName"], params[@"loginPassword"]];
//    
//    static NSString *pkey   = @"2GFO9$S2L#K58HI0";
//    NSString *ukey          = [NSString genRandomStringForLength:6];
//    NSString *seed          = [[[[pkey stringByAppendingString:ukey] md5] uppercaseString] substringWithRange:NSRangeFromString(@"0,16")];
//    NSData *encryptedData   = [[content dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:seed];
//    NSString *safeString    = [[encryptedData hexadecimalString] stringByAppendingString:ukey];
//    
//    return safeString;
//}
//
//
////虚线
//+ (UIImage *)xuxianForImageView:(UIImageView *)imgView
//{
//    UIGraphicsBeginImageContext(imgView.frame.size);   //开始画线
//    [imgView.image drawInRect:imgView.bounds];
//    
//    CGFloat lengths[] = {8, 4}; //实线 与 空白 的宽度
//    CGContextRef line = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(line, [UIColor grayColor].CGColor); //线条颜色
//    
//    CGContextSetLineDash(line, 0, lengths, 2);      //虚线的样式
//    CGContextSetLineWidth(line, 0.5);                 //线宽
//    CGContextSetLineCap(line, kCGLineCapRound);     //设置线条终点形状
//    //CGContextSetLineJoin(line, kCGLineJoinBevel);
//    CGContextMoveToPoint(line, 0.0, 0.0);           //线的起点 (0.0, 1.0)
//    
//    if(imgView.frame.size.width > imgView.frame.size.height)
//    {
//        CGContextAddLineToPoint(line, imgView.frame.size.width, 1.0);  //画线，从点(0.0, 1.0) 到 点(310, 1.0) 的一条虚线
//    }
//    else
//    {
//        CGContextAddLineToPoint(line, 0.0, imgView.frame.size.height);  //画线，从点(0.0, 1.0) 到 点(310, 1.0) 的一条虚线
//    }
//    
//    CGContextStrokePath(line);
//    
//    return UIGraphicsGetImageFromCurrentImageContext();
//}
//
//+ (CLAuthorizationStatus)locationAuthorizationStatus
//{
//    return [CLLocationManager authorizationStatus];
//}
//+ (void)alertLocationUnavailable
//{
//    [Methods displayDXAlertView:@"定位服务已关闭，可通过“设置 - 隐私 - 定位服务”开启定位服务"];
//}
//
//
//
//
//#pragma mark - 监听键盘
//+ (void)addKeyboardNotification:(id)observer
//{
//    //[self removeKeyboardNotification:observer];
//    //[[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    //[[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//}
//+ (void)removeKeyboardNotification:(id)observer
//{
//    //[[NSNotificationCenter defaultCenter] removeObserver:observer name:UIKeyboardWillShowNotification object:nil];
//    //[[NSNotificationCenter defaultCenter] removeObserver:observer name:UIKeyboardWillHideNotification object:nil];
//}
//
//#pragma mark - 是否刷新数据
//+ (BOOL)shouldRefresh
//{
//    id flag = [[NSUserDefaults standardUserDefaults] objectForKey:@"ListViewShouldRefresh"];
//    if(flag)
//    {
//        return [flag boolValue];
//    }
//    else
//    {
//        return NO;
//    }
//}
//+ (void)setRefresh:(BOOL)refresh
//{
//    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:refresh] forKey:@"ListViewShouldRefresh"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
//
//+ (void)showQRViewerWithImage:(UIImage *)image
//{
//    PDYQRCodeView *qrView = [PDYQRCodeView viewerWithImage:image];
//    
//    UIWindow *window = [Methods window];
//    [window addSubview:qrView];
//    
//    [qrView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [window addConstraint:[NSLayoutConstraint constraintWithItem:qrView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
//    [window addConstraint:[NSLayoutConstraint constraintWithItem:qrView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
//    [window addConstraint:[NSLayoutConstraint constraintWithItem:qrView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
//    [window addConstraint:[NSLayoutConstraint constraintWithItem:qrView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:window attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        qrView.alpha = 1.0f;
//    } completion:^(BOOL finished) {
//        
//    }];
//}
//
//@end



@end
