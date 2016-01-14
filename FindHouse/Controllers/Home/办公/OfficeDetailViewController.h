//
//  OfficeDetailViewController.h
//  FindHouse
//
//  Created by admin on 16/1/9.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

@class SDCycleScrollView;
@interface OfficeDetailViewController : BaseViewController
{
    BOOL isChecked;
}

@property (strong, nonatomic) SDCycleScrollView *banner;
@property (strong, nonatomic) IBOutlet UIView *header; // 头视图
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToRent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToSale;
@property (weak, nonatomic) IBOutlet UIView *rentV;
@property (weak, nonatomic) IBOutlet UIView *saleV;
@property (weak, nonatomic) IBOutlet UIView *commentSection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHc;


@property (assign, nonatomic) Kind houseKind;


@end
