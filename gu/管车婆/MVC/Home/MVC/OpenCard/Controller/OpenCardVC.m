//
//  OpenCardVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/7.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OpenCardVC.h"
#import "OpenCardCell.h"

@interface OpenCardVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation OpenCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的卡片列表
    [self addTableView];
}

#pragma mark ****** 设置导航栏 ******
- (void)addNavBar
{
    [self setNavigationItemTitle:@"在线快捷办卡"];
    [self setBackButtonWithImageName:@"back"];
}

#pragma mark ****** 设置下面的卡片列表 ******
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10*kRate, kScreenWidth, kScreenHeight-10*kRate)];
    _tableView.backgroundColor = [UIColor colorWithRed:230/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
}

#pragma mark --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"OpenCardCell";
    
    OpenCardCell *cell = (OpenCardCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[OpenCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240*kRate;
}



@end
