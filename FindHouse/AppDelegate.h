//
//  AppDelegate.h
//  FindHouse
//
//  Created by admin on 15/12/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>
{
    BMKMapManager *_mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

