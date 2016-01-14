//
//  BaseViewController.h
//  FindHouse
//
//  Created by admin on 15/12/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property(nonatomic, assign)BOOL isModal;

#pragma mark --------- 页面温馨提醒
-(void)showErrorWithString:(NSString *)str;
-(void)showSuccessWithString:(NSString *)str;

@end
