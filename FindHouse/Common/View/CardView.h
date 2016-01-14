//
//  CardView.h
//  FindHouse
//
//  Created by admin on 15/12/26.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSLCardView.h"

@interface CardView : YSLCardView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (nonatomic, strong) UIView *selectedView;

@end
