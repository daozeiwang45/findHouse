//
//  WithdrawViewController.h
//  FindHouse
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface WithdrawViewController : BaseViewController
{
    BOOL hasAdd;
    BOOL isCard;
}

@property (weak, nonatomic) IBOutlet UIButton *aliPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankCardBtn;

@property (weak, nonatomic) IBOutlet UIView *unAddView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

// 银行卡按钮
@property (strong, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UIImageView *bankIcon;//银行图标
@property (weak, nonatomic) IBOutlet UILabel *bankName; //银行名称
@property (weak, nonatomic) IBOutlet UILabel *cardInfo; // 卡信息
@property (weak, nonatomic) IBOutlet UIButton *cardBtn; // 显示银行卡时 按钮
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardViewH;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn; // 提交申请

//======提现成功 视图=====
@property (strong, nonatomic) IBOutlet UIView *withdrawView;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *withdrawLbl;
@property (weak, nonatomic) IBOutlet UILabel *promptLbl;
@property (weak, nonatomic) IBOutlet UILabel *guideLbl;
@property (weak, nonatomic) IBOutlet UIButton *keepWithdrawBtn; // 继续提现
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;
@property (weak, nonatomic) IBOutlet UIButton *memberCenter;



@end
