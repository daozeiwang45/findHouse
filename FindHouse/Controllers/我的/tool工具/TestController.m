//
//  TestViewController.m
//  FindHouse
//
//  Created by 许景源 on 16/1/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TestController.h"
#import "ZHPickView.h"


@interface TestController ()<ZHPickViewDelegate>

@property(nonatomic,strong)ZHPickView *pickview;

@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];

    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)myButtonAction:(UIButton *)sender {
    
//    NSDate *date=[NSDate dateWithTimeIntervalSinceNow:9000000];
//    _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
//    
//    //_pickview.frame = CGRectMake(0, 0, WIDTHMAIN,_pickview.frame.size.height);
//    
//    [_pickview setPickViewColer:[UIColor redColor]];
//    [_pickview setToolbarTintColor:[UIColor redColor]];
//    _pickview.delegate=self;
//    
//    [_pickview show];
    
    
    NSDate *date = [NSDate date];
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:nil
                                                                      datePickerMode:UIDatePickerModeDate
                                                                        selectedDate:date
                                                                         minimumDate:nil
                                                                         maximumDate:[NSDate date]
                                                                              target:self
                                                                              action:@selector(endDateSelected:)
                                                                              origin:sender];
    

    datePicker.hideCancel = NO;
    [datePicker showActionSheetPicker];

    
}

-(void)endDateSelected:(NSDate*)date{
    
    NSLog(@"--------%@",date);
}



#pragma mark -----------选择器代理ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    
    NSLog( @"----------%@",resultString);
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
