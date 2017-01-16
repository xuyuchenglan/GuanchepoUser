//
//  OpenCardVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/7.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "OpenCardVC.h"
#import "OpenCardCell.h"
#import "OpenCardModel.h"

@interface OpenCardVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, copy) NSArray *opencardModels;
@end

@implementation OpenCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下面的卡片列表
    [self addTableView];
    
    //网络请求卡片列表数据
    [self getCardList];
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
    _tableView.backgroundColor = kRGBColor(230, 236, 236);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
}

#pragma mark --- UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _opencardModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"OpenCardCell";
    
    OpenCardCell *cell = (OpenCardCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[OpenCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    if (_opencardModels.count > indexPath.row) {
        cell.openCardModel = _opencardModels[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 240*kRate;
}

#pragma mark
#pragma mark --- 网络请求
//获得卡片列表
- (void)getCardList
{
    NSString *url_get = [NSString stringWithFormat:@"http://%@getCardTypeList.action", kHead];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//单例
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url_get parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *jsonDataArr = [responseObject objectForKey:@"jsondata"];
//        NSLog(@"%@", jsonDataArr);
        NSMutableArray *muArr = [NSMutableArray array];
        for (NSDictionary *jsonDataDic in jsonDataArr) {
            
            OpenCardModel *openCardModel = [[OpenCardModel alloc] initWithDic:jsonDataDic];
            [muArr addObject:openCardModel];
            
        }
        _opencardModels = muArr;
        
        //刷新UI
        [_tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败，原因是%@", error);
        
    }];

}

@end
