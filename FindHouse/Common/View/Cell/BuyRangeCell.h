//
//  BuyRangeCell.h
//  FindHouse
//
//  Created by Tom on 15/12/28.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMRangeSlider.h"

@interface BuyRangeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NMRangeSlider *distanceSlider;
@property (strong, nonatomic) UILabel *lowLbl;
@property (strong, nonatomic) UILabel *highLbl;

@property (weak, nonatomic) IBOutlet NMRangeSlider *priceSlider;
@property (strong, nonatomic) UILabel *lowPriceLBL;
@property (strong, nonatomic) UILabel *highPriceLbl;

- (IBAction)distanceValueAction:(NMRangeSlider *)sender;
- (IBAction)priceValueAction:(id)sender;

@end
