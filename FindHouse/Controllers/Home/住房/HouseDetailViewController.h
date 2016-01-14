//
//  HouseDetailViewController.h
//  FindHouse
//
//  Created by admin on 15/12/25.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"

@class SDCycleScrollView;
@interface HouseDetailViewController : BaseViewController
{
    BOOL isChecked;
}
@property (strong, nonatomic) SDCycleScrollView *banner;
@property (assign, nonatomic) Kind houseKind;

@end
