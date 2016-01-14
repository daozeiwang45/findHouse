//
//  WithdrawViewController.m
//  FindHouse
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WithdrawViewController.h"
#import "bxViewAdditions.h"
#import "BankCardViewController.h"

@interface WithdrawViewController ()

@end

@implementation WithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提现";
    
     hasAdd = NO;
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
    [_aliPayBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [_aliPayBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [_aliPayBtn addTarget:self action:@selector(aliPayBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _aliPayBtn.selected = YES;
    [_bankCardBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [_bankCardBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [_bankCardBtn addTarget:self action:@selector(bankCardBtnAction) forControlEvents:UIControlEventTouchUpInside];
    _bankCardBtn.selected = NO;
    
   // addbtn
    [_addBtn addTarget:self action:@selector(addBankCardAction) forControlEvents:UIControlEventTouchUpInside];
    // submit BTN
    [_submitBtn addTarget:self action:@selector(showWithdrawView) forControlEvents:UIControlEventTouchUpInside];
    [self showCardView];
    
}

//MARK: private method
- (void)showCardView {
    
    if (_aliPayBtn.selected == YES) {
        _cardViewH.constant = 0;
        _unAddView.hidden = YES;
        _cardView.hidden = YES;
    }else if (_bankCardBtn.selected == YES) {
        _cardViewH.constant = 75;
        if (hasAdd == YES) {
            _cardView.width = kSCREEN_W;
            [self.unAddView addSubview:_cardView];
        }        
    }
}

- (void)aliPayBtnAction {
    
    if (_aliPayBtn.selected == NO) {
        _bankCardBtn.selected = NO;
        _cardViewH.constant = 0;
        _unAddView.hidden = YES;
        _cardView.hidden = YES;
    }
    _aliPayBtn.selected = !_aliPayBtn.selected;
    
}
// 银行卡选择按钮
- (void)bankCardBtnAction {
    
    if (_bankCardBtn.selected == NO) {
        _aliPayBtn.selected = NO;
        _cardViewH.constant = 75;
        _unAddView.hidden = NO;
        _cardView.hidden = NO;
        if (hasAdd == YES) {
            _cardView.width = kSCREEN_W;
            [self.unAddView addSubview:_cardView];
        }
    }
    _bankCardBtn.selected = !_bankCardBtn.selected;
}

// 添加银行卡
- (void)addBankCardAction {
    BankCardViewController *bankCardVC = [[BankCardViewController alloc] initWithNibName:@"BankCardViewController" bundle:nil];
    [self.navigationController pushViewController:bankCardVC animated:YES];
}

// 提交申请 弹出VIEW
- (void)showWithdrawView {
    
    self.withdrawView.backgroundColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:.75];
    self.withdrawView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:_withdrawView];
    _withdrawLbl.font = [UIFont systemFontOfSize:15];
    _withdrawLbl.textColor = UIColorFromRGB(0x9D0006);
    _promptLbl.font = [UIFont systemFontOfSize:14];
    _promptLbl.textColor = [UIColor lightGrayColor];
    _guideLbl.font = [UIFont systemFontOfSize:14];
    _guideLbl.textColor = [UIColor lightGrayColor];
    [_keepWithdrawBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_accountBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_memberCenter addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)buttonAction:(UIButton *)btn {
    if (btn.tag == 1) {
        [_withdrawView removeFromSuperview];
        
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
