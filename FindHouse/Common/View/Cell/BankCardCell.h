//
//  BankCardCell.h
//  FindHouse
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankCardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bankIcon;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *tailNum;
@property (weak, nonatomic) IBOutlet UILabel *cardType;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;


@end
