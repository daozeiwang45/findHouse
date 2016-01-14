//
//  HouseRecmdViewController.h
//  FindHouse
//
//  Created by admin on 15/12/29.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface HouseRecmdViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) Kind houseKind;

@end
