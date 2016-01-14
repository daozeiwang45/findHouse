//
//  ShopRecmdViewController.m
//  FindHouse
//
//  Created by Tom on 16/1/9.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ShopRecmdViewController.h"
#import "ResultCell.h"
#import "ShopDetailViewController.h"

@interface ShopRecmdViewController ()

@end

static NSString *cellID = @"resultCell";
@implementation ShopRecmdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"商铺推荐 %d",10 ];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
    
    ShopDetailViewController *detailVC = [[ShopDetailViewController alloc] initWithNibName:@"ShopDetailViewController" bundle:nil];
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
