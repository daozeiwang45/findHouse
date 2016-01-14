//
//  UncheckAlertView.m
//  FindHouse
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UncheckAlertView.h"

@implementation UncheckAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
   
}

- (void)initUI {
    
    self.backgroundColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:.75];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"立即前往验证 >"];
    NSRange strRange = {0,str.length};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:255/255.0 green:225/255.0 blue:0/255.0 alpha:1]} range:strRange];
    [_willCheckBtn setAttributedTitle:str forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(removeAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)removeAction {
    
    [self.superview removeFromSuperview];
}
@end
