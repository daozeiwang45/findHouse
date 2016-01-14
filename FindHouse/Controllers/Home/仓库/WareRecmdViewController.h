//
//  WareRecmdViewController.h
//  FindHouse
//
//  Created by Tom on 16/1/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface WareRecmdViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign)Kind houseKind;
@property (nonatomic, strong)UITableView *tableView;

@end
