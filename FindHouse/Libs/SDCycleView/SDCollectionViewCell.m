//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


/**
 
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到gsdios@126.com 或者 到                       *
 * https://github.com/gsdios?tab=repositories 提交问题     *
 *                                                      *
 *******************************************************
 
 */


#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"

@implementation SDCollectionViewCell
{
     __weak UILabel *_mainTitleLabel;
     __weak UILabel *_titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLabel];
    }
    
    return self;
}

- (void)setMainTitleLabelBackgroundColor:(UIColor *)mainTitleLabelBackgroundColor
{
    _mainTitleLabelBackgroundColor = mainTitleLabelBackgroundColor;
    _mainTitleLabel.backgroundColor = mainTitleLabelBackgroundColor;
}
- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;

}

- (void)setMainTitleLabelTextColor:(UIColor *)mainTitleLabelTextColor
{
    _mainTitleLabelTextColor = mainTitleLabelTextColor;
    _mainTitleLabel.textColor = mainTitleLabelTextColor;
}
- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setMainTitleLabelTextFont:(UIFont *)mainTitleLabelTextFont
{
    _mainTitleLabelTextFont = mainTitleLabelTextFont;
    _mainTitleLabel.font = mainTitleLabelTextFont;
}
- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

// 设置图片
- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    _imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
}

// 建立标签
- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    UILabel *mainTitleLabel = [[UILabel alloc] init];
    mainTitleLabel.textAlignment = NSTextAlignmentLeft;
    _mainTitleLabel = mainTitleLabel;
    _mainTitleLabel.hidden = YES;
    
    [self addSubview:titleLabel];
    [self addSubview:mainTitleLabel];
}

- (void)setMainTitle:(NSString *)mainTitle
{
    _mainTitle = [mainTitle copy];
    _mainTitleLabel.text = [NSString stringWithFormat:@"%@",mainTitle];
}
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"%@", title];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleLabelW = self.sd_width-100-25;
    CGFloat titleLabelH = _titleLabelHeight;
    CGFloat titleLabelX = 25;
    CGFloat titleLabelY = self.sd_height - titleLabelH-10;
    _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    _titleLabel.hidden = !_titleLabel.text;
    
    CGFloat mainTitleLabelW = self.sd_width-25;
    CGFloat mainTitleLabelH = _mainTitleLabelHeight;
    CGFloat mainTitleLabelX = 25;
    CGFloat mainTitleLabelY = self.sd_height -10-titleLabelH-5 -mainTitleLabelH;
    _mainTitleLabel.frame = CGRectMake(mainTitleLabelX, mainTitleLabelY, mainTitleLabelW, mainTitleLabelH);
    _mainTitleLabel.hidden = !_mainTitleLabel.text;
    _imageView.frame = self.bounds;
    
   
}

@end
