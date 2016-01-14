//
//  SignToPayViewController.m
//  FindHouse
//
//  Created by Tom on 16/1/5.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SignToPayViewController.h"
#import "PayViewController.h"

@interface SignToPayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *immediatePayBtn;

@end

@implementation SignToPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付";
    [_immediatePayBtn addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)payAction {
    
    PayViewController *payVC = [[PayViewController alloc] initWithNibName:@"PayViewController" bundle:nil];
    payVC.modalPresentationStyle = UIModalPresentationCustom;
    [self.navigationController presentViewController:payVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
