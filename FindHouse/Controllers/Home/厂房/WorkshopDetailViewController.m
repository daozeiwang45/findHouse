//
//  WorkshopViewController.m
//  FindHouse
//
//  Created by Tom on 16/1/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WorkshopDetailViewController.h"
#import "bxViewAdditions.h"
#import "SDCycleScrollView.h"
#import "DetailBarView.h"
#import "DetailBarHView.h"
#import "DetailViewCell.h"
#import "ShareViewController.h"
#import "UncheckAlertView.h"
#import "ContactLandlordView.h"
#import "ContactView.h"
#import "ContractDetailViewController.h"
#import "ReportFooter.h"


@interface WorkshopDetailViewController ()<SDCycleScrollViewDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    ReportFooter *_reportFooter;
    UncheckAlertView *_uncheckView; // 未验证身份提示
    ContactLandlordView *_lordCntactView; // 房东视图
    ContactView *_contactView;
    UIButton *_callBtn,*_chatBtn;
    
}
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *lordView; // 房东视图
@property (nonatomic, strong) UIView *chatView;
@property (nonatomic, strong) UIView *detailBgView; // 详情背景视图
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *directionBtn;
@property (nonatomic, strong) DetailBarView *barView; // 底部按钮栏
@property (nonatomic, strong) DetailBarHView *barHView; // 售时 底部栏按钮

@end

static NSString *cellID = @"detailCell";
@implementation WorkshopDetailViewController

//MARK: lifestyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"房源详情";
    self.view.backgroundColor = [UIColor purpleColor];
    isChecked = YES;
    [self _initUI];
}

