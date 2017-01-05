//
//  MyMembershipCardViewController.m
//  管车婆
//
//  Created by 李伟 on 16/12/10.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "MyMembershipCardViewController.h"
#import "MembershipServicesView.h"
#import "MembershipServicesModel.h"

#define kCardWidth (kScreenWidth-40)

@interface MyMembershipCardViewController ()
{
    MembershipServicesView *_membershipServicesView;//服务项目详情
    UIView *_line1;
}
@property (nonatomic, strong)NSMutableArray *membershipModels;
@end

@implementation MyMembershipCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏
    [self setBackButtonWithImageName:@"back"];
    [self setNavigationItemTitle:@"我的会员卡"];
    
    //下面的内容视图
    [self addContentView];
    
    //网络请求会员卡详情数据
    [self getMyCardInfo];
    
    
}

#pragma mark
#pragma mark ****** 内容视图 ******
- (void)addContentView
{
    _membershipModels = [NSMutableArray array];
    
    NSDictionary *localDic = [self getLocalDic];
    NSString *name = [NSString stringWithFormat:@"姓名：%@", [localDic objectForKey:@"realname"]];
    NSString *carno = [NSString stringWithFormat:@"车牌号：%@", [localDic objectForKey:@"carno"]];
    
    //会员卡图片、姓名、车牌号
    UIImageView *cardImgView = [[UIImageView alloc] init];
    cardImgView.image = [UIImage imageNamed:@"home_third_membership_card"];
    [self.view addSubview:cardImgView];
    [cardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kCardWidth, kCardWidth*0.58));
        make.top.equalTo(self.view).with.offset(64 + 10);
        make.left.equalTo(self.view).with.offset(20);
    }];
    
    UILabel *nameLB = [[UILabel alloc] init];
    nameLB.text = name;
    nameLB.font = [UIFont systemFontOfSize:16.0];
    nameLB.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.left.equalTo(self.view).with.offset(30);
        make.top.equalTo(cardImgView.mas_bottom).with.offset(10);
    }];
    
    UILabel *carNoLB = [[UILabel alloc] init];
    carNoLB.text = carno;
    carNoLB.textAlignment = NSTextAlignmentRight;
    carNoLB.font = [UIFont systemFontOfSize:16.0];
    carNoLB.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:carNoLB];
    [carNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 20));
        make.top.equalTo(cardImgView.mas_bottom).with.offset(10);
        make.right.equalTo(self.view).with.offset(-30);
    }];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self.view addSubview:_line1];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 1));
        make.top.equalTo(nameLB.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(0);
    }];
    
}

//服务项目详情
- (void)addMembershipServicesView
{
    _membershipServicesView = [[MembershipServicesView alloc] init];
    _membershipServicesView.membershipModels = _membershipModels;
    _membershipServicesView.showsVerticalScrollIndicator = NO;
    _membershipServicesView.showsHorizontalScrollIndicator = NO;
    _membershipServicesView.contentSize = CGSizeMake(kScreenWidth, 600);
    [self.view addSubview:_membershipServicesView];
    [_membershipServicesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, kScreenHeight-CGRectGetMaxY(_line1.frame)));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(_line1.mas_bottom).with.offset(0);
    }];
}


#pragma mark
#pragma mark 网络请求数据
//会员卡数据
- (void)getMyCardInfo
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getMyCardInfo.action", kHead];
    
    NSDictionary *params = @{
                             @"cardno":[[self getLocalDic] objectForKey:@"cardno"],
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *jsondataArr = [content objectForKey:@"jsondata"];
        
        for (NSDictionary *jsondataDic in jsondataArr) {
            MembershipServicesModel *membershipServiceModel = [[MembershipServicesModel alloc] initWithDic:jsondataDic];
            [_membershipModels addObject:membershipServiceModel];
        }
        
        //服务项目详情页面
        [self addMembershipServicesView];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];
    
}

@end
