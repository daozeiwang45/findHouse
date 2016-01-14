//
//  TwoStyleCollectionViewCell.m
//  kang
//
//  Created by WSGG on 15/11/19.
//  Copyright © 2015年 XJY. All rights reserved.
//

#import "TwoStyleCollectionViewCell.h"

@implementation TwoStyleCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"TwoStyleCollectionViewCell"
                                                     owner:self options:nil] ;
        self= [nib lastObject];
        [nib objectAtIndex:0];
    }
    return self;
}


@end
