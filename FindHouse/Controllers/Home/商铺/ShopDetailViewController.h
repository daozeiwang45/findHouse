//
//  ShopDetailViewController.h
//  FindHouse
//
//  Created by admin on 16/1/9.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

@class SDCycleScrollView;
@interface ShopDetailViewController : BaseViewController
{
    BOOL isChecked;
}
@property (assign, nonatomic) Kind houseKind;
@property (strong, nonatomic) SDCycleScrollView *banner;
@property (strong, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UIView *rentV;
@property (weak, nonatomic) IBOutlet UIView *saleV;
@property (weak, nonatomic) IBOutlet UIView *commentSection;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToRent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToSale;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHc;


@end
