//
//  BaseNavController.m
//  FindHouse
//
//  Created by admin on 15/12/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseNavController.h"
#import "bxViewAdditions.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:UIColorFromRGB(0xfee000)];
    self.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationBar.translucent = NO;
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
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
