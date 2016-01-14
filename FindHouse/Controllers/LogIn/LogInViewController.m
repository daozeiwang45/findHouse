//
//  LogInViewController.m
//  FindHouse
//
//  Created by admin on 15/12/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "LogInViewController.h"
#import "LineTextfield.h"
#import "bxViewAdditions.h"
#import "RegisterViewController.h"
#import "ForgetViewController.h"

@interface LogInViewController ()
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn; // 取消按钮
@property (weak, nonatomic) IBOutlet UIImageView *logoIV; //LOGO IMAGE
@property (weak, nonatomic) IBOutlet UIView *inputView; // inputview
@property (weak, nonatomic) IBOutlet UIImageView *accountIV; // 账户头像
@property (weak, nonatomic) IBOutlet UIImageView *passwdIV; // 密码图像
@property (weak, nonatomic) IBOutlet LineTextfield *accountTF; // 账号输入框
@property (weak, nonatomic) IBOutlet LineTextfield *pwdTF; // 密码输入框

@property (weak, nonatomic) IBOutlet UIButton *registerBtn; // 注册按钮
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn; // 忘记密码
@property (weak, nonatomic) IBOutlet UIButton *loginBtn; //  登入按钮
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;//QQ登入
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn; // wechat 登入


@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 输入框
    _accountTF.delegate = self;
    _pwdTF.delegate = self;
    _accountTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    _accountTF.textColor = [UIColor brownColor];
    _pwdTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"登录密码" attributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
    _pwdTF.textColor = [UIColor brownColor];
    // hide-show
    UIButton *eyeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _pwdTF.height, _pwdTF.height)];
    eyeButton.backgroundColor = [UIColor blackColor]; // 鱼眼
    [eyeButton setImage:[UIImage imageNamed:@"eye_hide"] forState:UIControlStateNormal];
    [eyeButton setImage:[UIImage imageNamed:@"eye_show"] forState:UIControlStateSelected];
    [eyeButton addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
    _pwdTF.rightView = eyeButton;
    _pwdTF.rightViewMode = UITextFieldViewModeWhileEditing;
    // 账号注册  忘记密码 按钮
    [_registerBtn addTarget:self action:@selector(changeToRegister:) forControlEvents:UIControlEventTouchUpInside];
    [_forgetBtn addTarget:self action:@selector(changeToRegister:) forControlEvents:UIControlEventTouchUpInside];
    
}

//MARK: Private
//鱼眼
- (void)eyeAction:(UIButton*)sender {
    sender.selected = !sender.selected;
    _pwdTF.secureTextEntry = !sender.selected;
}
// 跳转注册页面
- (void)changeToRegister:(UIButton *)sender {
    if (sender.tag == 101) {
        RegisterViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"registerVC"];
        [self presentViewController:registerVC animated:YES completion:nil];
    }else if (sender.tag == 102) {
        ForgetViewController *forgetVC = [self.storyboard instantiateViewControllerWithIdentifier:@"forgetVC"];
        [self presentViewController:forgetVC animated:YES completion:nil];
    }
}

//MARK: UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _pwdTF)
    {
        UIButton *eyeButton = (UIButton*)_pwdTF.rightView;
        eyeButton.selected = NO;
        _pwdTF.secureTextEntry = YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _accountTF)
    {
        [_pwdTF becomeFirstResponder];
        return NO;
    }
    else
    {
        [_pwdTF resignFirstResponder];
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
