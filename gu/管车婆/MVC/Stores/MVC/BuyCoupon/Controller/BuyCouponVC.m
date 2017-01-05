//
//  BuyCouponVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/22.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "BuyCouponVC.h"
#import "CouponListVC.h"
#import "MaintainCouponVC.h"
#import "CouponModel.h"

#define kTitleHeight 45*kRate

@interface BuyCouponVC ()

@property (nonatomic, strong)NSMutableArray *couponModelsArr1;
@property (nonatomic, strong)NSMutableArray *couponModelsArr2;
@property (nonatomic, strong)NSMutableArray *couponModelsArr3;
@property (nonatomic, strong)NSMutableArray *couponModelsArr4;

@end

@implementation BuyCouponVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _couponModelsArr1 = [NSMutableArray array];
    _couponModelsArr2 = [NSMutableArray array];
    _couponModelsArr3 = [NSMutableArray array];
    _couponModelsArr4 = [NSMutableArray array];
    
    //设置导航栏
    [self addNavBar];
    
    //设置下方的内容视图(在网络请求汽车券列表成功后再添加)
    //[self addContentView];
    
    //网络请求汽车券列表
    [self getCouponLists];
}

#pragma mark ******  设置导航栏  ******
- (void)addNavBar
{
    self.view.backgroundColor = kRGBColor(233, 233, 233);
    
    [self setBackButtonWithImageName:@"back"];
    [self setNavigationItemTitle:@"购买店铺券"];
}

#pragma mark ******  设置下方的内容视图  ******
- (void)addContentView
{
    //店铺大头照
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 225*kRate)];
    headImgView.image = [UIImage imageNamed:@"stores_headImg"];
    [self.view addSubview:headImgView];
    
    //配置按钮标题数组
    self.titleFrame = CGRectMake(0, CGRectGetMaxY(headImgView.frame), kScreenWidth, kTitleHeight);
    self.titleArray = [NSArray arrayWithObjects:@"洗车", @"保养", @"美容", @"其他", nil];
    
    //配置控制器数组(需要与上面的标题相对应)
    CouponListVC *carCleanVC = [[CouponListVC alloc] init];
    carCleanVC.couponModels = _couponModelsArr1;
    carCleanVC.type = @"1";//洗车
    MaintainCouponVC *carMaintainVC = [[MaintainCouponVC alloc] init];//保养
    carMaintainVC.couponModels = _couponModelsArr2;
    CouponListVC *carBeautyVC = [[CouponListVC alloc] init];
    carBeautyVC.couponModels = _couponModelsArr3;
    carBeautyVC.type = @"3";//美容
    CouponListVC *otherVC = [[CouponListVC alloc] init];
    otherVC.couponModels = _couponModelsArr4;
    otherVC.type = @"4";//其他
    self.controllerArray = [NSArray arrayWithObjects:carCleanVC, carMaintainVC, carBeautyVC, otherVC, nil];
}

#pragma mark
#pragma mark 网络请求
- (void)getCouponLists
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getSItemsBySTypeAndMid.action", kHead];
    
    NSDictionary *params = @{
                             @"uid":[[self getLocalDic] objectForKey:@"uid"],
                             @"mid":_mid
                             };
    
    NSLog(@"%@, %@", [[self getLocalDic] objectForKey:@"uid"], _mid);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *arr1 = [content objectForKey:@"1"];
        NSArray *arr2 = [content objectForKey:@"2"];
        NSArray *arr3 = [content objectForKey:@"3"];
        NSArray *arr4 = [content objectForKey:@"4"];
        
        for (NSDictionary *dic in arr1) {
            CouponModel *couponModel = [[CouponModel alloc] initWithDic:dic];
            [_couponModelsArr1 addObject:couponModel];
        }
        for (NSDictionary *dic in arr2) {
            CouponModel *couponModel = [[CouponModel alloc] initWithDic:dic];
            [_couponModelsArr2 addObject:couponModel];
        }
        for (NSDictionary *dic in arr3) {
            CouponModel *couponModel = [[CouponModel alloc] initWithDic:dic];
            [_couponModelsArr3 addObject:couponModel];
        }
        for (NSDictionary *dic in arr4) {
            CouponModel *couponModel = [[CouponModel alloc] initWithDic:dic];
            [_couponModelsArr4 addObject:couponModel];
        }
        
        //设置下方的内容视图
        [self addContentView];
        
    } failure:nil];
}
@end
