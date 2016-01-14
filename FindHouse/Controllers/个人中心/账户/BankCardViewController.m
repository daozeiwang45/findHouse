//
//  BankCardViewController.m
//  FindHouse
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BankCardViewController.h"
#import "bxViewAdditions.h"
#import "AddBankCardViewController.h"
#import "BankCardCell.h"

@interface BankCardViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cardData;
@end

static NSString *cellID = @"cardCell";
@implementation BankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"银行卡";
    _cardData = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, kSCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = self.footer;
    [_addCardBtn addTarget:self action:@selector(addCardAction) forControlEvents:UIControlEventTouchUpInside];
    [self loadData];
}

//MARK: Private Methods
- (void)loadData {
    NSArray *dummyArr = @[@[@"农业银行",@"尾号1111",@"储蓄卡"],@[@"建设银行",@"尾号1011",@"储蓄卡"]];
    _cardData = [dummyArr mutableCopy];
    
    [_tableView reloadData];
}
- (void)addCardAction {
    AddBankCardViewController *addBKCardVC = [[AddBankCardViewController alloc] initWithNibName:@"AddBankCardViewController" bundle:nil];
    [self.navigationController pushViewController:addBKCardVC animated:YES];
}

//MARK: UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cardData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BankCardCell" owner:self options:nil] lastObject];
    }
    cell.bankName.text = _cardData[indexPath.row][0];
    cell.tailNum.text = _cardData[indexPath.row][1];
    cell.cardType.text = _cardData[indexPath.row][2];
    if (_cardData.count>1 && indexPath.row < _cardData.count) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(25, cell.bottom-.5, kSCREEN_W-50, .5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:line];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
