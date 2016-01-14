//
//  QianRecmdVController.m
//  FindHouse
//
//  Created by admin on 15/12/30.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "QianRecmdVController.h"
#import "HMSegmentedControl.h"
#import "ResultCell.h"
#import "HouseDetailViewController.h"
#import "SDCycleScrollView.h"

@interface QianRecmdVController ()<UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong) HMSegmentedControl *segCtrl;
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *mainTitles;
@property (nonatomic, strong) NSArray *imagesURLStrings;

@end

static NSString *cellID = @"resultCell";
@implementation QianRecmdVController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"千房推荐";
    _segCtrl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_W, 50)];
    _segCtrl.sectionTitles = @[@"租",@"买"];
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
    
    if (_houseKind == RentKind) {
        _segCtrl.selectedSegmentIndex = 0;
        // 轮播图
        _imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];
        
        // 图片配文字
        _titles = @[@"。。。。如果下载的",
                            @"都市自由人为你推荐",
                            @"hello world",
                            @"感谢您的支持"
                            ];
        _mainTitles = @[@"2016开始了吗？",
                                @"千房推荐推荐",
                                @"最诗情画意的乡间小屋",
                                @"最诗情画意的乡间小屋"];

        
    }else if (_houseKind == SaleKind){
        _segCtrl.selectedSegmentIndex = 1;
        // 轮播图
        _imagesURLStrings = @[
                              @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                              @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                              @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                              ];
        
        // 图片配文字
        _titles = @[@"2015年 再见",
                    @"不要离开，这里就是你的家",
                    @"hello world",
                    @"新年开场"
                    ];
        _mainTitles = @[@"这个城市，能给你的幸福可以更多",
                        @"这个城市，能给你的幸福可以更多",
                        @"这个城市，能给你的幸福可以更多",
                        @"这个城市，能给你的幸福可以更多"];

    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kSCREEN_W, kSCREEN_H) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [self.view addSubview:_segCtrl];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kSCREEN_W/2.0-.5, 10, 1, 30)];
    lineView.backgroundColor = UIColorFromRGB(0x4b283c);
    [_segCtrl addSubview:lineView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _header = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kSCREEN_W, 200)];
    _bannerView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 200)];
    [_header addSubview:_bannerView];
    _bannerView.delegate = self;
    _tableView.tableHeaderView = _header;
    [self createBannerAction];
    
}

//MARK: Private Methods
- (void)createBannerAction {
    
    _bannerView.imageURLStringsGroup = _imagesURLStrings;
     _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
     _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
     _bannerView.delegate = self;
    _bannerView.titlesGroup = _titles;
     _bannerView.mainTitlesGroup = _mainTitles;
    //    _header.cycleView.page = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
     _bannerView.placeholderImage = [UIImage imageNamed:@"placeholder"];
}

- (void)segmentAction:(HMSegmentedControl*)sender
{
    NSInteger select = sender.selectedSegmentIndex;
    if (select == 0) {
        _titles = @[@"。。。。如果下载的",
                    @"都市自由人为你推荐",
                    @"hello world",
                    @"感谢您的支持"
                    ];
        _mainTitles = @[@"2016开始了吗？",
                        @"千房推荐推荐",
                        @"最诗情画意的乡间小屋",
                        @"最诗情画意的乡间小屋"];
        [self createBannerAction];
        
    }else if (select == 1) {
        
        _titles = @[@"2015年 再见",
                    @"不要离开，这里就是你的家",
                    @"hello world",
                    @"新年开场"
                    ];
        _mainTitles = @[@"这个城市，能给你的幸福可以更多",
                        @"这个城市，能给你的幸福可以更多",
                        @"这个城市，能给你的幸福可以更多",
                        @"这个城市，能给你的幸福可以更多"];
        [self createBannerAction];
    }
    
    [_tableView reloadData];
  
    
}

//MARK: UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ResultCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HouseDetailViewController *detailVC = [[HouseDetailViewController alloc] init];
    detailVC.houseKind = self.houseKind;
    [self.navigationController pushViewController:detailVC animated:YES];
   

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
}

//MARK: SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    //    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
