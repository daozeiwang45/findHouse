//
//  MineViewController.m
//  FindHouse
//
//  Created by 许景源 on 16/1/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "MineViewController.h"
#import "MineOneCollectionViewCell.h"
#import "FirstStyleCollectionViewCell.h"
#import "TwoStyleCollectionViewCell.h"
#import "HospitalMealTableViewCell.h"
#import "ZHPickView.h"
#import "TestController.h"



@interface MineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ZHPickViewDelegate>

@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.title = @"我";
    
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
    
    self.view.backgroundColor = [UIColor redColor];
    //创建视图
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_W,kSCREEN_H)collectionViewLayout:flowLayout];

    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
   
    //头部视图
    [self.collectionView registerClass:[MineOneCollectionViewCell class] forCellWithReuseIdentifier:@"MineOnecell"];
    
    //-------第一种按钮------
    [self.collectionView registerClass:[FirstStyleCollectionViewCell class] forCellWithReuseIdentifier:@"cellFirst"];
    //-------第二种按钮------
    [self.collectionView registerClass:[TwoStyleCollectionViewCell class] forCellWithReuseIdentifier:@"cellTwo"];
    
    
    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:self.collectionView];

}

#pragma mark 分区数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
#pragma mark  定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 9;
    }
    if (section == 2) {
        
        return 3;
    }
    return 1;
}
#pragma mark 单元格内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section)
    {
            
        case 0://头部内容
        {
            MineOneCollectionViewCell * cell1 = (MineOneCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MineOnecell" forIndexPath:indexPath];

            return cell1;

        
        }
            break;
        case 1://按钮（---------等）
        {
            
            FirstStyleCollectionViewCell * cell2 = (FirstStyleCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellFirst" forIndexPath:indexPath];
            cell2.layer.borderColor=[UIColor colorWithWhite:0.902 alpha:1.000].CGColor;
            cell2.layer.borderWidth=0.3;
            
            cell2.tittleLab.text = @"找套餐";
            if (indexPath.row == 0) {
                
                if (iphoneFrame) {
                    
                    cell2.imgView.image = [UIImage imageNamed:@"mixture@3x"];
                }else{
                    
                    cell2.imgView.image = [UIImage imageNamed:@"mixture"];
                }
                cell2.tittleLab.text = @"找套餐";
                
            }
            if (indexPath.row == 1) {
                
                if (iphoneFrame) {
                    
                    cell2.imgView.image = [UIImage imageNamed:@"形状-1-拷贝-2@3x"];
                }else{
                    
                    cell2.imgView.image = [UIImage imageNamed:@"形状-1-拷贝-2"];
                }
                cell2.tittleLab.text = @"找医院";
                
            }
            if (indexPath.row == 2) {
                
                if (iphoneFrame) {
                    
                    cell2.imgView.image = [UIImage imageNamed:@"support@3x"];
                }else{
                    
                    cell2.imgView.image = [UIImage imageNamed:@"support"];
                }
                cell2.tittleLab.text = @"在线咨询";
                
            }
            
            
            return cell2;
        }
            break;
            
            
        default:
            return nil;
            break;
    }
    return nil;
}
#pragma mark ---------选中方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
            _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        
            [_pickview setTintColor:[UIColor redColor]];
            _pickview.delegate=self;
            
            [_pickview show];

        }
        if (indexPath.row == 1) {
            
            
            TestController *testVC = [[TestController alloc]init];
            [self.navigationController pushViewController:testVC animated:YES];
            
        }
        if (indexPath.row == 2){
            
            NSLog( @"------------在线咨询");
            
        }
        
    }
    NSLog( @"------------在线咨询");
    
    
}

#pragma mark 定义每个UICollectionViewCell 之间的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.1;
}
#pragma mark 定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return CGSizeMake(kSCREEN_W, 250);
    }
    if (indexPath.section == 1) {
        
        //return  CGSizeMake(WIDTHMAIN/2-0.1, 140);
        return CGSizeMake(kSCREEN_W/3-0.1, 120);
    }
    if (indexPath.section == 2) {
        
        return  CGSizeMake(kSCREEN_W/3-0.1, 120);
    }
    return CGSizeMake(0, 0);
    
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}



#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    NSLog( @"----------%@",resultString);
}



#pragma mark --------- 发布房源按钮事件
- (void)releaseAction {
    
    NSLog(@"发布房源待续");
    
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
