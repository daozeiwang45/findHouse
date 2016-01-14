//
//  ProfileViewController.m
//  FindHouse
//
//  Created by admin on 15/12/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    [self initUI];
    
}

- (void)initUI {
    
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.frame = CGRectMake(0, 0, 80, 30);
    [releaseBtn setTitle:@"发布房源" forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [releaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseBtn];
}

- (void)releaseAction {
    
    NSLog(@"发布房源待续");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
