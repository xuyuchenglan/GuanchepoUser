//
//  HomeViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "HomeViewController.h"
#import "NormanGuideViewManager.h"
#import "ScrollImageView.h"
#import "FillPhoneChargesVC.h"
#import "EnquiryWeatherVC.h"
#import "EnquiryIllegalVC.h"
#import "RechargeFuelCardVC.h"
#import "EnquiryDriverScoresVC.h"
#import "BuyAutoInsuranceVC.h"
#import "OpenCardVC.h"
#import "HomeModel.h"
#import "ADViewController.h"
#import "ServiceModel.h"
#import "MoreViewController.h"
#import "ItemStoresVC.h"

#import <AMapLocationKit/AMapLocationKit.h>//定位SDK头文件

#define kFirstBtnWidth  kScreenWidth/4
#define kFirstBtnHeight 80*kRate
#define kSecondBtnWidth kScreenWidth/4
#define kForthBtnWidth  kScreenWidth/3

@interface HomeViewController ()<UIScrollViewDelegate, ScrollImageViewDelegate>
{
    UIScrollView *_scrollView;//滑动视图（所有的控件都加在这上面）
}
@property (nonatomic, strong)AMapLocationManager *locationManager;

@property (nonatomic, strong)UIView          *topView;
@property (nonatomic, strong)ScrollImageView *scrollImageView;//广告轮播图
@property (nonatomic, strong)UIView          *secondView;
@property (nonatomic, strong)UIView          *thirdView;
@property (nonatomic, strong)UIView          *forthView;
@property (nonatomic, strong)UIImageView     *fifthImgView;

@property (nonatomic, strong)HomeModel       *homeModel;

@property (nonatomic, assign)BOOL             isLoadSuccess;//当网络请求成功时设置其值

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航引导页
    [self guideView];
    
    //导航栏
    [self addNavBar];
    
    //导航栏下面的内容视图
    [self addContentView];
    
    //网络请求数据
    [self getHomeInfo];
    
    //获取当前定位信息，并存入本地数据库
    [self getCurrentLocation];
}

- (void)addContentView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];//滑动视图的可视范围
    if (self.navigationController.navigationBar) {
        _scrollView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49);
    } else {
        _scrollView.frame = [UIScreen mainScreen].bounds;
    }
    _scrollView.backgroundColor = kRGBColor(234, 238, 239);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 920*kRate);
    [self.view addSubview:_scrollView];
    
    //最上方的显示车辆信息以及是否适宜洗车的视图
    [self addTopView];
    
    //第一块内容
    [self addFirstContent];
    
    //第二块内容
    [self addSecondContend];
    
    //第三块内容
    [self addThirdContent];
    
    //第四块内容
    [self addForthContent];
    
    //第五块内容
    [self addFifthContent];
}

#pragma mark
#pragma mark ******************      导航引导页      ****************
- (void)guideView
{
    NSMutableArray *images = [NSMutableArray new];//引导页所要展示的图片，需要展示哪些图片，用下面的方法把相应的图片添加进数组即可
    
    [images addObject:[UIImage imageNamed:@"daohangye1"]];
    [images addObject:[UIImage imageNamed:@"daohangye2"]];
    [images addObject:[UIImage imageNamed:@"daohangye3"]];
    [images addObject:[UIImage imageNamed:@"daohangye1"]];
    
    //以下各参数依次为：所需要展示的图片、进入APP的按钮标题、按钮标题的颜色、按钮的背景颜色、按钮的边框颜色
    [[NormanGuideViewManager sharedInstance] showGuideViewWithImages:images
                                                      andButtonTitle:@"立即体验"
                                                 andButtonTitleColor:[UIColor whiteColor]
                                                    andButtonBGColor:[UIColor clearColor]
                                                andButtonBorderColor:[UIColor whiteColor]];
}

#pragma mark ******************      导航栏      ****************
- (void)addNavBar
{
//    //左侧定位按钮(在获取定位成功后展示)
//    [self setNavItemLocationBtn];
    
    //中间的title
    [self setNavigationItemTitleWithImage:@"home_navbar_title"];
    
    //搜索按钮 & 最右侧按钮
    [self setNavItemsearchAndRightBtn];
    
}

