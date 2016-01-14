//
//  HouseRecmdViewController.m
//  FindHouse
//
//  Created by admin on 15/12/29.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "HouseRecmdViewController.h"
#import "ResultCell.h"
#import "HouseDetailViewController.h"

@interface HouseRecmdViewController ()

@end

static NSString *cellID = @"resultCell";
@implementation HouseRecmdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"好房推荐 10套";
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//MARK: UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ResultCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HouseDetailViewController *detailVC = [[HouseDetailViewController alloc] init];
    detailVC.houseKind = _houseKind;
    [self.navigationController pushViewController:detailVC animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
