//
//  MapAnnotationView.m
//  FindHouse
//
//  Created by admin on 15/12/28.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "MapAnnotationView.h"

@implementation MapAnnotationView

- (id)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    self.userInteractionEnabled = YES;
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
