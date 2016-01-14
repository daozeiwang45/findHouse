//
//  ResultCell.m
//  FindHouse
//
//  Created by admin on 15/12/25.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "ResultCell.h"

@implementation ResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _shadowView.layer.shadowRadius = 6.0;
    _shadowView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    _shadowView.layer.shadowOpacity = 1.0;
    _bgView.layer.cornerRadius = 6.0;
    _bgView.layer.masksToBounds = YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
