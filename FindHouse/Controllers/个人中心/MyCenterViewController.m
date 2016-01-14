//
//  MyCenterViewController.m
//  FindHouse
//
//  Created by 许景源 on 16/1/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MyCenterViewController.h"
#import "kPersonalTableViewCell.h"
#import "MyCenterOneTableViewCell.h"
#import "MyAccountViewController.h"
#import "AccountViewController.h"


@interface MyCenterViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    
    NSArray *tittleArry;//标题数组
}

@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self naView];
    [self initUI];
}

#pragma mark --------- 初始化导航栏按钮
- (void)naView {
    
    UIButton *releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    releaseBtn.frame = CGRectMake(0, 0, 80, 30);
    [releaseBtn setTitle:@"发布房源" forState:UIControlStateNormal];
    releaseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [releaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [releaseBtn addTarget:self action:@selector(releaseAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseBtn];
}
#pragma mark --------- 初始化--创建视图
- (void)initUI {
    
    self.isLogin = YES;
    
    if (self.isLogin) {
        
        self.loginView.hidden = YES;
        self.myHeadView.hidden = NO;
    }else{
        
        self.loginView.hidden = NO;
        self.myHeadView.hidden = YES;
    }
    
    self.headImgV.layer.masksToBounds = YES;
    self.headImgV.layer.cornerRadius = self.headImgV.frame.size.height/2;
    
    tittleArry = @[@[@"",@""],@[@"房产管理",@"账单"],@[@"积分信用",@"足迹"],@[@"联系客服",@"设置"]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myContentView];
    //创建视图

    
}


#pragma mark  -------行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 2;
            break;
            
        default: return 0;
            break;
    }
    
}

#pragma mark  -------表格数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //账户信息数据
    if (indexPath.section != 0) {
        
        kPersonalTableViewCell *cell =(kPersonalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"kPersonalTableViewCell" owner:self options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (indexPath.section < tittleArry.count) {
            
            cell.tittleLab.text = tittleArry[indexPath.section][indexPath.row];
        }
        
        if (indexPath.section == 1) {
            
            switch (indexPath.row) {
                case 0:
                    cell.imgView.image = [UIImage imageNamed:@"27"];
                    cell.detailLab.text = @"3个";
                    break;
                case 1:
                    cell.imgView.image = [UIImage imageNamed:@"26"];
                    cell.detailLab.text = @"3个未付款";
                    break;
                case 2:
                    cell.imgView.image = [UIImage imageNamed:@"ask-question@3x"];
                    cell.detailLab.text = @"3个未付款";
                    break;
                    
                default:
                    break;
            }
        }
        if (indexPath.section == 2) {
            
            switch (indexPath.row) {
                case 0:
                    cell.imgView.image = [UIImage imageNamed:@"25"];
                    cell.detailLab.text = @"5星级";
                    break;
                case 1:
                    cell.imgView.image = [UIImage imageNamed:@"2222224"];
                    cell.detailLab.text = @"38条";
                    break;
                    
                default:
                    break;
            }
            
        }
        if (indexPath.section == 3) {
            
            switch (indexPath.row) {
                case 0:
                    cell.imgView.image = [UIImage imageNamed:@"23"];
                    cell.detailLab.text = @"委托代理";
                    break;
                case 1:
                    cell.imgView.image = [UIImage imageNamed:@"22"];
                    cell.detailLab.text = @"12缓存";
                    break;
                    
                default:
                    break;
            }
            
        }
        
        
        return cell;
        
    }else{
        
   
        MyCenterOneTableViewCell *cell =(MyCenterOneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@""];
        if (!cell) {
            
            cell = [[[NSBundle mainBundle]loadNibNamed:@"MyCenterOneTableViewCell" owner:self options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

        
        return cell;
    }
    
    
    return nil;
}

#pragma mark -------分区数
//分区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 4;
}

#pragma mark -------分区头部高度
//下面是设置一些头部高度什么的
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.1;
}

#pragma mark ------分区底部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 1;
    }
    return 10;
}

#pragma mark --------行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}

#pragma mark ----------点击实事件
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        //跳转到账户信息
        AccountViewController *accountVC = [AccountViewController new];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            
        }
    }
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            
            
        }
    }
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            
        }
    }
    
    
}


#pragma mark --------- 发布房源按钮事件
- (void)releaseAction {
    
    NSLog(@"发布房源待续");
    
}

#pragma mark --------- 跳转到我的账户
- (IBAction)pushToMyCountAction:(UIButton *)sender {
    
    MyAccountViewController *myAccountVC = [MyAccountViewController new];
    [self.navigationController pushViewController:myAccountVC animated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
