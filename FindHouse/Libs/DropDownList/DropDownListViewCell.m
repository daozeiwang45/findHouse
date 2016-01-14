//
//  DropDownListViewCell.m
//  hbd
//
//  Created by hbd on 15/5/4.
//  Copyright (c) 2015年 YangJian. All rights reserved.
//

#import "DropDownListViewCell.h"

@implementation DropDownListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.arrorImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.arrorImage.image = [UIImage imageNamed:@"check_selected.png"];
        [self.contentView addSubview:self.arrorImage];
        self.arrorImage.hidden = YES;
        
        self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 0,0)];
        self.titleLbl.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.titleLbl];
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0,0.5)];
        self.line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.line];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.arrorImage.frame = CGRectMake(self.frame.size.width - 25, (self.frame.size.height - 18) * 0.5, 18, 18);
    self.titleLbl.frame = CGRectMake(10, 5, self.frame.size.width - 5, self.frame.size.height - 10);
    self.line.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 0.5);
//    self.titleLbl.frame = self.textLabel.frame;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
