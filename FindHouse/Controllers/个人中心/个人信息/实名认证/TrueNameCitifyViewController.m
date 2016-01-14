//
//  TrueNameCitifyViewController.m
//  FindHouse
//
//  Created by 许景源 on 16/1/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TrueNameCitifyViewController.h"

@interface TrueNameCitifyViewController ()

@end

@implementation TrueNameCitifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.navigationItem.title = @"真实身份认证";
    self.view.backgroundColor = [UIColor redColor];
    [self initValueAndView];

}

#pragma mark --------- 初始化
-(void)initValueAndView{


    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTHMAIN, HEIGHTMAIN)];
    scrollView.scrollEnabled = YES;
    scrollView.directionalLockEnabled = YES; //只能一个方向滑动
    scrollView.pagingEnabled = NO; //是否翻页
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    scrollView.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    
    self.myContentView.frame = CGRectMake(0, 0, WIDTHMAIN, 667-64);
    scrollView.contentSize = CGSizeMake(0, 667-64);
    [scrollView addSubview:self.myContentView];
    [self.view addSubview:scrollView];
    
    
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
