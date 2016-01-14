//
//  HouseFilterCell.m
//  FindHouse
//
//  Created by admin on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HouseFilterCell.h"

@implementation HouseFilterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for (UIButton *btn in self.contentView.subviews) {
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 1.0;
    
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
