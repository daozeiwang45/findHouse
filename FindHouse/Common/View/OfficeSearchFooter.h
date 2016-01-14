//
//  OfficeSearchFooter.h
//  FindHouse
//
//  Created by Tom on 16/1/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfficeSearchFooter : UIView
@property (weak, nonatomic) IBOutlet UIImageView *lampIV; // 灯图片
@property (weak, nonatomic) IBOutlet UILabel *distanceLbl; // 搜索距离
@property (weak, nonatomic) IBOutlet UILabel *souResultLbl; // 结果
@property (weak, nonatomic) IBOutlet UILabel *unitLbl1; // 单位
@property (weak, nonatomic) IBOutlet UILabel *unitLbl2;
@property (weak, nonatomic) IBOutlet UILabel *recmdLbl; // 推荐结果
@property (weak, nonatomic) IBOutlet UILabel *typeLbl; // 类型标签


@end
