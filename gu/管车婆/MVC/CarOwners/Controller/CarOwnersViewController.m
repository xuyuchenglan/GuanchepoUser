//
//  CarOwnersViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "CarOwnersViewController.h"
#import "CarOwnersListVC.h"
#import "CarOwnerClassifyModel.h"
#import "NewsModel.h"

@interface CarOwnersViewController ()

@property (nonatomic, strong)NSMutableArray *titleModels;

@end

@implementation CarOwnersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleModels = [NSMutableArray array];
    
    //设置导航栏
    [self addNavBar];
    
    //网络申请种类数据
    [self getClasstypeAction];
    
    //设置下面的同步滑动视图
    //同步滑动视图是在网络请求成功以后进行设置的
}

#pragma mark ******************      设置导航栏      ****************
- (void)addNavBar
{
    //标题
    [self setNavigationItemTitle:@"车一族"];
    
    //距离搜索按钮
    
}


#pragma mark ******************  设置同步滑动视图  ****************
- (void)addSyncScrollView
{
    NSMutableArray *titleArr = [NSMutableArray array];
    NSMutableArray *controllerArr = [NSMutableArray array];
    
    for (CarOwnerClassifyModel *currentModel in _titleModels) {
        NSString *title = currentModel.classifyname;
        [titleArr addObject:title];
        
        CarOwnersListVC *vc = [[CarOwnersListVC alloc] init];
        vc.type = currentModel.classifyid;
        vc.vc = self;
        [controllerArr addObject:vc];
    }
    
    self.titleArray = [titleArr copy];
    self.controllerArray = [controllerArr copy];
    
}

//点击标题按钮后进行相关网络请求并更新页面
- (void)getCarFamilyAndUpdateUIWithBtn:(UIButton *)btn
{
    int index = (int)btn.tag - 100;
    
    CarOwnerClassifyModel *currentModel = _titleModels[index];
    NSLog(@"%@", currentModel.classifyid);
    
    NSString *url_post = [NSString stringWithFormat:@"http://%@getCarFamily.action", kHead];
    
    
    NSDictionary *params = @{
                             @"type":currentModel.classifyid,
                             @"currsize":@"0",
                             @"pagesize":@"10"
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *newsModelsMu = [NSMutableArray array];
        
        NSArray *jsondataArr = [content objectForKey:@"jsondata"];
        for (NSDictionary *dic in jsondataArr) {
            NewsModel *model = [[NewsModel alloc] initWithDic:dic];
            [newsModelsMu addObject:model];
        }
        
        //给CarOwnersListVC发送一个通知，使相关页面更新UI
        NSDictionary *notificationDic = @{
                                          @"type":currentModel.classifyid,
                                          @"models":newsModelsMu
                                          };
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadCarOwnersListVC" object:nil userInfo:notificationDic];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

}

#pragma mark 
#pragma mark 网络请求
//网络请求各个类别
- (void)getClasstypeAction
{
    NSString *url_get = [NSString stringWithFormat:@"http://%@getClassType.action", kHead];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];//单例
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:url_get parameters:nil progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *jsondataArr = [responseObject objectForKey:@"jsondata"];
        
        for (NSDictionary *dic in jsondataArr) {
            CarOwnerClassifyModel *model = [[CarOwnerClassifyModel alloc] initWithDic:dic];
            [_titleModels addObject:model];
        }
        
        //设置下面的同步滑动视图
        [self addSyncScrollView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败，原因是%@", error);
        
    }];

}

@end
