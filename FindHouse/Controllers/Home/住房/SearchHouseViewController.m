//
//  SearchHouseViewController.m
//  FindHouse
//
//  Created by admin on 15/12/22.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "SearchHouseViewController.h"
#import "WannaBuyViewController.h"
#import "WannaRentViewController.h"
#import "bxViewAdditions.h"

@interface SearchHouseViewController ()
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) WannaRentViewController *rentVC;
@property (nonatomic, strong) WannaBuyViewController *buyVC;
//@property (nonatomic, strong) NSArray *viewCtrls;

@end

@implementation SearchHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"住房查找";
    self.extendedLayoutIncludesOpaqueBars = YES;

    // views
    _segCtrl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 50)];
    [self.view addSubview:_segCtrl];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 30)];
    lineView.backgroundColor = UIColorFromRGB(0x4b283c);
    [_segCtrl addSubview:lineView];
    lineView.center = _segCtrl.center;
    _segCtrl.sectionTitles = @[@"我要租", @"我要买"];
    _segCtrl.selectedSegmentIndex = 0;
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
    [_segCtrl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
  
    // pageViewCtrl
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    self.rentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"wannarent"];
    self.buyVC = [self.storyboard instantiateViewControllerWithIdentifier:@"wannabuy"];
//    _viewCtrls = @[self.rentVC,self.buyVC];
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

//MARK : PRIVATE METHODS
- (void)segmentAction:(HMSegmentedControl*)sender
{
    NSInteger select = sender.selectedSegmentIndex;
    
    UIViewController *vc = (select==0) ? _rentVC : _buyVC;
    if (vc == nil)
    {
        switch (select)
        {
            case 0:
                vc = [self.storyboard instantiateViewControllerWithIdentifier:@"wannarent"];
                self.rentVC = (WannaRentViewController *)vc;
                break;
                
            case 1:
                vc = [self.storyboard instantiateViewControllerWithIdentifier:@"wannabuy"];
                self.buyVC = (WannaBuyViewController *)vc;
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
    
//    NSInteger index = [_viewCtrls indexOfObject:viewController];
//    
//    if ((index == NSNotFound) || (index == 0)) {
//        return nil;
//    }
//    
//    index--;
//    return [_viewCtrls objectAtIndex:index];
    return nil;
    
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
//    NSInteger index = [_viewCtrls indexOfObject:viewController];
//    
//    if (index == NSNotFound) {
//        return nil;
//    }
//    index++;
//    
//    if (index == [_viewCtrls count]) {
//        return nil;
//    }
//    return [_viewCtrls objectAtIndex:index];
    return nil;
    
}

//- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
//    
//    self.segCtrl.selectedSegmentIndex = [_viewCtrls indexOfObject:[pageViewController.viewControllers lastObject]];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
