//
//  CarCouponListVC.m
//  管车婆
//
//  Created by 李伟 on 16/11/3.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CarCouponListVC.h"
#import "CarCouponCell.h"
#import "CarCouponModel.h"
#import "CarCouponInfoVC.h"
#import "CarCouponVC.h"

@interface CarCouponListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong)NSMutableArray *carCoupons;
@end

@implementation CarCouponListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _carCoupons = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = kRGBColor(233, 239, 239);
    _tableView.tableFooterView = [UIView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, (kScreenHeight - 64 - 45*kRate - 10*kRate)));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.view).with.offset(10*kRate);
    }];
    
    //网络请求“我的汽车券”
    [self getCarCoupons];
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _carCoupons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CarCouponCell";
    
    CarCouponCell *cell = (CarCouponCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[CarCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    cell.type = _type;
    
    if (_carCoupons.count > indexPath.row) {
        cell.carCouponModel = _carCoupons[indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170*kRate;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中单元格时高亮显示，交互完成之后移除高亮显示。
    [self performSelector:@selector(unselectCell:) withObject:nil afterDelay:0.3];//0.3秒后取消单元格选中状态。
    
    CarCouponModel *currentModel = _carCoupons[indexPath.row];
    
    CarCouponInfoVC *carCouponInfoVC = [[CarCouponInfoVC alloc] init];
    carCouponInfoVC.hidesBottomBarWhenPushed = YES;
    carCouponInfoVC.carCouponModel = currentModel;
    [[self findResponderVCWith:[[CarCouponVC alloc] init]].navigationController pushViewController:carCouponInfoVC animated:NO];
}

-(void)unselectCell:(id)sender{
    
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}


#pragma mark 
#pragma mark 网络请求汽车券列表
- (void)getCarCoupons
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getDianpuquan.action", kHead];
    
    NSDictionary *params = @{
                             @"uid":[[self getLocalDic] objectForKey:@"uid"],
                             @"stype":_type,
                             @"currsize":@"0",
                             @"pagesize":@"10"
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"我的店铺券：%@", content);
        
        [_carCoupons removeAllObjects];
        
        NSArray *jsondataArr = [content objectForKey:@"jsondata"];
        for (NSDictionary *dic in jsondataArr) {
            CarCouponModel *carCouponModel = [[CarCouponModel alloc] initWithDic:dic];
            [_carCoupons addObject:carCouponModel];
        }
        
        //刷新tableView
        [_tableView reloadData];
        
    } failure:nil];
}

@end
