//
//  MapAnnotationView.h
//  FindHouse
//
//  Created by admin on 15/12/28.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKAnnotationView.h>
#import <CoreLocation/CoreLocation.h>

@interface MapAnnotationView : BMKAnnotationView

@property (nonatomic, assign) BOOL ispositionannotation;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
@end
