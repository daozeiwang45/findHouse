//
//  MineOneCollectionViewCell.m
//  FindHouse
//
//  Created by 许景源 on 16/1/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MineOneCollectionViewCell.h"

@implementation MineOneCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"MineOneCollectionViewCell"
                                                     owner:self options:nil] ;
        self= [nib lastObject];
        [nib objectAtIndex:0];
    }
    return self;
}

@end
