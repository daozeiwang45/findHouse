//
//  SearchResultVController.h
//  FindHouse
//
//  Created by admin on 15/12/24.
//  Copyright © 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SearchResultVController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentSection;
    NSInteger btnSection;
    CGRect rect;
}
@property (nonatomic, assign) Kind houseKind;

@end
