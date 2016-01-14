//
//  SearchWorkshopViewController.m
//  FindHouse
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SearchWorkshopViewController.h"
#import "bxViewAdditions.h"
#import "HMSegmentedControl.h"
#import "WorkshopToRentViewController.h"
#import "WorkshopToBuyViewController.h"

@interface SearchWorkshopViewController ()
@property (nonatomic, strong) HMSegmentedControl           *segCtrl;
@property (nonatomic, strong) UIPageViewController         *pageViewController;
@property (nonatomic, strong) WorkshopToRentViewController *rentVC;
@property (nonatomic, strong) WorkshopToBuyViewController  *buyVC;

@end

@implementation SearchWorkshopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"厂房查找";
    _segCtrl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_W, 50)];
    _segCtrl.selectedSegmentIndex = 0;
    _segCtrl.sectionTitles = @[@"我要租",@"我要买"];
    _segCtrl.selectionIndicatorHeight = 5;
    _segCtrl.selectionIndicatorColor = UIColorFromRGB(0x4b283c);
    _segCtrl.selectionStyle = HMSegmentedControlSelectionStyleArrow;
    _segCtrl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    _segCtrl.selectionIndicatorColor = UIColorFromRGB(0x4b283c);
    _segCtrl.backgroundColor = [UIColor colorWithHue:.7 saturation:.4 brightness:.5 alpha:.7];
    _segCtrl.titleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGB(0x4b283c),
                                     NSFontAttributeName:[UIFont systemFontOfSize:15]};
    _segCtrl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:UIColorFromRGB(0x4b283c),
                                             NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [self.view addSubview:_segCtrl];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kSCREEN_W/2.0-.5, 10, 1, 30)];
    lineView.backgroundColor = UIColorFromRGB(0x4b283c);
    [_segCtrl addSubview:lineView];
    [_segCtrl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    // pageViewCtrl
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    // pageViewCtrl
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    _rentVC = [[WorkshopToRentViewController alloc] init];
    [self.pageViewController setViewControllers:@[_rentVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    CGRect pageViewRect = self.view.bounds;
    pageViewRect.origin.y += _segCtrl.bottom;
    pageViewRect.size.height -= _segCtrl.bottom;
    self.pageViewController.view.frame = pageViewRect;
    [self.pageViewController didMoveToParentViewController:self];
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    for (UIScrollView *view in self.pageViewController.view.subviews)
    {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            view.scrollEnabled = NO;
        }
    }
}

//MARK: PRIVATE METHODS
- (void)segmentAction:(HMSegmentedControl*)sender
{
    NSInteger select = sender.selectedSegmentIndex;
    
    UIViewController *vc = (select==0) ? _rentVC : _buyVC;
    if (vc == nil)
    {
        switch (select)
        {
            case 0:
                vc = [[WorkshopToRentViewController alloc] init];
                self.rentVC = (WorkshopToRentViewController *)vc;
                break;
                
            case 1:
                vc = [[WorkshopToBuyViewController alloc] init];
                self.buyVC = (WorkshopToBuyViewController *)vc;
                break;
                
            default:
                break;
        }
    }
    
    NSInteger direction = select==0 ? UIPageViewControllerNavigationDirectionReverse:UIPageViewControllerNavigationDirectionForward;
    [self.pageViewController setViewControllers:@[vc] direction:direction animated:YES completion:nil];
}

//MARK: UIPageViewControllerDataSource,UIPageViewControllerDelegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    return nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
