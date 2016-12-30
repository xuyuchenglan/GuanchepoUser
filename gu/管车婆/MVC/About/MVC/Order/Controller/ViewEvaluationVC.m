//
//  ViewEvaluationVC.m
//  管车婆
//
//  Created by 李伟 on 16/12/30.
//  Copyright © 2016年 远恒网络科技有限公司. All rights reserved.
//

#import "ViewEvaluationVC.h"
#import "NormanStarRateView.h"

@interface ViewEvaluationVC ()
{
    UIImageView         *_headImgView;//门店快照
    UILabel             *_nameLB;//店名
    UIView              *_line1;//第一条分割线
    UILabel             *_timeLB;//订单时间
    UILabel             *_commentContentLB;//显示评论内容的label
    NormanStarRateView  *_starRateView;//星星评分视图
}

@property (nonatomic, strong)NSString *commentContent;
@property (nonatomic, assign)CGFloat   scorePercent;//百分比

@end

@implementation ViewEvaluationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kRGBColor(248, 249, 250);
    
    //导航栏
    [self setNavigationItemTitle:@"查看评价"];
    [self setBackButtonWithImageName:@"back"];
    
    //内容视图
        //头像，商户名称，订单完成时间，以及服务详情
    [self addHeadAndNameAndTimeAndServiceInfo];
    
        //评论详情
    [self addCommentInfo];
    
        //星级评价
    [self addStarView];
    
    //网络请求评价详情数据
    [self getCommentInfo];

}

//头像，商户名称，以及服务项目
- (void)addHeadAndNameAndTimeAndServiceInfo
{
    _headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20*kRate, (64+30)*kRate, 50*kRate, 50*kRate)];
    _headImgView.layer.cornerRadius = 25*kRate;
    _headImgView.layer.masksToBounds = YES;
    [_headImgView sd_setImageWithURL:self.orderModel.headImgUrl placeholderImage:[UIImage imageNamed:@"about_order_head"]];
    [self.view addSubview:_headImgView];
    
    _line1 = [[UIView alloc] init];
    _line1.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [self.view addSubview:_line1];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - CGRectGetMaxX(_headImgView.frame) + 5*kRate, 1*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(5*kRate);
        make.top.equalTo(self.view).with.offset((64+30)*kRate + 50*kRate/2);
    }];
    
    _nameLB = [[UILabel alloc] init];
    _nameLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _nameLB.adjustsFontSizeToFitWidth = YES;
    _nameLB.text = self.orderModel.nameStr;
    [self.view addSubview:_nameLB];
    [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200*kRate, 20*kRate));
        make.bottom.equalTo(_line1.mas_top).with.offset(-5*kRate);
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
    }];
    
    _timeLB = [[UILabel alloc] init];
    _timeLB.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    _timeLB.font = [UIFont systemFontOfSize:15.0*kRate];
    _timeLB.adjustsFontSizeToFitWidth = YES;
    _timeLB.textAlignment = NSTextAlignmentRight;
    _timeLB.text = [self getDate:YES getTime:NO WithTimeDateStr:self.orderModel.ordeTime];
    [self.view addSubview:_timeLB];
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.bottom.equalTo(_line1.mas_top).with.offset(-5*kRate);
        make.right.equalTo(self.view).with.offset(-30*kRate);
    }];

    
    ///使用卡种
    UILabel *titleLabel_type = [[UILabel alloc] init];
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString:@"使用卡种"];
    [attrStr addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr.length)];///文字间间距
    titleLabel_type.attributedText = attrStr;
    titleLabel_type.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_type.font = [UIFont systemFontOfSize:13.0*kRate];
    [self.view addSubview:titleLabel_type];
    [titleLabel_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 10*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
        make.top.equalTo(_line1.mas_bottom).with.offset(15*kRate);
    }];
    
    UILabel *dataLabel_type = [[UILabel alloc] init];
    dataLabel_type.textAlignment = NSTextAlignmentRight;
    dataLabel_type.font = [UIFont systemFontOfSize:13.0*kRate];
    dataLabel_type.text = _orderModel.cardName;
    [self.view addSubview:dataLabel_type];
    [dataLabel_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 15*kRate));
        make.right.equalTo(self.view).with.offset(-30*kRate);
        make.top.equalTo(titleLabel_type.mas_top).with.offset(0);
    }];

    ///服务项目
    UILabel *titleLabel_item = [[UILabel alloc] init];
    NSMutableAttributedString* attrStr2 = [[NSMutableAttributedString alloc] initWithString:@"服务项目"];
    [attrStr2 addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr2.length)];///文字间间距
    titleLabel_item.attributedText = attrStr2;
    titleLabel_item.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_item.font = [UIFont systemFontOfSize:13.0*kRate];
    [self.view addSubview:titleLabel_item];
    [titleLabel_item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 10*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
        make.top.equalTo(titleLabel_type.mas_bottom).with.offset(15*kRate);
    }];
    
    UILabel *dataLabel_item = [[UILabel alloc] init];
    dataLabel_item.textAlignment = NSTextAlignmentRight;
    dataLabel_item.font = [UIFont systemFontOfSize:13.0*kRate];
    dataLabel_item.text = _orderModel.serviceName;
    [self.view addSubview:dataLabel_item];
    [dataLabel_item mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 15*kRate));
        make.right.equalTo(self.view).with.offset(-30*kRate);
        make.top.equalTo(titleLabel_item.mas_top).with.offset(0);
    }];

    ///订单用户
    UILabel *titleLabel_user = [[UILabel alloc] init];
    NSMutableAttributedString* attrStr3 = [[NSMutableAttributedString alloc] initWithString:@"订单用户"];
    [attrStr3 addAttribute:NSKernAttributeName value:@(3.0*kRate) range:NSMakeRange(0, attrStr3.length)];///文字间间距
    titleLabel_user.attributedText = attrStr3;
    titleLabel_user.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    titleLabel_user.font = [UIFont systemFontOfSize:13.0*kRate];
    [self.view addSubview:titleLabel_user];
    [titleLabel_user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 10*kRate));
        make.left.equalTo(_headImgView.mas_right).with.offset(6*kRate);
        make.top.equalTo(titleLabel_item.mas_bottom).with.offset(15*kRate);
    }];
    
    UILabel *dataLabel_user = [[UILabel alloc] init];
    dataLabel_user.textAlignment = NSTextAlignmentRight;
    dataLabel_user.font = [UIFont systemFontOfSize:13.0*kRate];
    dataLabel_user.text = _orderModel.urealname;
    [self.view addSubview:dataLabel_user];
    [dataLabel_user mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 15*kRate));
        make.right.equalTo(self.view).with.offset(-30*kRate);
        make.top.equalTo(titleLabel_user.mas_top).with.offset(0);
    }];
    
}

