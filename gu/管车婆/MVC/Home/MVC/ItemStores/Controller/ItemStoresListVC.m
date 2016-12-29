//
//  ItemStoresListVC.m
//  管车婆
//
//  Created by 李伟 on 16/12/14.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "ItemStoresListVC.h"
#import "StoreCell.h"
#import "StoreModel.h"

#define kHeadImgWidth kScreenWidth*2/7

@interface ItemStoresListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong)NSMutableArray *storeModels;
@end

@implementation ItemStoresListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _storeModels = [NSMutableArray array];
    
    //设置tableView
    [self addTableView];
    
    //网络请求商户列表数据
    [self getStores];
    
}


#pragma  mark *****************  设置tableView  ****************
- (void)addTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight -110*kRate)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorColor:[UIColor clearColor]];//去除单元格之间的分割线
    _tableView.backgroundColor = kRGBColor(233, 233, 233);
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
        StoreModel *currentModel = _storeModels[indexPath.row];
        cell.storeModel = currentModel;
    }
    
    cell.vc = self.vc;
    cell.sid = _superID;
    
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
#pragma mark 网络请求
//获取商户列表
- (void)getStores
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getMerchant.action", kHead];

    NSString *locationStr = [NSString stringWithFormat:@"%@,%@", [[self getLocalDic] objectForKey:@"longitude"], [[self getLocalDic] objectForKey:@"phone"]];
    
    NSLog(@"_superID:%@,_type:%@,location:%@", _superID, _type, locationStr);
    
    NSDictionary *params = @{
                             @"superid":_superID,
                             @"orderby":_type,//按距离、单量还是好评
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
        for (NSDictionary *jsondataDic in jsondataArr) {
            StoreModel *storeModel = [[StoreModel alloc] initWithDic:jsondataDic];
            [_storeModels addObject:storeModel];
        }
        
        //刷新tableView
        [_tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

}

@end
