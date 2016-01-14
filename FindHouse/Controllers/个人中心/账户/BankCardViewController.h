//
//  BankCardViewController.h
//  FindHouse
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    AddMode,
    Edit
}CardMode;

@interface BankCardViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *footer;
@property (weak, nonatomic) IBOutlet UIButton *addCardBtn;

@end
