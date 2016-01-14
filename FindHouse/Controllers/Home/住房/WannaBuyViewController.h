//
//  WannaBuyViewController.h
//  FindHouse
//
//  Created by admin on 15/12/23.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface WannaBuyViewController : BaseViewController<BMKMapViewDelegate, BMKPoiSearchDelegate,BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BMKLocationService* _locService;
    BMKPoiSearch *_poiSearch;
}
@property (strong, nonatomic) BMKMapView *mapView;
@property (strong, nonatomic) BMKGeoCodeSearch *search;
@property (strong, nonatomic) BMKReverseGeoCodeOption *reverse;
@property (assign, nonatomic) CLLocationCoordinate2D myPositionCoor;
@end
