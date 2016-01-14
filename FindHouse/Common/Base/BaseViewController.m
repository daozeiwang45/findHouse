//
//  BaseViewController.m
//  FindHouse
//
//  Created by admin on 15/12/17.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    NSInteger viewCtrlCount;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x.png"]];
    //设置标题的颜色
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName:UIColorFromRGB(0x000000),
                          NSFontAttributeName:[UIFont systemFontOfSize:15]
                          };
    [self.navigationController.navigationBar setTitleTextAttributes:dic];
    
    [self _initBackButton];
}

//MARK: private Method
//添加返回按钮
- (void)_initBackButton {
    
    //取得视图控制器对应的导航控制器
    UINavigationController *navCtrl = self.navigationController;
    UIImageView *msgIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    msgIV.image = [UIImage imageNamed:@"message"];
    UIControl *rightBtn = [[UIControl alloc] initWithFrame:msgIV.bounds];
    [msgIV addSubview:rightBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:msgIV];
    [rightBtn addTarget:self action:@selector(msgAction) forControlEvents:UIControlEventTouchUpInside];
    
    if (navCtrl.viewControllers.count > 1 || _isModal == YES) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.showsTouchWhenHighlighted = YES;
        backButton.frame = CGRectMake(0, 0, 25, 25);
        [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal]; // 图片待设置
        //添加点击事件
        [backButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        //设置返回手势
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    viewCtrlCount = self.navigationController.viewControllers.count;
    if (viewCtrlCount > 1)
    {
        [self.navigationController.tabBarController.tabBar setHidden:YES];
    }
    else
    {
        [self.navigationController.tabBarController.tabBar setHidden:NO];
    }
    
}
- (void)buttonAction {
    
    if (_isModal) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)msgAction {
    
    NSLog(@"消息窗口待续");
}



-(void)showErrorWithString:(NSString *)str{
    
    
    [self.view makeToast:str duration:3 position:CSToastPositionCenter title:@"千方百计  温馨提示" image:[UIImage imageNamed:@"cuowutishi"]];
    
}

-(void)showSuccessWithString:(NSString *)str{
    
    [self.view makeToast:str duration:3 position:CSToastPositionCenter title:@"千方百计  温馨提示" image:[UIImage imageNamed:@"zhengquetishi"]];
    
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
