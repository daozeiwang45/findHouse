//
//  HospitalMealTableViewCell.h
//  kang
//
//  Created by WSGG on 15/11/19.
//  Copyright © 2015年 XJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalMealTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mealImgeView;
@property (weak, nonatomic) IBOutlet UILabel *mealTittleLab;
@property (weak, nonatomic) IBOutlet UILabel *admireLab;
@property (weak, nonatomic) IBOutlet UILabel *payNumLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressHight;



@end
