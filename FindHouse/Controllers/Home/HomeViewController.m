//
//  HomeViewController.m
//  FindHouse
//
//  Created by admin on 15/12/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCell.h"
#import "SDCycleScrollView.h"
#import "HomeSectionHeader.h"
#import "HomeHeader.h"
#import "bxViewAdditions.h"
#import "SearchHouseViewController.h"
#import "SearchOfficeViewController.h"
#import "SearchParkingViewController.h"
#import "SearchShopViewController.h"
#import "SearchWarehouseViewController.h"
#import "SearchWorkshopViewController.h"
#import "HouseDetailViewController.h"


@interface HomeViewController ()<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) HomeHeader *header;
@property (nonatomic, strong) UILabel *locationLbl;

@end
static NSString *homeCelID = @"homeCell";

@implementation HomeViewController

//MARK: Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    
    //初始化BMKLocationService
    _locationService = [[BMKLocationService alloc] init];
    _locationService.delegate = self;
    //启动LocationService
    [_locationService startUserLocationService];
    //事件 千房租售
    [self actionEvent];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _locationService.delegate = nil;
    _geocodesearch.delegate = nil;
}

//MARK: UI CREATE
    //初始化导航栏UI
- (void)initNavBar {
    // 左侧导航按钮
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, 80, 20)];
    UIImageView *imV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2, 12, 16)];
    imV.image = [UIImage imageNamed:@"map"];
    _locationLbl = [[UILabel alloc] initWithFrame:CGRectMake(imV.right+5, 0, 60, 20)];
    _locationLbl.font = [UIFont systemFontOfSize:15];
    _locationLbl.textColor = UIColorFromRGB(0x000000);
    //        _locationLbl.text = @"城市";
    [leftView addSubview:imV];
    [leftView addSubview:_locationLbl];
    UIControl *leftBtn = [[UIControl alloc] initWithFrame:leftView.bounds];
    [leftView addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    // 标题视图
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 97, 25)];
    imgV.image = [UIImage imageNamed:@"title"];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imgV;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _header = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeader" owner:self options:nil] lastObject];
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_W, 445)];
    _header.frame = headerView.bounds;
    [headerView addSubview:_header];
    
    // 轮播图
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    // 图片配文字
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"都市自由人为你推荐",
                        @"hello world"
                        ];
    NSArray *mainTitles = @[@"最诗情画意的乡间小屋1",
                            @"最诗情画意的乡间小屋2",
                            @"最诗情画意的乡间小屋3"];
    
    _header.cycleView.imageURLStringsGroup = imagesURLStrings;
    _header.cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _header.cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _header.cycleView.delegate = self;
    _header.cycleView.titlesGroup = titles;
    _header.cycleView.mainTitlesGroup = mainTitles;
//    _header.cycleView.page = [UIColor yellowColor]; // 自定义分页控件小圆标颜色
    _header.cycleView.autoScroll = YES;
//    _header.cycleView.autoScrollTimeInterval = 4.0;
    _header.cycleView.placeholderImage = [UIImage imageNamed:@"placeholder"];
    _tableView.tableHeaderView = _header;
   
}

- (void)actionEvent {
    [_header.preBtn addTarget:self action:@selector(prePageAction) forControlEvents:UIControlEventTouchUpInside];
    [_header.nextBtn addTarget:self action:@selector(nextPageAction) forControlEvents:UIControlEventTouchUpInside];
    // 住房事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchHouseAction)];
    [_header.zhufangV addGestureRecognizer:tap1];
    // 办公
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchOfficeAction)];
    [_header.officeV addGestureRecognizer:tap2];
    //车位
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchParkingAction)];
    [_header.parkingV addGestureRecognizer:tap3];
    // 商铺
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchShopAction)];
    [_header.shopV addGestureRecognizer:tap4];
    // 仓库
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchWarehouseAction)];
    [_header.storageV addGestureRecognizer:tap5];
    // 厂房
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchWorkshopAction)];
    [_header.factoryV addGestureRecognizer:tap6];
    
}

//MARK: PRIVATE METHOD
- (void)prePageAction {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pre" object:self];
    
}
- (void)nextPageAction {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"next" object:self];
}

    // 跳转页面  住房页面
- (void)searchHouseAction {
    
    SearchHouseViewController *searchHouseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchHouse"];
    [self.navigationController pushViewController:searchHouseVC animated:YES];
}
    // 跳转 办公
- (void)searchOfficeAction {
    SearchOfficeViewController *searchOfficeVC = [[SearchOfficeViewController alloc] init];
    [self.navigationController pushViewController:searchOfficeVC animated:YES];
}
    // 跳转 车位
- (void)searchParkingAction {
    SearchParkingViewController *searchParkVC = [[SearchParkingViewController alloc] init];
    [self.navigationController pushViewController:searchParkVC animated:YES];
}
    // 跳转 商铺
- (void)searchShopAction {
    SearchShopViewController *searchShopVC = [[SearchShopViewController alloc] init];
    [self.navigationController pushViewController:searchShopVC animated:YES];
}
    // 跳转 仓库
- (void)searchWarehouseAction {
    SearchWarehouseViewController *searchWarehouseVC = [[SearchWarehouseViewController alloc] init];
    [self.navigationController pushViewController:searchWarehouseVC animated:YES];
}
    // 跳转 厂房
- (void)searchWorkshopAction {
    SearchWorkshopViewController *searchWorkshopVC = [[SearchWorkshopViewController alloc] init];
    [self.navigationController pushViewController:searchWorkshopVC animated:YES];
}


- (void)locationAction {
    NSLog(@"未完待续 定位");
}

//MARK: SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
//    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

//MARK: UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCelID];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HouseDetailViewController *detailVC = [[HouseDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"HomeSectionHeader" owner:self options:nil] lastObject];
    view.frame = CGRectMake(0, 0, kSCREEN_W, 45);
    return view;
}

//MARK: 实现地图相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self doStart:nil];
}
//处理位置坐标更新
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    [self doStart:nil];
}

//MARK: 开始定位
-(void)doStart:(id)sender
{
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    _reverse = [[BMKReverseGeoCodeOption alloc] init];
    _reverse.reverseGeoPoint = _locationService.userLocation.location.coordinate;
    [_geocodesearch reverseGeoCode:_reverse];
}

//MARK: 获取到物理地址信息
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0 && result.address.length > 0)
    {
        NSDictionary *attributeDistance = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
        CGSize size = [result.addressDetail.province boundingRectWithSize:CGSizeMake(MAXFLOAT, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDistance context:nil].size;
        _locationLbl.width = size.width;
        _locationLbl.text = result.addressDetail.city;
        NSLog(@"%@",_locationLbl.text);
        NSLog(@"%@",result.addressDetail.province);
        NSLog(@"纬度%f,---经度%f",result.location.latitude,result.location.longitude);
        
        [_locationService stopUserLocationService];
    }
}

//MARK: Memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
