//
//  ParkToBuyViewController.m
//  FindHouse
//
//  Created by admin on 16/1/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ParkToBuyViewController.h"
#import "bxViewAdditions.h"
#import "ParkToBuyCell.h"
#import "OfficeSearchFooter.h"
#import "ParkResultViewController.h"
#import "ParkRecmdViewController.h"

@interface ParkToBuyViewController ()
{
    OfficeSearchFooter *_footer;
}
@property (strong, nonatomic) UIImageView *pinIV; // pin 图片
@property (strong, nonatomic) UILabel *placeLbl; // 位置标签
@property (strong, nonatomic) UIButton *locBtn,*zoomInBtn,*zoomOutBtn;
@property (nonatomic, strong) UITableView *tableView;
@end

static NSString *cellID = @"ParkToBuyCell";
@implementation ParkToBuyViewController

//MARK: LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initUI];
    [self startLocation];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}

//MARK: PRIVATE METHODS
- (void)_initUI {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, kSCREEN_H-64-50) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"ParkToBuyCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.view addSubview:_tableView];
    
    // header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 360)];
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 300)];
    _mapView.zoomEnabled = YES;
    _mapView.rotateEnabled = YES;
    _mapView.showMapScaleBar = YES;
    _mapView.zoomLevel = 15;
    [headerView addSubview:_mapView];
    _pinIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 322, 13, 16)];
    _pinIV.image = [UIImage imageNamed:@"pin_r"];
    [headerView addSubview:_pinIV];
    _placeLbl = [[UILabel alloc] initWithFrame:CGRectMake(kSCREEN_W/2.0-50, 320, 100, 20)];
    _placeLbl.centerX = headerView.centerX;
    _placeLbl.font = [UIFont systemFontOfSize:15];
    _placeLbl.text = @"城市地址";
    _pinIV.right = _placeLbl.left-10;
    [headerView addSubview:_placeLbl];
    UIImageView *lineIV = [[UIImageView alloc] initWithFrame:CGRectMake(25, headerView.bottom-1, kSCREEN_W-50, 1)];
    lineIV.image = [UIImage imageNamed:@"xuline"];
    [headerView addSubview:lineIV];
    // map btn
    _locBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_locBtn setBackgroundImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    _locBtn.frame = CGRectMake(25, _mapView.bottom-50, 30, 30);
    [_locBtn addTarget:self action:@selector(startLocation) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_locBtn];
    // 比例尺 位置
    _mapView.mapScaleBarPosition = CGPointMake(_locBtn.right+15, _locBtn.centerY-5);
    //
    _zoomInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_zoomInBtn setBackgroundImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    _zoomInBtn.frame = CGRectMake(kSCREEN_W-55, _mapView.bottom-50-30-1, 30, 30);
    [_zoomInBtn addTarget:self action:@selector(zoomMap:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_zoomInBtn];
    //
    UIImageView *btnLine = [[UIImageView alloc] initWithFrame:CGRectMake(_zoomInBtn.left, _zoomInBtn.bottom, _zoomInBtn.width, 1)];
    btnLine.image = [UIImage imageNamed:@"centerLine"];
    [headerView addSubview:btnLine];
    //
    _zoomOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _zoomOutBtn.frame = CGRectMake(kSCREEN_W-55, _mapView.bottom-50, 30, 30);
    [_zoomOutBtn setBackgroundImage:[UIImage imageNamed:@"minus"] forState:UIControlStateNormal];
    [_zoomOutBtn addTarget:self action:@selector(subMap:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:_zoomOutBtn];
    
    _tableView.tableHeaderView = headerView;
    _mapView.delegate = self;
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //footer
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, 147)];
    _footer = [[[NSBundle mainBundle] loadNibNamed:@"OfficeSearchFooter" owner:self options:nil] lastObject];
    _footer.frame = footView.bounds;
    [footView addSubview:_footer];
    _footer.lampIV.image = [UIImage imageNamed:@"lamp_blue"];
    _tableView.tableFooterView = footView;
        // 范围搜索内 结果lbl
        UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchResultAction)];
        _footer.souResultLbl.userInteractionEnabled = YES;
        [_footer.souResultLbl addGestureRecognizer:searchTap];
        // 推荐lbl
        UITapGestureRecognizer *recmdTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recmdAction)];
        [_footer.recmdLbl addGestureRecognizer:recmdTap];
   
    
}
- (void)searchResultAction {
    ParkResultViewController *parkResultVC = [[ParkResultViewController alloc] init];
    parkResultVC.houseKind = SaleKind;
    [self.navigationController pushViewController:parkResultVC animated:YES];
}

- (void)recmdAction {
    ParkRecmdViewController *recmdVC = [[ParkRecmdViewController alloc] init];
    recmdVC.houseKind = SaleKind;
    [self.navigationController pushViewController:recmdVC animated:YES];
    
}

//MARK: MAP
// 地图zoomlevel++
-(void)zoomMap:(id)sender
{
    _mapView.zoomLevel = MIN(_mapView.zoomLevel++, _mapView.maxZoomLevel);
}

// 地图ZoomLevel--
-(void)subMap:(id)sender
{
    _mapView.zoomLevel = MAX(_mapView.zoomLevel--, _mapView.minZoomLevel);
}

- (void)startLocation {
    NSLog(@"进入普通定位态");
    
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    //    [self performSelector:@selector(stopLocationFollowing) withObject:nil afterDelay:3];
}

- (void)stopLocationFollowing {
    [_locService stopUserLocationService];
}

// 用户方向更新后，会调用此函数
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    [self getAddress];
}

// 用户位置更新后，会调用此函数
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    [self getAddress];
}

//开始定位
-(void)getAddress
{
    _search = [[BMKGeoCodeSearch alloc] init];
    _search.delegate = self;
    _reverse = [[BMKReverseGeoCodeOption alloc] init];
    _reverse.reverseGeoPoint = _locService.userLocation.location.coordinate;
    [_search reverseGeoCode:_reverse];
}

//MARK: 获取到物理地址信息
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0 && result.address.length > 0)
    {
        if (_reverse.reverseGeoPoint.latitude == _locService.userLocation.location.coordinate.latitude && _reverse.reverseGeoPoint.longitude == _locService.userLocation.location.coordinate.longitude)
        {
            
            _placeLbl.text = [NSString stringWithFormat:@"%@",result.address];
            [_placeLbl sizeToFit];
            _placeLbl.centerX = self.view.centerX;
            _pinIV.right = _placeLbl.left-10;
            [UIView animateWithDuration:0.3 animations:^{
                
                [self setMapRegionWithCoordinate:result.location];
                
                [_locService stopUserLocationService];
            }];
        }
        else
        {
            NSLog(@"ceshi");
        }
    }
}

//MARK:  传入经纬度,将baiduMapView 锁定到以当前经纬度为中心点的显示区域和合适的显示范围
- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    BMKCoordinateRegion region;
    region = BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.06, 0.06));//越小地图显示越详细
    [_mapView setRegion:region animated:YES];//执行设定显示范围
    [_mapView setCenterCoordinate:coordinate animated:YES];//根据提供的经纬度为中心原点 以动画的形式移动到该区域
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

//MARK: UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ParkToBuyCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 224;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
