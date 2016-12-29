//
//  CarOwnersListVC.m
//  管车婆
//
//  Created by 李伟 on 16/9/28.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CarOwnersListVC.h"
#import "CarOwnersCell.h"
#import "ADViewController.h"

@interface CarOwnersListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, copy)NSArray *models;
@end

@implementation CarOwnersListVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        //监听CarOwnersViewController中请求完当前页面的新闻列表的数据后发送过来的通知，以更新UI
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCarOwnersListVC:) name:@"reloadCarOwnersListVC" object:nil];
    }
    return self;
}

- (void) reloadCarOwnersListVC:(NSNotification *)info
{
    NSString *type = info.userInfo[@"type"];
    
    if ([type isEqualToString: self.type]) {
        _models = info.userInfo[@"models"];
        [_tableView reloadData];
    }
}

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
    _tableView.backgroundColor = kRGBColor(233, 233, 233);
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}





#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _models.count;
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
    
//    CarOwnersModel *newModel = [[CarOwnersModel alloc] init];
//    switch (indexPath.row) {
//        case 0:
//            newModel.flag = FlagModelNO;
//            break;
//            
//        case 1:
//            newModel.flag = FlagModelYES;
//            break;
//            
//        case 2:
//            newModel.flag = FlagModelNO;
//            break;
//            
//        default:
//            newModel.flag = FlagModelYES;
//            break;
//    }
//    cell.carOwnersModel = newModel;
    
    NewsModel *currentModel = _models[indexPath.row];
    cell.newsModel = currentModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 175*kRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *currentModel = _models[indexPath.row];
    
    ADViewController *adViewController = [[ADViewController alloc] init];
    adViewController.linkUrl = [NSString stringWithFormat:@"%@", currentModel.linkUrl];
    adViewController.titleStr = currentModel.titleStr;
    adViewController.hidesBottomBarWhenPushed = YES;
    [self.vc.navigationController pushViewController:adViewController animated:NO];
    adViewController.hidesBottomBarWhenPushed = NO;

    
}


#pragma mark
#pragma mark 复写deallock,移除通知观察者
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
