//
//  ContractDetailViewController.m
//  FindHouse
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ContractDetailViewController.h"
#import "ContractContentView.h"
#import "SignToPayViewController.h"


@interface ContractDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *mainView;
@property (nonatomic, strong)ContractContentView *contentView;

@end

@implementation ContractDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"合约详情";
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_W, kSCREEN_H-64)];
    _mainView.bounces = NO;
    _mainView.delegate = self;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(kSCREEN_W, 785);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 785)];
    _contentView = [[[NSBundle mainBundle] loadNibNamed:@"ContractContentView" owner:self options:nil] lastObject];
    _contentView.frame = bgView.bounds;
    [bgView addSubview:_contentView];
    [_mainView addSubview:bgView];
    [self.view addSubview:_mainView];
    
    [_contentView.checkToSignBtn addTarget:self action:@selector(signToCheckAction) forControlEvents:UIControlEventTouchUpInside];
}

//MARK: Private Methods
- (void)signToCheckAction {
    
    SignToPayViewController *payVC = [[SignToPayViewController alloc] initWithNibName:@"SignToPayViewController" bundle:nil];
    [self.navigationController pushViewController:payVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
