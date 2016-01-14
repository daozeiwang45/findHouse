//
//  RechargeViewController.h
//  FindHouse
//
//  Created by admin on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    Success=0,
    Failure
    
}PayStatus;
@interface RechargeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *aliPayBtn; // 支付宝
@property (weak, nonatomic) IBOutlet UIButton *wePayBtn; // 微支付
@property (weak, nonatomic) IBOutlet UITextField *inputTf; // 金额输入框
@property (weak, nonatomic) IBOutlet UIButton *certainBtn;

//
@property (strong, nonatomic) IBOutlet UIView *payStatusView;
@property (assign, nonatomic) PayStatus paySituation;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl; //成功失败
@property (weak, nonatomic) IBOutlet UILabel *receiveOrnotLbl;
@property (weak, nonatomic) IBOutlet UILabel *guideLbl; // 引导
@property (weak, nonatomic) IBOutlet UIButton *keepRechargeBtn; // 继续充值
@property (weak, nonatomic) IBOutlet UIButton *accountBtn; // 账户
@property (weak, nonatomic) IBOutlet UIButton *memberCenterBtn; //会员中心按钮

@end
