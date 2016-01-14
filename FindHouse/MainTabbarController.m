//
//  MainTabbarController.m
//  FindHouse
//
//  Created by admin on 15/12/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "MainTabbarController.h"
#define CENTER_INSETS UIEdgeInsetsMake(6, 0, -6, 0)
#define IDENTIFY_INSETS UIEdgeInsetsZero

@interface MainTabbarController ()
@property (nonatomic, strong) NSArray *selectedImgs;
@property (nonatomic, strong) NSArray *imgs;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSInteger selectedIDX;
@property (nonatomic, strong) UITabBarItem *tabbarItem;

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    _selectedImgs = @[@"home_b",@"baiji_b",@"activity_b",@"me_b"];
    _imgs = @[@"home_s",@"baiji_s",@"activity_s",@"me_s"];
    _titles = @[@"千房",@"百计",@"活动",@"我"];
    [self customiseTabbar];
}

- (void)customiseTabbar {
    self.selectedIndex = 3;
    _selectedIDX = self.selectedIndex;
    [self.tabBar setBarStyle:UIBarStyleBlack];
    self.tabBar.barTintColor = UIColorFromRGB(0x010101);
    self.tabBar.translucent = NO;  //打开会导致view整体偏移
//    self.tabBar.tintColor = [UIColor clearColor];

    UITabBar *tabBar = self.tabBar;
    NSInteger i = 0;
    // text
    for (UITabBarItem *item in tabBar.items)
    {
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor]}
                            forState:UIControlStateNormal];
        item.image = [[UIImage imageNamed:_imgs[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:_selectedImgs[i]]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.title = _titles[i];
        i++;
    }
    if (self.selectedIndex == 0) {
        
       
    }
    //对默认按钮初始化
    UITabBarItem *tabbarItem = tabBar.items[_selectedIDX];
    tabbarItem.imageInsets = CENTER_INSETS;
    tabbarItem.title = @"";
    _tabbarItem = tabbarItem;
}

//MARK: UITabBarControllerDelegate,UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger i = 0;
    for (UITabBarItem *tabitem in self.tabBar.items) {
        if (tabitem == _tabbarItem) {
            _tabbarItem.imageInsets = IDENTIFY_INSETS;
            _tabbarItem.title = _titles[i];
            _tabbarItem = item;
        }
        i++;
    }
    
    item.imageInsets = CENTER_INSETS;
    item.title = @"";
    
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
