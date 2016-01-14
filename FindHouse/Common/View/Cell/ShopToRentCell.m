//
//  ShopToRentCell.m
//  FindHouse
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ShopToRentCell.h"

@implementation ShopToRentCell

- (void)awakeFromNib {
    // Initialization code
    _lowerLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    _lowerLbl.font = [UIFont systemFontOfSize:14];
    _higherLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    _higherLbl.font = [UIFont systemFontOfSize:14];
    _higherLbl.textAlignment = NSTextAlignmentCenter;
    
    _rangeHighL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    _rangeHighL.font = [UIFont systemFontOfSize:14];
    _rangeHighL.textAlignment = NSTextAlignmentCenter;
    _rangeLowL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    _rangeLowL.font = [UIFont systemFontOfSize:14];
    _rangeLowL.textAlignment = NSTextAlignmentCenter;
    [self configureSingleSlider];
    [self configureRangeSlider];
    
}

- (void) configureSingleSlider
{
    // Disabling the lower slider lets you use the control as a regular UISlider but with
    // the added themes and stepping functions.
    
    self.singleSlider.upperValue = 20;
    self.singleSlider.lowerHandleHidden = YES;
    self.singleSlider.stepValue = 0.1;
    //    self.singleSlider.stepValueContinuously = YES;
    self.lowerLbl.hidden = YES;
    self.singleSlider.maximumValue = 20;
    self.singleSlider.minimumValue = 0;
    UIImage* image = nil;
    image = [UIImage imageNamed:@"track_gray"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    self.singleSlider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"track_yellow"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    self.singleSlider.trackImage = image;
    
    image = [UIImage imageNamed:@"handler_yellow"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    self.singleSlider.lowerHandleImageNormal = image;
    self.singleSlider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"handler_yellow"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    self.singleSlider.lowerHandleImageHighlighted = image;
    self.singleSlider.upperHandleImageHighlighted = image;
    
}

- (void)configureRangeSlider {
    self.rangeSlider.upperValue = 10;
    self.rangeSlider.stepValue = 0.1;
    //    self.rangeSlider.stepValueContinuously = YES;
    self.rangeSlider.maximumValue = 10;
    self.rangeSlider.minimumValue = 0;
    UIImage* image = nil;
    image = [UIImage imageNamed:@"track_gray"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    self.rangeSlider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"track_yellow"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    self.rangeSlider.trackImage = image;
    
    image = [UIImage imageNamed:@"handler_yellow"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    self.rangeSlider.lowerHandleImageNormal = image;
    self.rangeSlider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"handler_yellow"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    self.rangeSlider.lowerHandleImageHighlighted = image;
    self.rangeSlider.upperHandleImageHighlighted = image;
}

- (void) updateSingleSliderLabels
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.singleSlider.lowerCenter.x + self.singleSlider.frame.origin.x);
    lowerCenter.y = (self.singleSlider.center.y - 30.0f);
    [self addSubview:_lowerLbl];
    self.lowerLbl.center = lowerCenter;
    self.lowerLbl.text = [NSString stringWithFormat:@"%.1fkm", self.singleSlider.lowerValue];
    
    CGPoint upperCenter;
    upperCenter.x = (self.singleSlider.upperCenter.x + self.singleSlider.frame.origin.x);
    upperCenter.y = (self.singleSlider.center.y -30.0f);
    [self addSubview:_higherLbl];
    self.higherLbl.center = upperCenter;
    self.higherLbl.text = [NSString stringWithFormat:@"%.1fkm", self.singleSlider.upperValue];
}

- (void) updateRangeSliderLabels
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.rangeSlider.lowerCenter.x + self.rangeSlider.frame.origin.x);
    lowerCenter.y = (self.rangeSlider.center.y - 30.0f);
    [self addSubview:_rangeLowL];
    self.rangeLowL.center = lowerCenter;
    self.rangeLowL.text = [NSString stringWithFormat:@"%.1f万", self.rangeSlider.lowerValue];
    
    CGPoint upperCenter;
    upperCenter.x = (self.rangeSlider.upperCenter.x + self.rangeSlider.frame.origin.x);
    upperCenter.y = (self.rangeSlider.center.y -30.0f);
    [self addSubview:_rangeHighL];
    self.rangeHighL.center = upperCenter;
    self.rangeHighL.text = [NSString stringWithFormat:@"%.1f万", self.rangeSlider.upperValue];
}

- (IBAction)singleSliderAction:(NMRangeSlider *)sender {
    [self updateSingleSliderLabels];
}

- (IBAction)rangeSliderAction:(NMRangeSlider *)sender {
    [self updateRangeSliderLabels];
}
@end
