//
//  MaintainItemsVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/25.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "MaintainItemsVC.h"
#import "MaintainItemCell.h"

@interface MaintainItemsVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation MaintainItemsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的tableView
    [self addTableView];
    
}

#pragma mark ******  设置导航栏  ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"保养项目"];
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ******  设置下面的tableView  ******
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 15*kRate, kScreenWidth, kScreenHeight - 64)];
    _tableView.backgroundColor = kRGBColor(233, 239, 239);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorColor = [UIColor clearColor];
    
    [self.view addSubview:_tableView];
}

#pragma mark --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _couponModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MaintainItemCell";
    
    MaintainItemCell *cell = (MaintainItemCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[MaintainItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    if (_couponModels.count > indexPath.row) {
        cell.couponModel = _couponModels[indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130*kRate;
}

@end

