//
//  AddBankCardViewController.h
//  FindHouse
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface AddBankCardViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *ownerNameTF;
@property (weak, nonatomic) IBOutlet UILabel *showCheck; // 是否验证提示文字
@property (weak, nonatomic) IBOutlet UIImageView *bankIcon; // 银行图标
@property (weak, nonatomic) IBOutlet UILabel *bankName; // 银行名称
@property (weak, nonatomic) IBOutlet UILabel *cardType; // 银行卡类型
@property (weak, nonatomic) IBOutlet UIImageView *accessoryIV; // 辅助图标
@property (weak, nonatomic) IBOutlet UITextField *cardNumTF;
@property (weak, nonatomic) IBOutlet UIButton *btnToChoose; // 选择银行卡信息
@property (weak, nonatomic) IBOutlet UIButton *sureAddBtn;


// 添加蒙版
@property (strong, nonatomic) IBOutlet UIView *addMask;
@property (weak, nonatomic) IBOutlet UIImageView *addIv;
@property (weak, nonatomic) IBOutlet UILabel *successLbl;
@property (weak, nonatomic) IBOutlet UILabel *guideLbl;
@property (weak, nonatomic) IBOutlet UIButton *keepAddBtn;
@property (weak, nonatomic) IBOutlet UIButton *bankCardBtn;
@property (weak, nonatomic) IBOutlet UIButton *memberCenter;


@end
