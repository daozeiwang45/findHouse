//
//  RechargeViewController.m
//  FindHouse
//
//  Created by admin on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()

@end

@implementation RechargeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self) {
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"充值";
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
    _paySituation = Failure;
    [_certainBtn addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)checkAction {
    
    self.payStatusView.backgroundColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:.75];
    self.payStatusView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_payStatusView];
    _typeLbl.font = [UIFont systemFontOfSize:15];
    _typeLbl.textColor = UIColorFromRGB(0x9D0006);
    _receiveOrnotLbl.font = [UIFont systemFontOfSize:14];
    _receiveOrnotLbl.textColor = [UIColor lightGrayColor];
    _guideLbl.font = [UIFont systemFontOfSize:14];
    _guideLbl.textColor = [UIColor lightGrayColor];
    
    if (_paySituation == Success) {
        //        _imgV.image = [UIImage imageNamed:@""];
        _typeLbl.text = @"充值成功！";
        _receiveOrnotLbl.text = @"充值的金额已到账";
        _guideLbl.text = @"现在您可以继续一下操作";
    }else{
        //        _imgV.image = [UIImage imageNamed:@""];
        _typeLbl.text = @"充值失败~";
        _receiveOrnotLbl.text = @"充值的金额未到账，请重新操作";
        _guideLbl.text = @"现在您可以继续以下操作";
    }
    
    [_keepRechargeBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_accountBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_memberCenterBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

}

// 支付状态 view 按钮事件
- (void)buttonAction:(UIButton *)btn {
    if (btn.tag == 1) {
        [_payStatusView removeFromSuperview];
        
    }else if (btn.tag == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 3) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
