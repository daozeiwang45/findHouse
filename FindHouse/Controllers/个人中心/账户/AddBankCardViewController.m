//
//  AddBankCardViewController.m
//  FindHouse
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AddBankCardViewController.h"
#import "bxViewAdditions.h"

@interface AddBankCardViewController ()

@end

@implementation AddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加银行卡";
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
    [self initUI];
    
}

- (void)initUI {
    _ownerNameTF.font = [UIFont systemFontOfSize:14];
    _showCheck.font = [UIFont systemFontOfSize:12];
    _showCheck.textColor = [UIColor lightGrayColor];
    _showCheck.hidden = YES;
    _bankIcon.image = [UIImage imageNamed:@"cancel"];
    _bankName.text = @"农业银行";
    _bankName.font = [UIFont systemFontOfSize:15];
    _cardType.text = @"借记卡";
    _cardType.font = [UIFont systemFontOfSize:13];
    _cardNumTF.font = [UIFont systemFontOfSize:14];
    _cardNumTF.placeholder = @"请输入银行卡号";
    [_sureAddBtn addTarget:self action:@selector(showAddMask) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)showAddMask {
    
    [[NSUserDefaults standardUserDefaults] setObject:_ownerNameTF.text forKey:@"ownerName"];
    [[NSUserDefaults standardUserDefaults] setObject:_bankName.text forKey:@"bankName"];
    [[NSUserDefaults standardUserDefaults] setObject:_cardType.text forKey:@"cardType"];
    [[NSUserDefaults standardUserDefaults] setObject:_cardNumTF.text forKey:@"cardNum"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.addMask.backgroundColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:.75];
    self.addMask.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_addMask];
    _successLbl.font = [UIFont systemFontOfSize:15];
    _successLbl.textColor = UIColorFromRGB(0x9D0006);
    _guideLbl.font = [UIFont systemFontOfSize:14];
    _guideLbl.textColor = [UIColor lightGrayColor];
    [_keepAddBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bankCardBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_memberCenter addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

// 支付状态 view 按钮事件
- (void)buttonAction:(UIButton *)btn {
    if (btn.tag == 1) {
        [_addMask removeFromSuperview];
        _ownerNameTF.text = @"";
        _cardNumTF.text = @"";
        
    }else if (btn.tag == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 3) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
