//
//  ModifyMyPhoneViewController.h
//  kang
//
//  Created by WSGG on 15/11/18.
//  Copyright © 2015年 XJY. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyMyPhoneViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIButton *getCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;

@property (weak, nonatomic) IBOutlet UITextField *oldPhoneField;
@property (strong,nonatomic)NSString *phoneNumStr;
@end
