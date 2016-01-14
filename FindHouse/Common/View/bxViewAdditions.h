//
//  bxViewAdditions.h
//  baoxiao
//
//  Created by ruanyu on 14-9-6.
//  Copyright (c) 2014年 schope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (bxViewAdditions)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

- (void)removeAllSubviews;

- (UIView *)findSuperViewWithClass:(Class)superViewClass;

- (UIImage *)screenshot;

@end
