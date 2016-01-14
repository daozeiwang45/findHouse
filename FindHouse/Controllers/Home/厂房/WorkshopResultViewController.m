//
//  WorkshopResultViewController.m
//  FindHouse
//
//  Created by Tom on 16/1/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "WorkshopResultViewController.h"
#import "bxViewAdditions.h"
#import "ResultCell.h"
#import "OfficeFilterCell.h"
#import "WorkshopDetailViewController.h"

@interface WorkshopResultViewController ()<UIGestureRecognizerDelegate>
{
    UIButton *btn,*preBtn;
}
@property (strong, nonatomic) UITableView *tableView,*listV;
@property (nonatomic, strong) NSMutableArray *sectionArr;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIView *bgView;

@end

static NSString *cellID = @"resultCell";
static NSString *filterCell = @"officeFilterCell";
@implementation WorkshopResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.title = @"查找结果";
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_W, kSCREEN_H-39) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    currentSection = -1;
    _sectionArr = [NSMutableArray arrayWithArray:@[@[@"最近",@"最远"],@[@"最高",@"最低"],@[@"最大",@"最小",@""]]];
    NSArray *titles = @[@"距离",@"价格",@"位置"];
    CGSize imageSize=CGSizeZero, titleSize=CGSizeZero;
    for (int i=0 ; i<titles.count; i++) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kSCREEN_W/titles.count*i, 64, kSCREEN_W/titles.count, 50);
        btn.tag = i;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x4b283c) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        imageSize = btn.imageView.frame.size;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, imageSize.height+5, 0);
        titleSize = [btn.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: btn.titleLabel.font}];
        btn.imageEdgeInsets = UIEdgeInsetsMake(titleSize.height+5, 0, 0, - titleSize.width);
        
        btn.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i<titles.count && i != 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(kSCREEN_W/titles.count*i-1, 64+btn.height/4.0, 1, btn.height/2)];
            lineView.backgroundColor = UIColorFromRGB(0x4b283c);
            [self.view addSubview:lineView];
        }
    }

    
}
//MARK: private method
- (void)btnAction:(UIButton *)butn {
    
    btn = butn;
    _dataArr = [_sectionArr objectAtIndex:butn.tag];
    btnSection = butn.tag;
    [UIView animateWithDuration:.3 animations:^{
        butn.imageView.transform = CGAffineTransformRotate(butn.imageView.transform, DEGREES_TO_RADIANS(180));
        butn.imageView.transform = CGAffineTransformRotate(butn.imageView.transform, DEGREES_TO_RADIANS(180));
        
        [butn setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
    } completion:nil];
    
    if (currentSection == btnSection) {
        
        [butn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        [self hideListView];
    }else{
        currentSection = btnSection;
        if (preBtn != butn) {
            [preBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
            preBtn = butn;
        }
        [self showListView];
    }
}

- (void)showListView {
    
    if(!_listV){
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, btn.bottom, kSCREEN_W, kSCREEN_H-50)];
        //        self.bgView.backgroundColor = [UIColor purpleColor];
        UITapGestureRecognizer *tapGZ = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        tapGZ.delegate = self;
        [_bgView addGestureRecognizer:tapGZ];
        
        self.listV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_W, kSCREEN_H-50) style:UITableViewStylePlain];
        self.listV.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.listV.bounces = NO;
        self.listV.dataSource = self;
        self.listV.delegate = self;
        
    }
    rect.origin.x = self.listV.frame.origin.x;
    rect.origin.y = self.listV.frame.origin.y;
    rect.size.width = kSCREEN_W;
    rect .size.height = (_dataArr.count * 40) < 240 ? (_dataArr.count * 40):240;
    self.listV.frame = rect;
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.listV];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.backgroundColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:.75];
        self.listV.frame =  rect;
    }];
    
    [_listV reloadData];
    
}

- (void)hideListView {
    
    if (currentSection != -1) {
        currentSection = -1;
        [self.listV removeFromSuperview];
        [self.bgView removeFromSuperview];
    }
}

- (void)tapAction {
    
    [UIView animateWithDuration:.25 animations:^{
        btn.imageView.transform = CGAffineTransformRotate(btn.imageView.transform, DEGREES_TO_RADIANS(180));
        btn.imageView.transform = CGAffineTransformRotate(btn.imageView.transform, DEGREES_TO_RADIANS(180));
        
    } completion:^(BOOL finished) {
        [btn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        
    }];
    
    [self hideListView];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view==self.bgView ) {
        return YES;
    }else
        return NO;
}


//MARK: UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        return 5;
    }else
        return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tableView) {
        ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell ==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ResultCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        
        if (btnSection == 2&&indexPath.row == 2) {
            OfficeFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:filterCell];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"OfficeFilterCell" owner:self options:nil] lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
            
        UITableViewCell *cell;
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        if (_dataArr.count>1 && indexPath.row < _dataArr.count) {
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(cell.left+25, cell.bottom-1, kSCREEN_W-50, 0.5)];
            line.backgroundColor = [UIColor colorWithRed:75/255.0 green:45/255.0 blue:60/255.0 alpha:1];
            [cell.contentView addSubview:line];
        }
        
        cell.textLabel.text = _dataArr[indexPath.row];
        cell.textLabel.textColor = UIColorFromRGB(0x4b283c);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.indentationLevel = 1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        }
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _tableView) {
        
        WorkshopDetailViewController *detailVC = [[WorkshopDetailViewController alloc] initWithNibName:@"WorkshopDetailViewController" bundle:nil];
        detailVC.houseKind = _houseKind;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if (tableView == self.listV) {
        if (indexPath.row==0) {
            NSLog(@"123");
        }
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tableView) {
        return 220;
    }else
        return 40;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
