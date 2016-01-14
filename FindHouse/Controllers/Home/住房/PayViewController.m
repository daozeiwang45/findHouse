//
//  PayViewController.m
//  FindHouse
//
//  Created by admin on 16/1/6.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "PayViewController.h"
#import "PaySuccessViewController.h"

@interface PayViewController ()
- (IBAction)cancelBtn:(UIButton *)sender;
- (IBAction)certainAction:(UIButton *)sender;

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:64/255.0 green:64/255.0 blue:64/255.0 alpha:.75];

}

- (IBAction)cancelBtn:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)certainAction:(UIButton *)sender {
    
    PaySuccessViewController *paySuccessVC = [[PaySuccessViewController alloc] initWithNibName:@"PaySuccessViewController" bundle:nil];
    paySuccessVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:paySuccessVC animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