//MARK: PRIVATE METHODS
- (void)_initUI {
    NSArray *imgs = @[[UIImage imageNamed:@"demoImg"],
                      [UIImage imageNamed:@"demoImg"],
                      [UIImage imageNamed:@"demoImg"],
                      [UIImage imageNamed:@"demoImg"]
                      ];
    _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, kSCREEN_W, kSCREEN_H-75-64) imagesGroup:imgs];
    _banner.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _banner.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _banner.delegate = self;
    _banner.autoScroll = NO;
    _banner.backgroundColor = [UIColor orangeColor];
    _banner.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.view addSubview:_banner];
    UISwipeGestureRecognizer *swipeGZ = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction)];
    swipeGZ.direction = UISwipeGestureRecognizerDirectionUp;
    [_banner addGestureRecognizer:swipeGZ];
    _detailBgView = [[UIView alloc] initWithFrame:CGRectMake(0, kSCREEN_H-75, kSCREEN_W, kSCREEN_H+75)];
    [self.view addSubview:_detailBgView];
    //    _detailBgView.backgroundColor = [UIColor orangeColor];
    UIPanGestureRecognizer *panGZ = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(translationAction:)];
    [_detailBgView addGestureRecognizer:panGZ];
    
    if (_houseKind == RentKind) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, kSCREEN_H-135-64) style:UITableViewStylePlain];
        
        UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 508)];
        _header.frame = centerView.bounds;
        [centerView addSubview:_header];
        _tableView.tableHeaderView = centerView;
        _topToRent.priority = 999;
        _topToSale.priority = 250;
        _saleV.hidden = YES;
        [_header layoutIfNeeded];
    }else if (_houseKind == SaleKind){
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, kSCREEN_H-135-64) style:UITableViewStylePlain];
        UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 508-48-37)];
        _header.frame = centerView.bounds;
        [centerView addSubview:_header];
        _tableView.tableHeaderView = centerView;
        _saleV.hidden = NO;
        _rentV.hidden = YES;
        _topToRent.priority = 250;
        _topToSale.priority = 999;
        _commentHc.constant = 0;
        _commentSection.hidden = YES;
        [_header layoutIfNeeded];
        
    }
    _reportFooter = [[[NSBundle mainBundle] loadNibNamed:@"ReportFooter" owner:self options:nil] lastObject];
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 60)];
    _reportFooter.frame = footerV.bounds;
    [footerV addSubview:_reportFooter];
    _tableView.tableFooterView = footerV;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.scrollEnabled = NO;
    [_detailBgView addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _directionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _directionBtn.frame = CGRectMake(kSCREEN_W/2.0-25, -10, 50, 50);
    _directionBtn.backgroundColor = [UIColor whiteColor];
    _directionBtn.layer.cornerRadius = 25.0;
    _directionBtn.layer.masksToBounds = YES;
    
    _directionBtn.selected = NO;
    [_directionBtn setImage:[UIImage imageNamed:@"btn_up"] forState:UIControlStateNormal];
    [_directionBtn setImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateSelected];
    [_directionBtn addTarget:self action:@selector(directionBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_detailBgView addSubview:_directionBtn];
    
    // 底部栏
    UIView *bottomBarView = [[UIView alloc] initWithFrame:CGRectMake(0, _tableView.bottom, kSCREEN_W, 135)];
    if(_houseKind == RentKind) {
        
        _barView = [[[NSBundle mainBundle] loadNibNamed:@"DetailBarView" owner:self options:nil] lastObject];
        _barView.clipsToBounds = NO;
        _barView.frame = bottomBarView.bounds;
        [bottomBarView addSubview:_barView];
        [_detailBgView addSubview:bottomBarView];
        [_barView.shareBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_barView.favorBtn setImage:[UIImage imageNamed:@"favorite_sel"] forState:UIControlStateSelected];
        [_barView.favorBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_barView.signBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_barView.landlordBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_barView.serviceBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        
        _barHView = [[[NSBundle mainBundle] loadNibNamed:@"DetailBarHView" owner:self options:nil] lastObject];
        _barHView.clipsToBounds = NO;
        _barHView.frame = bottomBarView.bounds;
        [bottomBarView addSubview:_barHView];
        [_detailBgView addSubview:bottomBarView];
        [_barHView.shareBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_barHView.favorBtn setImage:[UIImage imageNamed:@"favorite_sel"] forState:UIControlStateSelected];
        [_barHView.favorBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_barView.signBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_barHView.lordBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_barHView.serviceBtn addTarget:self action:@selector(bottomBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

- (UIView *)alertView {
    if (!_alertView) {
        self.alertView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _uncheckView = [[[NSBundle mainBundle] loadNibNamed:@"UncheckAlertView" owner:self options:nil] lastObject];
        _uncheckView.frame = _alertView.bounds;
        [_alertView addSubview:_uncheckView];
    }
    return _alertView;
}

- (UIView *)lordView {
    if (!_lordView) {
        self.lordView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _lordCntactView = [[[NSBundle mainBundle] loadNibNamed:@"ContactLandlordView" owner:self options:nil] lastObject];
        _lordCntactView.frame = _lordView.bounds;
        [_lordView addSubview:_lordCntactView];
        
        [_lordCntactView.landNumBtn addTarget:self action:@selector(contactLandlordAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_lordCntactView.onlineBtn addTarget:self action:@selector(contactLandlordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lordView;
}

- (UIView *)chatView {
    if (!_chatView) {
        self.chatView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _contactView = [[[NSBundle mainBundle] loadNibNamed:@"ContactView" owner:self options:nil] lastObject];
        _contactView.frame = _chatView.bounds;
        [_chatView addSubview:_contactView];
        [_contactView.phoneBtn addTarget:self action:@selector(contactBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contactView.onlineBtn addTarget:self action:@selector(contactBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatView;
}

// 联系房东按钮
- (void)contactLandlordAction:(UIButton *)btn {
    if (btn.tag == 1) {
        NSLog(@"电话联系 1008611");
        NSString *phoneNumber = @"1008611";
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        
        [self.view addSubview:callWebview];
    }else if(btn.tag == 2) {
        NSLog(@"和房东在线聊");
    }
}

// 联系客服
- (void)contactBtnAction:(UIButton *)btn {
    if (btn.tag == 1) {
        NSLog(@"电话联系 10086");
        NSString *phoneNumber = @"10086";
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        
        [self.view addSubview:callWebview];
        
    }else if(btn.tag == 2) {
        NSLog(@"在线聊");
    }
}

- (void)bottomBtnAction:(UIButton *)btn {
    if (btn.tag == 101) {
        
        ShareViewController *shareVC = [[ShareViewController alloc] init];
        shareVC.modalPresentationStyle = UIModalPresentationCustom;
        [self.navigationController presentViewController:shareVC animated:YES completion:nil];
    }else if (btn.tag == 102) {
        //        _barView.favorBtn.selected = !_barView.favorBtn.selected;
        btn.selected = !btn.selected;
        NSLog(@"点击收藏按钮了");
    }else if (btn.tag == 103) {
        NSLog(@"签约");
        if (isChecked == YES) {
            
            ContractDetailViewController *contractDetailVC = [[ContractDetailViewController alloc] init];
            [self.navigationController pushViewController:contractDetailVC animated:YES];
            
        }else {
            
            [self.view addSubview:self.alertView];
        }
    }else if (btn.tag == 104) {
        
        [self.view addSubview:self.lordView];
        
    }else if (btn.tag == 105) {
        
        [self.view addSubview:self.chatView];
    }
}

- (void)directionBtnAction {
    NSLog(@"123test");
    if (_directionBtn.selected ) {
        [self hideDetailView];
    }else{
        
        [self showDetailView];
    }
}

// 手势方法
- (void)swipeAction {
    [self showDetailView];
}
// 平移
- (void)translationAction:(UIPanGestureRecognizer *)panGZ {
    
    CGPoint point = [panGZ translationInView:self.view];
    if(panGZ.state == UIGestureRecognizerStateBegan || panGZ.state == UIGestureRecognizerStateChanged) {
        
        if(point.y <= -75){
            [self showDetailView];
            
        }else if (point.y > 75) {
            
            [self hideDetailView];
        }
    }
}

- (void)showDetailView {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _detailBgView.top = 64;
    }];
    _tableView.scrollEnabled = YES;
    _directionBtn.selected = YES;
    
}
- (void)hideDetailView {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        _detailBgView.top = kSCREEN_H-75;
        
    }];
    
    [_tableView scrollRectToVisible:CGRectMake(0, 0, kSCREEN_W, 75) animated:NO];
    _directionBtn.selected = NO;
    
    _tableView.scrollEnabled = NO;
}

//MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_houseKind == RentKind) {
        return 5;
    }else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 67;
}
//MARK: SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"selected %ld",(long)index);
}

@end
