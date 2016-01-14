//
//  MyCenterViewController.h
//  FindHouse
//
//  Created by 许景源 on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface MyCenterViewController : BaseViewController

//@property (strong,nonatomic) UITableView *myTableView;

@property (strong, nonatomic) IBOutlet UIView *myContentView;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIView *loginView;//未登入时的头部

@property (weak, nonatomic) IBOutlet UIView *myHeadView;//登入后的图片

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;//头像

@property (assign,nonatomic) BOOL isLogin;//判断是否登入

@end
