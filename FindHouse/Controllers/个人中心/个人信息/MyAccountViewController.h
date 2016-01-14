//
//  MyAccountViewController.h
//  FindHouse
//
//  Created by 许景源 on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface MyAccountViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
@property (weak, nonatomic) IBOutlet UIView *alerdayCitifyView;
@property (weak, nonatomic) IBOutlet UIView *unCitifyView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLab;
@property (weak, nonatomic) IBOutlet UIView *citifyButtonView;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *sexLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *ThreeFangLab;
@property (weak, nonatomic) IBOutlet UIButton *operateButton;

@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *offThreeButton;
@property (weak, nonatomic) IBOutlet UILabel *offThreeLineLab;
@property (weak, nonatomic) IBOutlet UIImageView *sexImgView;
@property (weak, nonatomic) IBOutlet UIButton *modifyPhoneButton;
@property (weak, nonatomic) IBOutlet UILabel *modifyPhoneLineLab;

@property (strong, nonatomic) IBOutlet UIView *successContentView;



@property (assign,nonatomic)BOOL isCitify;//是否实名认证了
@property (assign,nonatomic)BOOL isModify;//是否是修改页面

@end