//定位按钮
- (void)setNavItemLocationBtn
{
    UIButton *locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(15*kRate, 15*kRate, 90*kRate, 25*kRate)];
    [locationBtn setImage:[UIImage imageNamed:@"home_navbar_location"] forState:UIControlStateNormal];
    locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0*kRate, 0*kRate, 0*kRate, 65*kRate);
    
    [locationBtn setTitle:[[self getLocalDic] objectForKey:@"showAddress"]forState:UIControlStateNormal];
    locationBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    locationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    locationBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    locationBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -locationBtn.titleLabel.bounds.size.width - 20*kRate, 0, 0);
    
    UIBarButtonItem *locationBtnItem = [[UIBarButtonItem alloc] initWithCustomView:locationBtn];
    
    self.navigationItem.leftBarButtonItem = locationBtnItem;

}

//导航栏标题（图片）
- (void)setNavigationItemTitleWithImage:(NSString *)imageName
{
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180*kRate, 36*kRate)];
    titleImageView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
    titleImageView.backgroundColor = [UIColor clearColor];
    titleImageView.image = [UIImage imageNamed:imageName];
    
    self.navigationItem.titleView = titleImageView;
}

//搜索按钮 & 最右侧按钮
- (void)setNavItemsearchAndRightBtn
{
    //搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    searchBtn.frame = CGRectMake(kScreenWidth - 120*kRate, 5*kRate, 25*kRate, 25*kRate);
    [searchBtn setImage:[UIImage imageNamed:@"home_navbar_search"] forState:UIControlStateNormal];

    [searchBtn addTarget: self action: @selector(searchbtnAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];

    
    //最右侧按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(kScreenWidth - 50*kRate, 5*kRate, 25*kRate, 25*kRate);
    [rightBtn setImage:[UIImage imageNamed:@"home_navbar_right"] forState:UIControlStateNormal];
    
    [rightBtn addTarget: self action: @selector(rightBtnAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    NSArray *rightBtns = [NSArray arrayWithObjects:right, search, nil];
    self.navigationItem.rightBarButtonItems = rightBtns;
    
}

- (void)searchbtnAction
{
    NSLog(@"搜索按钮");
}

- (void)rightBtnAction
{
    NSLog(@"最右侧按钮");
}

#pragma mark *****************   最上方的显示车辆信息以及是否适宜洗车的视图   ****************
- (void)addTopView
{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 34*kRate)];
    [_scrollView addSubview:_topView];
    
    //汽车信息
    UIImageView *carImg = [[UIImageView alloc] initWithFrame:CGRectMake(15*kRate, 6*kRate, 22*kRate, 22*kRate)];
    carImg.image = [UIImage imageNamed:@"home_top_car"];
    [_topView addSubview:carImg];
    
    UILabel *carText = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(carImg.frame), 6*kRate, 200*kRate, 22*kRate)];
    carText.font = [UIFont systemFontOfSize:11.0*kRate];
    carText.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    carText.shadowColor = [UIColor colorWithWhite:0.4 alpha:1];
    carText.shadowOffset = CGSizeMake(0.3*kRate, 0.3*kRate);
    carText.text = _homeModel.car;
    [_topView addSubview:carText];
    
    //是否适宜洗车
    UIImageView *weatherImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 100*kRate, 6*kRate, 22*kRate, 22*kRate)];
    weatherImg.image = [UIImage imageNamed:@"home_top_weather"];
    [_topView addSubview:weatherImg];
    
    UILabel *isSuitable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weatherImg.frame), 6*kRate, 70*kRate, 22*kRate)];
    isSuitable.font = [UIFont systemFontOfSize:12.0*kRate];
    isSuitable.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    isSuitable.text = _homeModel.isSuitableForClean;
    [_topView addSubview:isSuitable];
}


#pragma mark ******************      第一块内容      ****************
- (void)addFirstContent
{
    //按钮上方的轮播图
    if (_isLoadSuccess) {
        [_scrollView addSubview:self.scrollImageView];
    }
}

