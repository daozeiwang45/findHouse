//
//  PriceRangeCell.h
//  FindHouse
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"

@interface PriceRangeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NMRangeSlider *singleSlider;
@property (weak, nonatomic) IBOutlet NMRangeSlider *rangeSlider;
@property (strong, nonatomic)  UILabel *lowerLbl;
@property (strong, nonatomic)  UILabel *higherLbl;
@property (strong, nonatomic)  UILabel *rangeLowL;
@property (strong, nonatomic)  UILabel *rangeHighL;

- (IBAction)singleValueAction:(NMRangeSlider *)sender;
- (IBAction)rangeValueAction:(NMRangeSlider *)sender;

@end
