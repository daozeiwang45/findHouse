//
//  BuyRangeCell.m
//  FindHouse
//
//  Created by Tom on 15/12/28.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "BuyRangeCell.h"

@implementation BuyRangeCell

- (void)awakeFromNib {
    // Initialization code
    _lowLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    _lowLbl.font = [UIFont systemFontOfSize:14];
    _lowLbl.textAlignment = NSTextAlignmentCenter;
    _highLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    _highLbl.font = [UIFont systemFontOfSize:14];
    _highLbl.textAlignment = NSTextAlignmentCenter;
    
    _lowPriceLBL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    _lowPriceLBL.font = [UIFont systemFontOfSize:14];
    _lowPriceLBL.textAlignment = NSTextAlignmentCenter;
    _highPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    _highPriceLbl.font = [UIFont systemFontOfSize:14];
    _highPriceLbl.textAlignment = NSTextAlignmentCenter;
    [self configureDistanceSlider];
    [self configurePriceSlider];
}

- (void) configureDistanceSlider
{
    // Disabling the lower slider lets you use the control as a regular UISlider but with
    // the added themes and stepping functions.
    
    self.distanceSlider.upperValue = 20;
    self.distanceSlider.lowerHandleHidden = YES;
    self.distanceSlider.stepValue = 0.1;
    //    self.singleSlider.stepValueContinuously = YES;
    self.lowLbl.hidden = YES;
    self.distanceSlider.maximumValue = 20;
    self.distanceSlider.minimumValue = 0;
    UIImage* image = nil;
    image = [UIImage imageNamed:@"track_gray"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    self.distanceSlider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"track_blue"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    self.distanceSlider.trackImage = image;
    
    image = [UIImage imageNamed:@"handler_blue"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    self.distanceSlider.lowerHandleImageNormal = image;
    self.distanceSlider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"handler_blue"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    self.distanceSlider.lowerHandleImageHighlighted = image;
    self.distanceSlider.upperHandleImageHighlighted = image;
    
}

- (void)configurePriceSlider {
    self.priceSlider.upperValue = 5;
    self.priceSlider.stepValue = 0.1;
    //    self.rangeSlider.stepValueContinuously = YES;
    self.priceSlider.maximumValue = 5;
    self.priceSlider.minimumValue = 0;
    UIImage* image = nil;
    image = [UIImage imageNamed:@"track_gray"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0)];
    self.priceSlider.trackBackgroundImage = image;
    
    image = [UIImage imageNamed:@"track_blue"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 7.0, 0.0, 7.0)];
    self.priceSlider.trackImage = image;
    
    image = [UIImage imageNamed:@"handler_blue"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    self.priceSlider.lowerHandleImageNormal = image;
    self.priceSlider.upperHandleImageNormal = image;
    
    image = [UIImage imageNamed:@"handler_blue"];
    image = [image imageWithAlignmentRectInsets:UIEdgeInsetsMake(-1, 2, 1, 2)];
    self.priceSlider.lowerHandleImageHighlighted = image;
    self.priceSlider.upperHandleImageHighlighted = image;
}

- (void) updateSliderLabels
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.distanceSlider.lowerCenter.x + self.distanceSlider.frame.origin.x);
    lowerCenter.y = (self.distanceSlider.center.y - 30.0f);
    [self addSubview:_lowLbl];
    self.lowLbl.center = lowerCenter;
    self.lowLbl.text = [NSString stringWithFormat:@"%.1fkm", self.distanceSlider.lowerValue];
    
    CGPoint upperCenter;
    upperCenter.x = (self.distanceSlider.upperCenter.x + self.distanceSlider.frame.origin.x);
    upperCenter.y = (self.distanceSlider.center.y -30.0f);
    [self addSubview:_highLbl];
    self.highLbl.center = upperCenter;
    self.highLbl.text = [NSString stringWithFormat:@"%.1fkm", self.distanceSlider.upperValue];
}

- (void) updatePriceLabels
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.priceSlider.lowerCenter.x + self.priceSlider.frame.origin.x);
    lowerCenter.y = (self.priceSlider.center.y - 30.0f);
    [self addSubview:_lowPriceLBL];
    self.lowPriceLBL.center = lowerCenter;
    self.lowPriceLBL.text = [NSString stringWithFormat:@"%.1f万", self.priceSlider.lowerValue];
    
    CGPoint upperCenter;
    upperCenter.x = (self.priceSlider.upperCenter.x + self.priceSlider.frame.origin.x);
    upperCenter.y = (self.priceSlider.center.y -30.0f);
    [self addSubview:_highPriceLbl];
    self.highPriceLbl.center = upperCenter;
    self.highPriceLbl.text = [NSString stringWithFormat:@"%.1f万", self.priceSlider.upperValue];
}

- (IBAction)distanceValueAction:(NMRangeSlider *)sender {
    [self updateSliderLabels];
}

- (IBAction)priceValueAction:(id)sender {
    [self updatePriceLabels];
}
@end