/// 懒加载
- (ScrollImageView *)scrollImageView
{
    if (!_scrollImageView) {
        
        NSMutableArray * dataUrlsMutable = [NSMutableArray array];
        for (BannerModel *banner1Model in _homeModel.banner1Models) {
            [dataUrlsMutable addObject:banner1Model.picUrl];
        }
        NSArray *dataUrls = [dataUrlsMutable copy];
        
        NSArray * dataPics = @[@"ad_01",@"ad_02",@"ad_03",@"ad_04",@"ad_01"];
        _scrollImageView = [[ScrollImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), kScreenWidth, kScreenWidth*0.42) andPictureUrls:dataUrls andPlaceHolderImages:dataPics];

        _scrollImageView.delegate = self;
        
    }
    
    return _scrollImageView;
}



#pragma mark ---- scrollImageViewDelegate
-(void)scrollImageView:(ScrollImageView *)srollImageView didTapImageView:(UIImageView *)image atIndex:(NSInteger)index
{
    NSLog(@"点击的是第%zd个图片，该图片是:%@",index+1,image);
    //在这个方法里面实现点击相应图片后的跳转。
    
    BannerModel *currentModel = [[BannerModel alloc] init];
    currentModel = _homeModel.banner1Models[index];
    
    ADViewController *adViewController = [[ADViewController alloc] init];
    adViewController.linkUrl = currentModel.linkUrl;
    adViewController.titleStr = currentModel.titleName;
    adViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:adViewController animated:NO];
    adViewController.hidesBottomBarWhenPushed = NO;
    
}

#pragma mark ******************      第二块内容      ****************
- (void)addSecondContend
{
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollImageView.frame) + 10*kRate, kScreenWidth, kScreenWidth/4*3)];
    _secondView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_secondView];
    
    
    /************************   分割线   *************************/
    
    //第一条横线
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, kSecondBtnWidth, kScreenWidth, 1)];
    view1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_secondView addSubview:view1];
    
    
    //第二条横线
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, kSecondBtnWidth*2, kScreenWidth, 1)];
    view2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_secondView addSubview:view2];

    
    //第一条纵线
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(kSecondBtnWidth, 0, 1, kSecondBtnWidth*3)];
    view3.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_secondView addSubview:view3];

    
    
    //第二条纵线（上）
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(kSecondBtnWidth*2, 0, 1, kSecondBtnWidth)];
    view4.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_secondView addSubview:view4];

    
    //第二条纵线（下）
    UIView *view5 = [[UIView alloc] initWithFrame:CGRectMake(kSecondBtnWidth*2, kSecondBtnWidth*2, 1, kSecondBtnWidth)];
    view5.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_secondView addSubview:view5];

    
    //第三条纵线
    UIView *view6 = [[UIView alloc] initWithFrame:CGRectMake(kSecondBtnWidth*3, 0, 1, kSecondBtnWidth*3)];
    view6.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_secondView addSubview:view6];
    
    /************************   分割线   *************************/
    
    
    
    //上1
    [self addUp1Btn];
    
    //上2
    [self addUp2Btn];
    
    //上3
    [self addUp3Btn];
    
    //上4
    [self addUp4Btn];
    
    //中1
    [self addMedium1Btn];
    
    //广告位
    [self addAdView];
    
    //中2
    [self addMedium2Btn];
    
    //下1
    [self addDown1Btn];
    
    //下2
    [self addDown2Btn];
    
    //下3
    [self addDown3Btn];
    
    //下4(更多)
    [self addDown4Btn];
    
    
}

