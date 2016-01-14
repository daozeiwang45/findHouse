//
//  HoemCell.m
//  FindHouse
//
//  Created by Tom on 15/12/20.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    _shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _shadowView.layer.shadowRadius = 6.0;
    _shadowView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    _shadowView.layer.shadowOpacity = 1.0;
    _bgView.layer.cornerRadius = 6.0;
    _bgView.layer.masksToBounds = YES;

}


@end
