//
//  ShopResultViewController.h
//  FindHouse
//
//  Created by Tom on 16/1/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface ShopResultViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentSection;
    NSInteger btnSection;
    CGRect rect;
}

@property (nonatomic, assign) Kind houseKind;

@end