//上1
- (void)addUp1Btn
{
    ServiceModel *serviceModel = _homeModel.services[0];
    
    UIButton *up1Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSecondBtnWidth, kSecondBtnWidth)];
    [up1Btn addTarget:self action:@selector(up1BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [up1Btn sd_setImageWithURL:serviceModel.serviceImg_home forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"] options:SDWebImageRefreshCached];
    up1Btn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [up1Btn setTitle:serviceModel.serviceName forState:UIControlStateNormal];
    up1Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    up1Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [up1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    up1Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -up1Btn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:up1Btn];
}

- (void)up1BtnAction
{
    ServiceModel *serviceModel = _homeModel.services[0];
    
    NSLog(@"%@", serviceModel.serviceId);
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = serviceModel.serviceId;
    itemStoresVC.sname = serviceModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
}


//上2
- (void)addUp2Btn
{
    ServiceModel *serviceModel = _homeModel.services[1];
    
    UIButton *up2Btn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth, 0, kSecondBtnWidth, kSecondBtnWidth)];
    [up2Btn addTarget:self action:@selector(up2BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [up2Btn sd_setImageWithURL:serviceModel.serviceImg_home forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"] options:SDWebImageRefreshCached];
    up2Btn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [up2Btn setTitle:serviceModel.serviceName forState:UIControlStateNormal];
    up2Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    up2Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [up2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    up2Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -up2Btn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:up2Btn];
}

- (void)up2BtnAction
{
    ServiceModel *serviceModel = _homeModel.services[1];
    
    NSLog(@"%@", serviceModel.serviceId);
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = serviceModel.serviceId;
    itemStoresVC.sname = serviceModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
}


//上3
- (void)addUp3Btn
{
    ServiceModel *serviceModel = _homeModel.services[2];
    
    UIButton *up3Btn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*2, 0, kSecondBtnWidth, kSecondBtnWidth)];
    [up3Btn addTarget:self action:@selector(up3BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [up3Btn sd_setImageWithURL:serviceModel.serviceImg_home forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"] options:SDWebImageRefreshCached];
    up3Btn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [up3Btn setTitle:serviceModel.serviceName forState:UIControlStateNormal];
    up3Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    up3Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [up3Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    up3Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -up3Btn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:up3Btn];
}

- (void)up3BtnAction
{
    ServiceModel *serviceModel = _homeModel.services[2];
    
    NSLog(@"%@", serviceModel.serviceId);
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = serviceModel.serviceId;
    itemStoresVC.sname = serviceModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
}

//上4
- (void)addUp4Btn
{
    ServiceModel *serviceModel = _homeModel.services[3];
    
    UIButton *up4Btn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*3, 0, kSecondBtnWidth, kSecondBtnWidth)];
    [up4Btn addTarget:self action:@selector(up4BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [up4Btn sd_setImageWithURL:serviceModel.serviceImg_home forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"] options:SDWebImageRefreshCached];
    up4Btn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [up4Btn setTitle:serviceModel.serviceName forState:UIControlStateNormal];
    up4Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    up4Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [up4Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    up4Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -up4Btn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:up4Btn];
}

- (void)up4BtnAction
{
    ServiceModel *serviceModel = _homeModel.services[3];
    
    NSLog(@"%@", serviceModel.serviceId);
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = serviceModel.serviceId;
    itemStoresVC.sname = serviceModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
}

//中1
- (void)addMedium1Btn
{
    ServiceModel *serviceModel = _homeModel.services[4];
    
    UIButton *medium1Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSecondBtnWidth, kSecondBtnWidth, kSecondBtnWidth)];
    [medium1Btn addTarget:self action:@selector(medium1BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [medium1Btn sd_setImageWithURL:serviceModel.serviceImg_home forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"] options:SDWebImageRefreshCached];
    medium1Btn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [medium1Btn setTitle:serviceModel.serviceName forState:UIControlStateNormal];
    medium1Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    medium1Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [medium1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    medium1Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -medium1Btn.titleLabel.bounds.size.width - 75, 5*kRate, 0);
    
    [_secondView addSubview:medium1Btn];
}

- (void)medium1BtnAction
{
    ServiceModel *serviceModel = _homeModel.services[4];
    
    NSLog(@"%@", serviceModel.serviceId);
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = serviceModel.serviceId;
    itemStoresVC.sname = serviceModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
}

//广告位
- (void)addAdView
{
    UIImageView *secondImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kSecondBtnWidth + 1, kSecondBtnWidth + 1, 2*kSecondBtnWidth - 1, kSecondBtnWidth - 1)];
    [secondImgView sd_setImageWithURL:[NSURL URLWithString:_homeModel.banner2Model.picUrl] placeholderImage:[UIImage imageNamed:@"home_second_ad"] options:SDWebImageRefreshCached];
    secondImgView.userInteractionEnabled = YES;
    [_secondView addSubview:secondImgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondAd:)];
    [secondImgView addGestureRecognizer:tap];
    
}

- (void)secondAd:(UITapGestureRecognizer *)gesture
{
    NSLog(@"中间的广告位");
    
    ADViewController *banner2VC = [[ADViewController alloc] init];
    banner2VC.titleStr = self.homeModel.banner2Model.titleName;
    banner2VC.linkUrl = self.homeModel.banner2Model.linkUrl;
    banner2VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:banner2VC animated:NO];
    banner2VC.hidesBottomBarWhenPushed = NO;
}

//中2
- (void)addMedium2Btn
{
    ServiceModel *serviceModel = _homeModel.services[5];
    
    UIButton *medium2Btn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*3, kSecondBtnWidth, kSecondBtnWidth, kSecondBtnWidth)];
    [medium2Btn addTarget:self action:@selector(medium2BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [medium2Btn sd_setImageWithURL:serviceModel.serviceImg_home forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"] options:SDWebImageRefreshCached];
    medium2Btn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [medium2Btn setTitle:serviceModel.serviceName forState:UIControlStateNormal];
    medium2Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    medium2Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [medium2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    medium2Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -medium2Btn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:medium2Btn];
}

- (void)medium2BtnAction
{
    ServiceModel *serviceModel = _homeModel.services[5];
    
    NSLog(@"%@", serviceModel.serviceId);
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = serviceModel.serviceId;
    itemStoresVC.sname = serviceModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
}

//下1
- (void)addDown1Btn
{
    ServiceModel *serviceModel = _homeModel.services[6];
    
    UIButton *down1Btn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSecondBtnWidth*2, kSecondBtnWidth, kSecondBtnWidth)];
    [down1Btn addTarget:self action:@selector(down1BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [down1Btn sd_setImageWithURL:serviceModel.serviceImg_home forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"] options:SDWebImageRefreshCached];
    down1Btn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [down1Btn setTitle:serviceModel.serviceName forState:UIControlStateNormal];
    down1Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    down1Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [down1Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    down1Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -down1Btn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:down1Btn];
}

- (void)down1BtnAction
{
    ServiceModel *serviceModel = _homeModel.services[6];
    
    NSLog(@"%@", serviceModel.serviceId);
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = serviceModel.serviceId;
    itemStoresVC.sname = serviceModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
}

//下2
- (void)addDown2Btn
{
    ServiceModel *serviceModel = _homeModel.services[7];
    
    UIButton *down2Btn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth, kSecondBtnWidth*2, kSecondBtnWidth, kSecondBtnWidth)];
    [down2Btn addTarget:self action:@selector(down2BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [down2Btn sd_setImageWithURL:serviceModel.serviceImg_home forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"] options:SDWebImageRefreshCached];
    down2Btn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [down2Btn setTitle:serviceModel.serviceName forState:UIControlStateNormal];
    down2Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    down2Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [down2Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    down2Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -down2Btn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:down2Btn];
}

- (void)down2BtnAction
{
    ServiceModel *serviceModel = _homeModel.services[7];
    
    NSLog(@"%@", serviceModel.serviceId);
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = serviceModel.serviceId;
    itemStoresVC.sname = serviceModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
}

//下3
- (void)addDown3Btn
{
    ServiceModel *serviceModel = _homeModel.services[8];
    
    UIButton *down3Btn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*2, kSecondBtnWidth*2, kSecondBtnWidth, kSecondBtnWidth)];
    [down3Btn addTarget:self action:@selector(down3BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [down3Btn sd_setImageWithURL:serviceModel.serviceImg_home forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"home_second_dujing"] options:SDWebImageRefreshCached];
    down3Btn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [down3Btn setTitle:serviceModel.serviceName forState:UIControlStateNormal];
    down3Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    down3Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [down3Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    down3Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -down3Btn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:down3Btn];
}

- (void)down3BtnAction
{
    ServiceModel *serviceModel = _homeModel.services[8];
    
    NSLog(@"%@", serviceModel.serviceId);
    
    ItemStoresVC *itemStoresVC = [[ItemStoresVC alloc] init];
    itemStoresVC.sid = serviceModel.serviceId;
    itemStoresVC.sname = serviceModel.serviceName;
    itemStoresVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:itemStoresVC animated:NO];
    
    
}

//下4(更多)
- (void)addDown4Btn
{
    UIButton *down4Btn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*3, kSecondBtnWidth*2, kSecondBtnWidth, kSecondBtnWidth)];
    [down4Btn addTarget:self action:@selector(down4BtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [down4Btn setImage:[UIImage imageNamed:@"home_second_more"] forState:UIControlStateNormal];
    down4Btn.imageEdgeInsets = UIEdgeInsetsMake(25*kRate, 35*kRate, 40*kRate, 30*kRate);
    
    [down4Btn setTitle:@"更 多>" forState:UIControlStateNormal];
    down4Btn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    down4Btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [down4Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    down4Btn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -down4Btn.titleLabel.bounds.size.width - 55, 5*kRate, 0);
    
    [_secondView addSubview:down4Btn];
}

- (void)down4BtnAction
{
    NSLog(@"更多");
    
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    moreVC.services = _homeModel.services;
    moreVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreVC animated:NO];
}


#pragma mark ******************      第三块内容      ****************
- (void)addThirdContent
{
    _thirdView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_secondView.frame), kScreenWidth, kScreenWidth/4 + 20*kRate)];
    [_scrollView addSubview:_thirdView];
    
    //优惠券
    [self addCoupon];
    
    //卡
    [self addCard];
}

