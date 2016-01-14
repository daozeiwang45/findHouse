//
//  DetailView.h
//  FindHouse
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToRent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topToSale;
@property (weak, nonatomic) IBOutlet UIView *saleView;
@property (weak, nonatomic) IBOutlet UIView *commentSection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentHc;


@property (weak, nonatomic) IBOutlet UIView *rentView;


@end
