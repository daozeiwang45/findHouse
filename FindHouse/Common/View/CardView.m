//
//  CardView.m
//  FindHouse
//
//  Created by admin on 15/12/26.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}
- (void)setup
{
    _imageView.backgroundColor = [UIColor orangeColor];
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(7.0, 7.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _imageView.bounds;
    maskLayer.path = maskPath.CGPath;
    _imageView.layer.mask = maskLayer;
    
    _selectedView = [[UIView alloc]init];
    _selectedView.frame = _imageView.frame;
    _selectedView.backgroundColor = [UIColor clearColor];
    _selectedView.alpha = 0.0;
    [_imageView addSubview:_selectedView];
    

}





@end
