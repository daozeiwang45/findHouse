//
//  DetailBarView.h
//  FindHouse
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailBarView : UIView
@property (weak, nonatomic) IBOutlet UIButton *shareBtn; // 转发按钮
@property (weak, nonatomic) IBOutlet UIButton *favorBtn; // 收藏按钮
@property (weak, nonatomic) IBOutlet UIButton *signBtn; // 签约按钮

@property (weak, nonatomic) IBOutlet UIButton *landlordBtn; // 房东按钮
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn; // 客服按钮

@end
