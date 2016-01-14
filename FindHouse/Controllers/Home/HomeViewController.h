//
//  HomeViewController.h
//  FindHouse
//
//  Created by admin on 15/12/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface HomeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,BMKMapViewDelegate, BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
@property (strong, nonatomic) BMKLocationService *locationService;
@property (strong, nonatomic) BMKGeoCodeSearch *geocodesearch;
@property (strong, nonatomic) BMKReverseGeoCodeOption *reverse;

@end