//优惠券
- (void)addCoupon
{
    UIImageView *couponImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10*kRate, kScreenWidth/2 - 5*kRate, kScreenWidth/4)];
    couponImgView.userInteractionEnabled = YES;
    couponImgView.image = [UIImage imageNamed:@"home_third_coupon"];
    [_thirdView addSubview:couponImgView];
    
    UITapGestureRecognizer *couponTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(couponTapAction)];
    [couponImgView addGestureRecognizer:couponTap];
}

- (void)couponTapAction
{
    NSLog(@"优惠券");
    
    
}


//卡
- (void)addCard
{
    UIImageView *cardImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2 + 5*kRate, 10*kRate, kScreenWidth/2 - 5*kRate, kScreenWidth/4)];
    cardImgView.userInteractionEnabled = YES;
    cardImgView.image = [UIImage imageNamed:@"home_third_membership"];
    [_thirdView addSubview:cardImgView];
    
    UITapGestureRecognizer *cardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cardTapAction)];
    [cardImgView addGestureRecognizer:cardTap];
}

- (void)cardTapAction
{
    NSLog(@"在线快捷办卡");
    
    OpenCardVC *openCardVC = [[OpenCardVC alloc] init];
    openCardVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:openCardVC animated:NO];
    
}

#pragma mark ******************      第四块内容      ****************
- (void)addForthContent
{
    _forthView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_thirdView.frame), kScreenWidth, 80*kRate)];
    _forthView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_forthView];
    
    
    /************************   分割线   *************************/
    
    //横线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 40*kRate, kScreenWidth, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_forthView addSubview:line1];
    
    //第一条竖线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(kForthBtnWidth, 0, 1, 80*kRate)];
    line2.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_forthView addSubview:line2];
    
    //第二条竖线
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(kForthBtnWidth*2, 0, 1, 80*kRate)];
    line3.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [_forthView addSubview:line3];
    
    /************************   分割线   *************************/
    
    
    //查天气
    [self enquiriesOnWeather];
    
    //查违章
    [self enqueriesOnIllegal];
    
    //加油卡充值
    [self fuelCardRecharge];
    
    //充话费
    [self phoneRecharge];
    
    //驾照查分
    [self enqueriesOnDriverScores];
    
    //买车险
    [self buyAutoInsurance];
    
    
}

