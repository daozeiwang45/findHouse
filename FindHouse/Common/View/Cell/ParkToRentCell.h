//
//  ParkToRentCell.h
//  FindHouse
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"

@interface ParkToRentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NMRangeSlider *singleSlider;
@property (weak, nonatomic) IBOutlet NMRangeSlider *rangeSlider;
@property (strong, nonatomic)  UILabel *lowerLbl;
@property (strong, nonatomic)  UILabel *higherLbl;
@property (strong, nonatomic)  UILabel *rangeLowL;
@property (strong, nonatomic)  UILabel *rangeHighL;

- (IBAction)singleSliderAction:(NMRangeSlider *)sender;
- (IBAction)rangeSliderAction:(NMRangeSlider *)sender;

@end
