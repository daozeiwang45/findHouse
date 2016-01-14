//
//  SearchHouseViewController.h
//  FindHouse
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HMSegmentedControl.h"

@interface SearchHouseViewController : BaseViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (strong, nonatomic) HMSegmentedControl *segCtrl;

@end
