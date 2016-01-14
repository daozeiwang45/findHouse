//
//  OfficeRecmdViewController.m
//  FindHouse
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "OfficeRecmdViewController.h"
#import "ResultCell.h"
#import "OfficeDetailViewController.h"

@interface OfficeRecmdViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *tableView;

@end

static NSString *cellID = @"resultCell";
@implementation OfficeRecmdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"办公推荐 %d",10 ];
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
    
    OfficeDetailViewController *detailVC = [[OfficeDetailViewController alloc] initWithNibName:@"OfficeDetailViewController" bundle:nil];
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
