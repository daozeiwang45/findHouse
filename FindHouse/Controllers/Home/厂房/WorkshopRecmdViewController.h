//
//  WorkshopRecmdViewController.h
//  FindHouse
//
//  Created by Tom on 16/1/9.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface WorkshopRecmdViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign)Kind houseKind;
@property (nonatomic, strong)UITableView *tableView;

@end
