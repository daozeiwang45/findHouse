//
//  AccountViewController.m
//  FindHouse
//
//  Created by admin on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AccountViewController.h"
#import "bxViewAdditions.h"
#import "AccountViewCell.h"
#import "RechargeViewController.h"
#import "WithdrawViewController.h"
#import "BankCardViewController.h"

@interface AccountViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *iconArr;
@property (nonatomic, strong) NSArray *itemArr;

@end

static NSString *cellID = @"AccountViewCell";
@implementation AccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"账户";
    
    _itemArr = @[@"充值",@"提现",@"银行卡",@"交易记录"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, kSCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = self.header;
    [self.view addSubview:_tableView];
    _tableView.bounces = NO;
    _tableView.separatorColor = [UIColor grayColor];
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    
}

//MARK: UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AccountViewCell" owner:self options:nil] lastObject];
    }
    if(indexPath.row != 3){
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(60, cell.bottom-0.5, kSCREEN_W-60, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
    }
    cell.itemLbl.text = _itemArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        RechargeViewController *rechargeVC = [[RechargeViewController alloc] initWithNibName:@"RechargeViewController" bundle:nil];
        [self.navigationController pushViewController:rechargeVC animated:YES];
    }else if (indexPath.row == 1) {
        WithdrawViewController *withdrawVC = [[WithdrawViewController alloc] initWithNibName:@"WithdrawViewController" bundle:nil];
        [self.navigationController pushViewController:withdrawVC animated:YES];
    }else if (indexPath.row == 2) {
        BankCardViewController *bankCardVC = [[BankCardViewController alloc] initWithNibName:@"BankCardViewController" bundle:nil];
        [self.navigationController pushViewController:bankCardVC animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
