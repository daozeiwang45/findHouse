//
//  DropDownListView.h
//  DropDownDemo
//
//  Created by GB.
//  Copyright (c) 2014年 GB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownChooseProtocol.h"

#define SECTION_BTN_TAG_BEGIN   1000
#define SECTION_IV_TAG_BEGIN    3000
@interface DropDownListView : UIView<UITableViewDelegate,UITableViewDataSource>{
    NSInteger currentExtendSection;     //当前展开的section ，默认－1时，表示都没有展开
}

@property (nonatomic, assign) id<DropDownChooseDelegate> dropDownDelegate;
@property (nonatomic, assign) id<DropDownChooseDataSource> dropDownDataSource;

@property (nonatomic, strong) UIView *mSuperView;
@property (nonatomic, strong) UIView *mTableBaseView;
@property (nonatomic, strong) UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *selectedArray;//用于存储选择过的cell的index;

- (id)initWithFrame:(CGRect)frame WithColumnNames:(NSArray *)columnNames dataSource:(id)datasource delegate:(id) delegate;
- (void)setTitle:(NSString *)title inSection:(NSInteger) section;

- (BOOL)isShow;
- (void)hideExtendedChooseView;

@end
