//
//  StoresListVC.m
//  管车婆
//
//  Created by 李伟 on 16/9/28.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "StoresListVC.h"
#import "StoreCell.h"
#import "StoreModel.h"
#import "StoresViewController.h"

#define kHeadImgWidth kScreenWidth*2/7

@interface StoresListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView      *_topView;
    UITableView *_tableView;
    UILabel     *_carInfoLB;
}
@property (nonatomic, strong)NSMutableArray *storeModels;
@end

@implementation StoresListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _storeModels = [NSMutableArray array];
    
    //设置tableView上方的显示汽车信息的View
    [self addTopView];
    
    //设置tableView
    [self addTableView];
    
    //在刚进入页面的时候先来一波默认的网络请求，以免一开始进来的时候没有数据
    [self getStoresWithSuperid:_sid];
    
}

#pragma mark *************** 设置tableView上方的显示汽车信息的View *****************
- (void)addTopView
{
    //接收StoresViewController发送过来的通知，更新carInfoLB里的内容
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCarInfoLB:) name:@"showSelectedServe" object:nil];
    
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35*kRate)];
    [self.view addSubview:_topView];
    
    _carInfoLB = [[UILabel alloc] initWithFrame:CGRectMake(20*kRate, 5*kRate, 100*kRate, 25*kRate)];
    _carInfoLB.font = [UIFont systemFontOfSize:14.0*kRate];
    _carInfoLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    _carInfoLB.text = _name;//默认的二级细分服务
    [_topView addSubview:_carInfoLB];
}

- (void)updateCarInfoLB:(NSNotification *)notification
{
    NSDictionary *selectedServeDic = [notification userInfo];
    
    NSString *type = [selectedServeDic objectForKey:@"type"];
    
    if ([type isEqualToString:_type]) {//确保只有相应的页面才会做改变，而非所有的页面都改变
        
        _carInfoLB.text = [selectedServeDic objectForKey:@"selectedServe"];
        
        //网络请求商户列表
        [self getStoresWithSuperid:[selectedServeDic objectForKey:@"sid"]];
    }
}

#pragma  mark *****************  设置tableView  ****************
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), kScreenWidth, kScreenHeight - 180*kRate)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorColor:[UIColor clearColor]];//去除单元格之间的分割线
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.allowsSelection = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
     
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _storeModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AppointmentCell";
    
    StoreCell *cell = (StoreCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (_storeModels.count > indexPath.row) {
        cell.storeModel = _storeModels[indexPath.row];
    }
    
    cell.vc = _vc;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeadImgWidth*0.85 + 10*2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 
#pragma mark 网络请求
//获取商户列表
- (void)getStoresWithSuperid:(NSString *)superid
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getMerchant.action", kHead];
    
    NSString *locationStr = [NSString stringWithFormat:@"%@,%@", [[self getLocalDic] objectForKey:@"longitude"], [[self getLocalDic] objectForKey:@"phone"]];
    
    NSDictionary *params = @{
                             @"superid":superid,
                             @"orderby":@"1",//固定为1，按距离
                             @"location":locationStr,
                             @"currsize":@"0",
                             @"pagesize":@"10"
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *jsondataArr = [content objectForKey:@"jsondata"];
        
        [_storeModels removeAllObjects];
        for (NSDictionary *jsondataDic in jsondataArr) {
            StoreModel *storeModel = [[StoreModel alloc] initWithDic:jsondataDic];
            [_storeModels addObject:storeModel];
        }
        
        NSLog(@"%@", _storeModels);
        //刷新tableView
        [_tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
    
}

@end
