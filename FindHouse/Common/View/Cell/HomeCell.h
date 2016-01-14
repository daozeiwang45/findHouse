//
//  HoemCell.h
//  FindHouse
//
//  Created by Tom on 15/12/20.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet UILabel *subLbl;
@property (weak, nonatomic) IBOutlet UIImageView *tagImg;

@end
