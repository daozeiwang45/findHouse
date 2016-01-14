//
//  ModifyMyPhoneViewController.m
//  kang
//
//  Created by WSGG on 15/11/18.
//  Copyright © 2015年 XJY. All rights reserved.
//

#import "ModifyMyPhoneViewController.h"

@interface ModifyMyPhoneViewController ()

@end

@implementation ModifyMyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"修改手机绑定";
    [self initValueAndView];
    
}
-(void)initValueAndView{
    
    [self.getCodeButton.layer setBorderColor:ButtonColor.CGColor];
    [self.getCodeButton.layer setBorderWidth:1.0];
    self.oldPhoneField.userInteractionEnabled = NO;
    self.oldPhoneField.text = self.phoneNumStr;
}

- (IBAction)getCodeAction:(UIButton *)sender {
    
    if ([Methods CheckPhoneNumInput:self.phoneField.text]) {
        
        [self webGetCodeData];
        [Methods startCodeTime:30 sendAuthCodeBtn:sender];//验证码时间
        //设置按钮不可点击
        sender.userInteractionEnabled = NO;
        
    }else{
        
        [self showErrorWithString:@"请输入正确的手机号码！"];
    }
}


- (IBAction)svaeButtonAction:(UIButton *)sender {
    
    if ([self checkValue]) {
        
        [self webModifyMemberNickInfo];
    }
}

-(BOOL)checkValue{
    
    if (self.phoneField.text.length < 11) {
        
        [SVProgressHUD showErrorWithStatus:@"手机号不能少于11位"];
        return NO;
    }
    if (self.codeField.text.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"验证吗不能为空！"];
        return NO;
    }
    
    return YES;
}

#pragma mark ------------网络请求验证码
-(void)webGetCodeData
{
    NSString *source = [NSString stringWithFormat:@"phone_num=%@&use_type=%@",self.phoneField.text,@"MODINFO"];
    [MyThemeWebModel BlockWithURL:[NSString stringWithFormat:@"%@%@",URLPrefix,GetCodeURL] withSource:source withBlock:^(NSDictionary *results)
     {
         NSLog(@"------网络请求结果----%@------",results);
         if ([results[@"state"] intValue] == 1 )
         {
             NSLog(@"获取验证码成功");
         }else if([results[@"state"] intValue] == 101){
             
             //[SVProgressHUD showErrorWithStatus:@"该号码已注册!"];
             [self showErrorWithString:@"该号码没有注册!"];
         }else{
             
             [self showErrorWithString:results[@"message"]];
             //[SVProgressHUD showSuccessWithStatus:results[@"message"]];
         }
         
         
     }];
    
}


#pragma mark --------- 网络修改个人信息绑定手机号
-(void)webModifyMemberNickInfo{
    
//    NSString *source = [NSString stringWithFormat:@"modify_type=%@&phone_num=%@&phone_code=%@&token=%@",@"bind_phone",self.phoneField.text,self.codeField.text,[self getMyToken]];
//    [MyThemeWebModel BlockWithURL:[NSString stringWithFormat:@"%@%@",URLPrefix,ModifyMemberNickURL] withSource:source withBlock:^(NSDictionary *results)
//     {
//         NSLog(@"------网络请求结果----%@------",results);
//         if ([results[@"state"] intValue] == 1 )
//         {
//             [SVProgressHUD showSuccessWithStatus:@"手机绑定修改成功！"];
//             [self.navigationController popViewControllerAnimated:YES];
//             
//         }else{
//             
//             [self showErrorWithString:results[@"message"]];
//         }
//         
//         
//     }];
    
    
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
