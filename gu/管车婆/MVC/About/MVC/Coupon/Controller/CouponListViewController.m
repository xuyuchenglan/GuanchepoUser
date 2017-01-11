//
//  CouponListViewController.m
//  管车婆
//
//  Created by 李伟 on 16/11/10.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CouponListViewController.h"
#import "LWCouponCell.h"
#import "AboutCouponModel.h"

#define kCellWidth (kScreenWidth - 10*kRate*2)

@interface CouponListViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}
@property (nonatomic, strong)NSMutableArray *aboutCouponModels;
@end

@implementation CouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _aboutCouponModels = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, kScreenHeight - 64 - 10*kRate - 45*kRate)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView setSeparatorColor:[UIColor clearColor]];//去除单元格之间的分割线
    _tableView.backgroundColor = kRGBColor(233, 233, 233);
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
}

- (void)setType:(NSString *)type
{
    _type = type;
    
    //网络获取优惠券列表
    [self getYouhuiquan];
}

#pragma mark UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _aboutCouponModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"LWCouponCell";
    
    LWCouponCell *cell = (LWCouponCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[LWCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        cell.type = @"jianmianquan";
    } else if (indexPath.row == 1) {
        cell.type = @"dazhequan";
    } else {
        cell.type = @"tiyanquan";
    }
    
    AboutCouponModel *currentModel = _aboutCouponModels[indexPath.row];
    cell.aboutCouponModel = currentModel;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (kCellWidth*0.289+15*kRate);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选中单元格时高亮显示，交互完成之后移除高亮显示。
    [self performSelector:@selector(unselectCell:) withObject:nil afterDelay:0.3];//0.3秒后取消单元格选中状态。
}

-(void)unselectCell:(id)sender{
    
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}


#pragma mark
#pragma mark 网络获取优惠券列表
- (void)getYouhuiquan
{
    NSLog(@"网络请求优惠券列表");
    
    NSString *url_post = [NSString stringWithFormat:@"http://%@getYouhuiquan.action", kHead];
    
//    NSDictionary *params = @{
//                             @"uid":[[self getLocalDic] objectForKey:@"uid"],
//                             @"type":_type
//                             };
    
    NSDictionary *params = @{
                             @"uid":@"f1c94e63ae3343eb9b044333d8c12c79",
                             @"type":_type
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"优惠券列表：%@", content);
        
        NSArray *jsondataArr = [content objectForKey:@"jsondata"];
        
        if (jsondataArr.count > 0) {//防止数组越界
            
            for (NSDictionary *dic in jsondataArr) {
                AboutCouponModel *model = [[AboutCouponModel alloc] initWithDic:dic];
                [_aboutCouponModels addObject:model];
            }
            
            //刷新UI
            [_tableView reloadData];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

}


@end
