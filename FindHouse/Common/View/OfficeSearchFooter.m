//
//  OfficeSearchFooter.m
//  FindHouse
//
//  Created by Tom on 16/1/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "OfficeSearchFooter.h"

@implementation OfficeSearchFooter
- (void)awakeFromNib {
    
    [super awakeFromNib];
    _distanceLbl.font = [UIFont systemFontOfSize:12];
    _souResultLbl.font = [UIFont systemFontOfSize:17];
    _souResultLbl.textColor = UIColorFromRGB(0x960000);
    _recmdLbl.font = [UIFont systemFontOfSize:17];
    _recmdLbl.textColor = UIColorFromRGB(0x960000);
    _unitLbl1.font = [UIFont systemFontOfSize:12];
    _unitLbl2.font = [UIFont systemFontOfSize:12];
    _typeLbl.font = [UIFont systemFontOfSize:12];
}

@end
