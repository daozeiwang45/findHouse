//
//  ContactLandlordView.m
//  FindHouse
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ContactLandlordView.h"

@implementation ContactLandlordView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
    
}

- (void)initUI {
    
    self.backgroundColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:.75];
    UITapGestureRecognizer *tapGZ = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeAction)];
    [self addGestureRecognizer:tapGZ];
}

- (void)removeAction {
    
    [self.superview removeFromSuperview];
}

@end