//查天气
- (void)enquiriesOnWeather
{
    UIButton *weatherBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kForthBtnWidth, 40*kRate)];
    [weatherBtn setTitle:@"查天气" forState:UIControlStateNormal];
    weatherBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [weatherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [weatherBtn setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateHighlighted];
    [weatherBtn addTarget:self action:@selector(weatherBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_forthView addSubview:weatherBtn];
}

- (void)weatherBtnAction
{
    NSLog(@"查天气");
    
    EnquiryWeatherVC *enquiryWeatherVC = [[EnquiryWeatherVC alloc] init];
    enquiryWeatherVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:enquiryWeatherVC animated:NO];
    enquiryWeatherVC.hidesBottomBarWhenPushed = NO;
}

//查违章
- (void)enqueriesOnIllegal
{
    UIButton *illegalBtn = [[UIButton alloc] initWithFrame:CGRectMake(kForthBtnWidth, 0, kForthBtnWidth, 40*kRate)];
    [illegalBtn setTitle:@"查违章" forState:UIControlStateNormal];
    illegalBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [illegalBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [illegalBtn setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateHighlighted];
    [illegalBtn addTarget:self action:@selector(illegalBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_forthView addSubview:illegalBtn];
}

- (void)illegalBtnAction
{
    NSLog(@"查违章");
    
    EnquiryIllegalVC *enquiryIllegalVC = [[EnquiryIllegalVC alloc] init];
    
    [self.navigationController pushViewController:enquiryIllegalVC animated:NO];
}


//加油卡充值
- (void)fuelCardRecharge
{
    UIButton *fuelBtn = [[UIButton alloc] initWithFrame:CGRectMake(kForthBtnWidth*2, 0, kForthBtnWidth, 40*kRate)];
    [fuelBtn setTitle:@"加油卡充值" forState:UIControlStateNormal];
    fuelBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [fuelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fuelBtn setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateHighlighted];
    [fuelBtn addTarget:self action:@selector(fuelBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_forthView addSubview:fuelBtn];
}

- (void)fuelBtnAction
{
    NSLog(@"加油卡充值");
    
    RechargeFuelCardVC *rechargeFuelCardVC = [[RechargeFuelCardVC alloc] init];
    rechargeFuelCardVC.isExistFuelCard = YES;
    rechargeFuelCardVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rechargeFuelCardVC animated:NO];
    rechargeFuelCardVC.hidesBottomBarWhenPushed = NO;
}

//充话费
- (void)phoneRecharge
{
    UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40*kRate, kForthBtnWidth, 40*kRate)];
    [phoneBtn setTitle:@"充话费" forState:UIControlStateNormal];
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [phoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [phoneBtn setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateHighlighted];
    [phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_forthView addSubview:phoneBtn];
}

- (void)phoneBtnAction
{
    NSLog(@"充话费");
    
    FillPhoneChargesVC *fillPhoneChargesVC = [[FillPhoneChargesVC alloc] init];
    [self.navigationController pushViewController:fillPhoneChargesVC animated:NO];
}

//驾照查分
- (void)enqueriesOnDriverScores
{
    UIButton *scoresBtn = [[UIButton alloc] initWithFrame:CGRectMake(kForthBtnWidth, 40*kRate, kForthBtnWidth, 40*kRate)];
    [scoresBtn setTitle:@"驾照查分" forState:UIControlStateNormal];
    scoresBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [scoresBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scoresBtn setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateHighlighted];
    [scoresBtn addTarget:self action:@selector(scoresBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_forthView addSubview:scoresBtn];
}

- (void)scoresBtnAction
{
    NSLog(@"驾照查分");
    
    EnquiryDriverScoresVC *enquiryDriverScores = [[EnquiryDriverScoresVC alloc] init];
    [self.navigationController pushViewController:enquiryDriverScores animated:NO];
}


//买车险
- (void)buyAutoInsurance
{
    UIButton *insuranceBtn = [[UIButton alloc] initWithFrame:CGRectMake(kForthBtnWidth*2, 40*kRate, kForthBtnWidth, 40*kRate)];
    [insuranceBtn setTitle:@"买车险" forState:UIControlStateNormal];
    insuranceBtn.titleLabel.font = [UIFont systemFontOfSize:14.0*kRate];
    [insuranceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [insuranceBtn setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateHighlighted];
    [insuranceBtn addTarget:self action:@selector(insuranceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [_forthView addSubview:insuranceBtn];
}

- (void)insuranceBtnAction
{
    NSLog(@"买车险");
    
    BuyAutoInsuranceVC *buyAutoInsuranceVC = [[BuyAutoInsuranceVC alloc] init];
    [self.navigationController pushViewController:buyAutoInsuranceVC animated:NO];
}

#pragma mark ******************      第五块内容      ****************
- (void)addFifthContent
{
    _fifthImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_forthView.frame) + 10*kRate, kScreenWidth, kScreenWidth*0.267)];
    _fifthImgView.userInteractionEnabled = YES;
    [_fifthImgView sd_setImageWithURL:[NSURL URLWithString:_homeModel.banner3Model.picUrl] placeholderImage:[UIImage imageNamed:@"ad_01"] options:SDWebImageRefreshCached];
    [_scrollView addSubview:_fifthImgView];
    
    UITapGestureRecognizer *fifthTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fifthTapAction)];
    [_fifthImgView addGestureRecognizer:fifthTap];
}

