//
//  ItemStoresListVC.m
//  管车婆
//
//  Created by 李伟 on 16/12/14.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "ItemStoresListVC.h"
#import "StoreCell.h"


#define kHeadImgWidth kScreenWidth*2/7

@interface ItemStoresListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation ItemStoresListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    _tableView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    _tableView.allowsSelection = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AppointmentCell";
    
    StoreCell *cell = (StoreCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    StoreModel *storeModel = [[StoreModel alloc] init];
    
    if (!cell) {
        cell = [[StoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.storeModel = storeModel;
    cell.vc = self.vc;
    
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
    
    NSLog(@"_superID:%@,_type:%@", _superID, _type);
    
    NSDictionary *params = @{
                             @"superid":_superID,
                             @"orderby":_type,//按距离、单量还是好评
                             @"location":@"116.365825000,37.441313000",
                             @"currsize":@"0",
                             @"pagesize":@"10"
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@", content);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

}

@end
