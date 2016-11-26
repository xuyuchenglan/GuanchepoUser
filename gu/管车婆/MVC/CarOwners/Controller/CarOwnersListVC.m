//
//  CarOwnersListVC.m
//  管车婆
//
//  Created by 李伟 on 16/9/28.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CarOwnersListVC.h"
#import "CarOwnersCell.h"

@interface CarOwnersListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation CarOwnersListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tableView
    [self addTableView];
    
    
}

#pragma  mark *****************  设置tableView  ****************
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 16*kRate, kScreenWidth, kScreenHeight - 160)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorColor:[UIColor clearColor]];//去除单元格之间的分割线
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}





#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CarOwnersCell";
    
    CarOwnersCell *cell = (CarOwnersCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[CarOwnersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.layer.cornerRadius = 8.0*kRate;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CarOwnersModel *newModel = [[CarOwnersModel alloc] init];
    switch (indexPath.row) {
        case 0:
            newModel.flag = FlagModelNO;
            break;
            
        case 1:
            newModel.flag = FlagModelYES;
            break;
            
        case 2:
            newModel.flag = FlagModelNO;
            break;
            
        default:
            newModel.flag = FlagModelYES;
            break;
    }
    cell.carOwnersModel = newModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175*kRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}





@end
