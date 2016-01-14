//
//  HomeHeader.h
//  FindHouse
//
//  Created by Tom on 15/12/21.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCycleScrollView;
@interface HomeHeader : UIView
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleView;
@property (weak, nonatomic) IBOutlet UIButton *preBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet UIView *rentBgV; //千房租售
@property (weak, nonatomic) IBOutlet UIView *zhufangV;
@property (weak, nonatomic) IBOutlet UIView *officeV;
@property (weak, nonatomic) IBOutlet UIView *parkingV;
@property (weak, nonatomic) IBOutlet UIView *shopV;
@property (weak, nonatomic) IBOutlet UIView *storageV;
@property (weak, nonatomic) IBOutlet UIView *factoryV;

@end
