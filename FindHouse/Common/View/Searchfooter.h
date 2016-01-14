//
//  Searchfooter.h
//  FindHouse
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Searchfooter : UIView
@property (weak, nonatomic) IBOutlet UILabel *recommendLbl; //位置内 
@property (weak, nonatomic) IBOutlet UILabel *recmdLbl; // 好房推荐
@property (weak, nonatomic) IBOutlet UILabel *rangeLbl; // 范围内


@property (weak, nonatomic) IBOutlet UILabel *textLbl; //底部提示文字
@property (weak, nonatomic) IBOutlet UIImageView *lampIV;

@property (weak, nonatomic) IBOutlet UIImageView *bottomIV; // 底部背景图
@property (weak, nonatomic) IBOutlet UIButton *oneRentBtn; //一键按钮

@end
