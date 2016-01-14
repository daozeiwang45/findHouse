//
//  OneBuyViewController.m
//  FindHouse
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 admin. All rights reserved.
//

#import "OneBuyViewController.h"
#import "bxViewAdditions.h"
#import "YSLDraggableCardContainer.h"
#import "CardView.h"
#import "QianRecmdVController.h"
#import "HouseDetailViewController.h"
#import "SearchHouseViewController.h"

@interface OneBuyViewController ()<YSLDraggableCardContainerDelegate, YSLDraggableCardContainerDataSource>
@property (weak, nonatomic) IBOutlet UIButton *upperBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet YSLDraggableCardContainer *cardContainer;
@property (weak, nonatomic) IBOutlet CardView *cardView;
@property (nonatomic, strong) NSMutableArray *datas;



@end

@implementation OneBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"一键买房";
    _datas = [NSMutableArray arrayWithObjects:@"placeholder",@"placeholder",@"placeholder",@"placeholder", nil];
    [_upperBtn addTarget:self action:@selector(qianfangAction) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBtn addTarget:self action:@selector(houseSearchAction) forControlEvents:UIControlEventTouchUpInside];
    _cardContainer.delegate = self;
    _cardContainer.dataSource = self;
    _cardContainer.canDraggableDirection = YSLDraggableDirectionLeft | YSLDraggableDirectionRight;
    [_cardContainer reloadCardContainer];
}

#pragma mark -- private Methods
- (void)qianfangAction {
    QianRecmdVController *qianRecmdVC = [[QianRecmdVController alloc] init];
    qianRecmdVC.houseKind = SaleKind;
    [self.navigationController pushViewController:qianRecmdVC animated:YES];
}
- (void)houseSearchAction {
    SearchHouseViewController *seaHouseVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchHouse"];
    [self.navigationController pushViewController:seaHouseVC animated:YES];
}

#pragma mark -- YSLDraggableCardContainer DataSource
- (UIView *)cardContainerViewNextViewWithIndex:(NSInteger)index
{
    CardView *view = [[[NSBundle mainBundle] loadNibNamed:@"CardView" owner:self options:nil]lastObject];
    view.top = 130+10;
    view.centerX = self.view.centerX;
    view.backgroundColor = [UIColor whiteColor];
    view.imageView.image = [UIImage imageNamed:_datas[index]];
    view.priceLbl.text = [NSString stringWithFormat:@"%ld",(long)index];;
    
    return view;
}

- (NSInteger)cardContainerViewNumberOfViewInIndex:(NSInteger)index
{
    return _datas.count;
}

#pragma mark -- YSLDraggableCardContainer Delegate
- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didEndDraggingAtIndex:(NSInteger)index draggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection
{
    if (draggableDirection == YSLDraggableDirectionLeft) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
        NSLog(@"zuo");
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        [cardContainerView movePositionWithDirection:draggableDirection
                                         isAutomatic:NO];
        NSLog(@"you");
    }
    
}

- (void)cardContainderView:(YSLDraggableCardContainer *)cardContainderView updatePositionWithDraggableView:(UIView *)draggableView draggableDirection:(YSLDraggableDirection)draggableDirection widthRatio:(CGFloat)widthRatio heightRatio:(CGFloat)heightRatio
{
    CardView *view = (CardView *)draggableView;
    
    if (draggableDirection == YSLDraggableDirectionDefault) {
        view.selectedView.alpha = 0;
    }
    
    if (draggableDirection == YSLDraggableDirectionLeft) {
        view.selectedView.backgroundColor = [UIColor colorWithRed:215 green:104 blue:91 alpha:1];
        view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionRight) {
        view.selectedView.backgroundColor = [UIColor colorWithRed:114 green:209 blue:142 alpha:1];
        view.selectedView.alpha = widthRatio > 0.8 ? 0.8 : widthRatio;
    }
    
    if (draggableDirection == YSLDraggableDirectionUp) {
        view.selectedView.backgroundColor = [UIColor colorWithRed:66 green:172 blue:225 alpha:1];;
        view.selectedView.alpha = heightRatio > 0.8 ? 0.8 : heightRatio;
    }
}

- (void)cardContainerViewDidCompleteAll:(YSLDraggableCardContainer *)container;
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [container reloadCardContainer];
    });
}

- (void)cardContainerView:(YSLDraggableCardContainer *)cardContainerView didSelectAtIndex:(NSInteger)index draggableView:(UIView *)draggableView
{
    NSLog(@"++ index : %ld",(long)index);
    HouseDetailViewController *detailVC = [[HouseDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];

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
