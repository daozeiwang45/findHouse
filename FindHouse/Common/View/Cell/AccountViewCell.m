//
//  AccountViewCell.m
//  FindHouse
//
//  Created by admin on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AccountViewCell.h"

@implementation AccountViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconIV.backgroundColor = [UIColor greenColor];
    _itemLbl.font = [UIFont systemFontOfSize:15];
    _numLbl.font = [UIFont systemFontOfSize:13];
    _numLbl.textColor = [UIColor orangeColor];
    
}

@end
