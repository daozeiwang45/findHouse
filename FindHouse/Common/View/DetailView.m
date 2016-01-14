//
//  DetailView.m
//  FindHouse
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setTopToRent:(NSLayoutConstraint *)topToRent {
    _topToRent = topToRent;
    [self layoutIfNeeded];
    
}
- (void)setTopToSale:(NSLayoutConstraint *)topToSale {
    _topToSale = topToSale;
    [self layoutIfNeeded];
}


@end