- (void)fifthTapAction
{
    NSLog(@"最下方的广告位");
    
    ADViewController *banner3VC = [[ADViewController alloc] init];
    banner3VC.titleStr = self.homeModel.banner3Model.titleName;
    banner3VC.linkUrl = self.homeModel.banner3Model.linkUrl;
    banner3VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:banner3VC animated:NO];
    banner3VC.hidesBottomBarWhenPushed = NO;
}


#pragma mark 
#pragma mark --- 网络请求
- (void)getHomeInfo
{
    NSString *url_post = [NSString stringWithFormat:@"http://%@getIndexInfo.action", kHead];
    
    NSDictionary *params = @{
                             @"phone":[NSString stringWithFormat:@"%@", [[self getLocalDic] objectForKey:@"phone"]],
                             };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = responseSerializer;
    
    [manager POST:url_post parameters:params progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        _homeModel = [[HomeModel alloc] initWithDic:content];
        _isLoadSuccess = YES;
        
        //刷新UI
        [_scrollView removeFromSuperview];
        [self addNavBar];
        [self addContentView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败， 失败原因是：%@", error);
        
        _isLoadSuccess = NO;
        
        //当网络请求失败的时候，也刷新一下UI，否则广告视图就会被隐藏
        [_scrollView removeFromSuperview];
        [self addNavBar];
        [self addContentView];
        
    }];

}


