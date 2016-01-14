//
//  WhiteLineTextfield.m
//  FindHouse
//
//  Created by Tom on 15/12/17.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "LineTextfield.h"

@implementation LineTextfield

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //[self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}

@end