//评论详情
- (void)addCommentInfo
{
    //标题
    UILabel *commentTitleLB = [[UILabel alloc] init];
    commentTitleLB.text = @"评论详情";
    commentTitleLB.font = [UIFont systemFontOfSize:14.0*kRate];
    [self.view addSubview:commentTitleLB];
    [commentTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(_line1.mas_bottom).with.offset(150*kRate);
    }];
    
    //内容
    UIView *commentContentBg = [[UIView alloc] init];
    commentContentBg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:commentContentBg];
    [commentContentBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 150*kRate));
        make.left.equalTo(self.view).with.offset(0);
        make.top.equalTo(commentTitleLB.mas_bottom).with.offset(5*kRate);
    }];
    
    _commentContentLB = [[UILabel alloc] init];
    _commentContentLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    _commentContentLB.font = [UIFont systemFontOfSize:13.0*kRate];
    _commentContentLB.numberOfLines = 0;
    [commentContentBg addSubview:_commentContentLB];
    [_commentContentLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-60*kRate, 150*kRate));
        make.left.equalTo(self.view).with.offset(30*kRate);
        make.top.equalTo(commentContentBg).with.offset(0);
    }];
    
    
}

//星级评价
- (void)addStarView
{
    //标题
    UILabel *starTitleLB = [[UILabel alloc] init];
    starTitleLB.text = @"星级评价";
    starTitleLB.font = [UIFont systemFontOfSize:15*kRate];
    starTitleLB.textColor = [UIColor colorWithWhite:0.3 alpha:1];
    starTitleLB.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:starTitleLB];
    [starTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100*kRate, 20*kRate));
        make.top.equalTo(_commentContentLB.mas_bottom).with.offset(50*kRate);
        make.left.equalTo(self.view).with.offset((kScreenWidth-100*kRate)/2);
    }];
    
    //星星视图
    _starRateView = [[NormanStarRateView alloc] initWithFrame:CGRectMake(100*kRate, CGRectGetMaxY(starTitleLB.frame) + 10*kRate, kScreenWidth-200*kRate, 30*kRate) numberOfStars:5];
    _starRateView.isEvaluating = YES;//使用比较饱满的那种星星
    _starRateView.allowIncompleteStar = YES;//是否允许评分为小数
    _starRateView.allowTouch = NO;//是否允许点击星星视图
    _starRateView.hasAnimation = NO;
    [self.view addSubview:_starRateView];
    [_starRateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-200*kRate, 30*kRate));
        make.left.equalTo(self.view).with.offset(100*kRate);
        make.top.equalTo(starTitleLB.mas_bottom).with.offset(10*kRate);
    }];
}

#pragma mark
#pragma mark 网络请求评价详情数据
- (void)getCommentInfo
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getPjByOid.action", kHead];
    
    NSDictionary *params = @{
                             @"oid"     :  _orderModel.orderID
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer = responseSerializer;
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *jsondataDic = [content objectForKey:@"jsondata"];
        NSLog(@"评价详情:%@", jsondataDic);
        
        _commentContent = [jsondataDic objectForKey:@"content"];
        _scorePercent = [[jsondataDic objectForKey:@"star"] floatValue]/5;
        
        //刷新UI
        _commentContentLB.text = _commentContent;
        _starRateView.scorePercent = _scorePercent;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
    }];

}

@end