#pragma mark
#pragma mark 获取当前定位
- (void)getCurrentLocation
{
    _locationManager = [[AMapLocationManager alloc] init];
    
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    //   定位超时时间，最低2s，此处设置为11s
    _locationManager.locationTimeout =11;
    
    //   逆地理请求超时时间，最低2s，此处设置为12s
    _locationManager.reGeocodeTimeout = 12;
    
    // 带逆地理（返回坐标和地址信息）。将下面代码中的YES改成NO，则不会返回地址信息。
    [_locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        
        NSString *latitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        
        //往本地plist文件中增加数据
        [self addValueToLocalPlistWithValue:latitude AndKey:@"latitude"];
        [self addValueToLocalPlistWithValue:longitude AndKey:@"longitude"];
        
        if (regeocode)
        {
            NSString *district = regeocode.district;
            NSString *township = regeocode.township;
            
            NSString *showAddress = [[NSString alloc] init];
            
            if (township.length > 0) {
                showAddress = township;
            } else {
                showAddress = district;
            }
            
            //往本地plist文件中增加数据
            [self addValueToLocalPlistWithValue:showAddress AndKey:@"showAddress"];
            
            //左侧定位按钮
            [self setNavItemLocationBtn];
        }
        
    }];
}

//往本地plist文件中增加数据
- (void)addValueToLocalPlistWithValue:(NSString *)value AndKey:(NSString *)key
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"my.plist"];
    NSDictionary *dic6 = [NSDictionary dictionaryWithContentsOfFile:filename];
    
    [dic6 setValue:value forKey:key];
    
    [dic6 writeToFile:filename atomically:YES];
}

@end
