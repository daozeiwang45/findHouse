//
//  OfficeFilterCell.m
//  FindHouse
//
//  Created by admin on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "OfficeFilterCell.h"

@implementation OfficeFilterCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    _certainBtn.layer.cornerRadius = 3;
    _certainBtn.layer.masksToBounds = YES;
    _certainBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _certainBtn.layer.borderWidth = 1.0;

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
