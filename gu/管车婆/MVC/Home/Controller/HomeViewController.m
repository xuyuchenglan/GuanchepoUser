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

#define kFirstBtnWidth  kScreenWidth/4
#define kFirstBtnHeight 80*kRate
#define kSecondBtnWidth kScreenWidth/4
#define kForthBtnWidth  kScreenWidth/3

@interface HomeViewController ()<UIScrollViewDelegate, ScrollImageViewDelegate>
{
    UIScrollView *_scrollView;//滑动视图（所有的控件都加在这上面）
    
}
@property (nonatomic, strong)UIView          *topView;
@property (nonatomic, strong)ScrollImageView *scrollImageView;//广告轮播图
@property (nonatomic, strong)UIView          *firstBtnsView;
@property (nonatomic, strong)UIView          *secondView;
@property (nonatomic, strong)UIView          *thirdView;
@property (nonatomic, strong)UIView          *forthView;
@property (nonatomic, strong)UIImageView     *fifthImgView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航引导页
    [self guideView];
    
    //导航栏
    [self addNavBar];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];//滑动视图的可视范围
    _scrollView.backgroundColor = [UIColor colorWithRed:234/255.0 green:238/255.0 blue:239/255.0 alpha:1];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 880*kRate);
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
    //左侧定位按钮
    [self setNavItemLocationBtn];
    
    //中间的title
    [self setNavigationItemTitleWithImage:@"home_navbar_title"];
    
    //搜索按钮 & 最右侧按钮
    [self setNavItemsearchAndRightBtn];
    
}

//定位按钮
- (void)setNavItemLocationBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15*kRate, 15*kRate, 25*kRate, 25*kRate);
    
    [btn setImage:[UIImage imageNamed:@"home_navbar_location"] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(locationBtnAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *location = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = location;
}

- (void)locationBtnAction
{
    NSLog(@"定位");
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
    carText.text = @"宝马 BMW 4系双门轿跑车121420 18";
    [_topView addSubview:carText];
    
    //是否适宜洗车
    UIImageView *weatherImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 100*kRate, 6*kRate, 22*kRate, 22*kRate)];
    weatherImg.image = [UIImage imageNamed:@"home_top_weather"];
    [_topView addSubview:weatherImg];
    
    UILabel *isSuitable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weatherImg.frame), 6*kRate, 70*kRate, 22*kRate)];
    isSuitable.font = [UIFont systemFontOfSize:12.0*kRate];
    isSuitable.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    isSuitable.text = @"不宜洗车";
    [_topView addSubview:isSuitable];
}


#pragma mark ******************      第一块内容      ****************
- (void)addFirstContent
{
    //按钮上方的轮播图
    [_scrollView addSubview:self.scrollImageView];
    
    //洗车、保养、预约、活动按钮
    [self addFirstBtns];
}

/// 懒加载
- (ScrollImageView *)scrollImageView
{
    if (!_scrollImageView) {
        
        NSArray * dataUrls = @[@"http://",@"http://",@"http://",@"http://"];
        NSArray * dataPics = @[@"ad_01",@"ad_02",@"ad_03",@"ad_04",@"ad_01"];
        _scrollImageView = [[ScrollImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame), kScreenWidth, 100*kRate) andPictureUrls:dataUrls andPlaceHolderImages:dataPics];
        _scrollImageView.delegate = self;
        
    }
    
    return _scrollImageView;
}


///洗车、保养、预约、活动按钮
- (void)addFirstBtns
{
    _firstBtnsView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollImageView.frame), kScreenWidth, kFirstBtnHeight)];
    _firstBtnsView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:_firstBtnsView];
    
    //洗车
    [self addWashBtn];
    
    //保养
    [self addMaintenanceBtn];
    
    //预约
    [self addAppointmentBtn];
    
    //活动
    [self addActivityBtn];
}

//洗车
- (void)addWashBtn
{
    UIButton *washBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kFirstBtnWidth, kFirstBtnHeight)];
    [washBtn addTarget:self action:@selector(washBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [washBtn setImage:[UIImage imageNamed:@"home_first_wash"] forState:UIControlStateNormal];
    washBtn.imageEdgeInsets = UIEdgeInsetsMake(8*kRate, 25*kRate, 22*kRate, 25*kRate);
    
    [washBtn setTitle:@"洗车" forState:UIControlStateNormal];
    washBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    washBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [washBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    washBtn.titleEdgeInsets = UIEdgeInsetsMake(kFirstBtnWidth - 45*kRate, -washBtn.titleLabel.bounds.size.width - 98, 5*kRate, 0);
    
    
    [_firstBtnsView addSubview:washBtn];
}

- (void)washBtnAction
{
    NSLog(@"洗车");
}

//保养
- (void)addMaintenanceBtn
{
    UIButton *maintenanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(kFirstBtnWidth, 0, kFirstBtnWidth, kFirstBtnHeight)];
    [maintenanceBtn addTarget:self action:@selector(mainTenanceBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [maintenanceBtn setImage:[UIImage imageNamed:@"home_first_maintenance"] forState:UIControlStateNormal];
    maintenanceBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 28*kRate, 22*kRate, 28*kRate);
    
    [maintenanceBtn setTitle:@"保养" forState:UIControlStateNormal];
    maintenanceBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    maintenanceBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [maintenanceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    maintenanceBtn.titleEdgeInsets = UIEdgeInsetsMake(kFirstBtnWidth - 45*kRate, -maintenanceBtn.titleLabel.bounds.size.width - 85, 5*kRate, 0);
    
    
    
    [_firstBtnsView addSubview:maintenanceBtn];
}

- (void)mainTenanceBtnAction
{
    NSLog(@"保养");
}


//预约
- (void)addAppointmentBtn
{
    UIButton *appointmentBtn = [[UIButton alloc] initWithFrame:CGRectMake(kFirstBtnWidth*2, 0, kFirstBtnWidth, kFirstBtnHeight)];
    [appointmentBtn addTarget:self action:@selector(appointmentBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [appointmentBtn setImage:[UIImage imageNamed:@"home_first_appointment"] forState:UIControlStateNormal];
    appointmentBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 28*kRate, 22*kRate, 28*kRate);
    
    [appointmentBtn setTitle:@"预约" forState:UIControlStateNormal];
    appointmentBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    appointmentBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [appointmentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    appointmentBtn.titleEdgeInsets = UIEdgeInsetsMake(kFirstBtnWidth - 45*kRate, -appointmentBtn.titleLabel.bounds.size.width - 85, 5*kRate, 0);
    
    [_firstBtnsView addSubview:appointmentBtn];
}

- (void)appointmentBtnAction
{
    NSLog(@"预约");
}

//活动
- (void)addActivityBtn
{
    UIButton *activityBtn = [[UIButton alloc] initWithFrame:CGRectMake(kFirstBtnWidth*3, 0, kFirstBtnWidth, kFirstBtnHeight)];
    [activityBtn addTarget:self action:@selector(activitybtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [activityBtn setImage:[UIImage imageNamed:@"home_first_activity"] forState:UIControlStateNormal];
    activityBtn.imageEdgeInsets = UIEdgeInsetsMake(10*kRate, 28*kRate, 22*kRate, 28*kRate);
    
    [activityBtn setTitle:@"活动" forState:UIControlStateNormal];
    activityBtn.titleLabel.font = [UIFont systemFontOfSize:13.0*kRate];
    activityBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [activityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    activityBtn.titleEdgeInsets = UIEdgeInsetsMake(kFirstBtnWidth - 45*kRate, -activityBtn.titleLabel.bounds.size.width - 85, 5*kRate, 0);
    
    [_firstBtnsView addSubview:activityBtn];
}

- (void)activitybtnAction
{
    NSLog(@"活动");
}

#pragma mark ---- scrollImageViewDelegate
-(void)scrollImageView:(ScrollImageView *)srollImageView didTapImageView:(UIImageView *)image atIndex:(NSInteger)index
{
    NSLog(@"轮播图");
}

#pragma mark ******************      第二块内容      ****************
- (void)addSecondContend
{
    _secondView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_firstBtnsView.frame) + 10*kRate, kScreenWidth, kScreenWidth/4*3)];
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
    
    
    
    //全车镀晶
    [self addDujingBtn];
    
    //清洗节气门
    [self addJieqimenBtn];
    
    //清洗发动机
    [self addFadongjiBtn];
    
    //轮胎检查
    [self addluntaiBtn];
    
    //底盘检查
    [self addDipanBtn];
    
    //广告位
    [self addAdView];
    
    //空调清洗
    [self addKongtiaoBtn];
    
    //清洗进气管道
    [self addJinqiguanBtn];
    
    //真皮护理
    [self addZhenpiBtn];
    
    //玻璃镀膜
    [self addBoliBtn];
    
    //更多
    [self addMoreBtn];
    
    
}

//全车镀晶
- (void)addDujingBtn
{
    UIButton *dujingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSecondBtnWidth, kSecondBtnWidth)];
    [dujingBtn addTarget:self action:@selector(dujingBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [dujingBtn setImage:[UIImage imageNamed:@"home_second_dujing"] forState:UIControlStateNormal];
    dujingBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 35*kRate, 35*kRate, 30*kRate);
    
    [dujingBtn setTitle:@"全车镀晶" forState:UIControlStateNormal];
    dujingBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    dujingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [dujingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    dujingBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -dujingBtn.titleLabel.bounds.size.width - 45, 5*kRate, 0);
    
    [_secondView addSubview:dujingBtn];
}

- (void)dujingBtnAction
{
    NSLog(@"全车镀晶");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:2]];
}


//清洗节气门
- (void)addJieqimenBtn
{
    UIButton *jieqimenBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth, 0, kSecondBtnWidth, kSecondBtnWidth)];
    [jieqimenBtn addTarget:self action:@selector(jieqimenBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [jieqimenBtn setImage:[UIImage imageNamed:@"home_second_jieqimen"] forState:UIControlStateNormal];
    jieqimenBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 35*kRate, 35*kRate, 30*kRate);
    
    [jieqimenBtn setTitle:@"清洗节气门" forState:UIControlStateNormal];
    jieqimenBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    jieqimenBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [jieqimenBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jieqimenBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -jieqimenBtn.titleLabel.bounds.size.width - 50, 5*kRate, 0);
    
    [_secondView addSubview:jieqimenBtn];
}

- (void)jieqimenBtnAction
{
    NSLog(@"清洗节气门");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:1]];
}


//清洗发动机
- (void)addFadongjiBtn
{
    UIButton *fadongjiBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*2, 0, kSecondBtnWidth, kSecondBtnWidth)];
    [fadongjiBtn addTarget:self action:@selector(fadongjiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [fadongjiBtn setImage:[UIImage imageNamed:@"home_second_fadongji"] forState:UIControlStateNormal];
    fadongjiBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [fadongjiBtn setTitle:@"清洗发动机" forState:UIControlStateNormal];
    fadongjiBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    fadongjiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [fadongjiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fadongjiBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -fadongjiBtn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:fadongjiBtn];
}

- (void)fadongjiBtnAction
{
    NSLog(@"清洗发动机");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:0]];
}

//轮胎检查
- (void)addluntaiBtn
{
    UIButton *luntaiBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*3, 0, kSecondBtnWidth, kSecondBtnWidth)];
    [luntaiBtn addTarget:self action:@selector(luntaiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [luntaiBtn setImage:[UIImage imageNamed:@"home_second_luntai"] forState:UIControlStateNormal];
    luntaiBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [luntaiBtn setTitle:@"轮胎检查" forState:UIControlStateNormal];
    luntaiBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    luntaiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [luntaiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    luntaiBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -luntaiBtn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:luntaiBtn];
}

- (void)luntaiBtnAction
{
    NSLog(@"轮胎检查");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:3]];
}

//底盘检查
- (void)addDipanBtn
{
    UIButton *dipanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSecondBtnWidth, kSecondBtnWidth, kSecondBtnWidth)];
    [dipanBtn addTarget:self action:@selector(dipanBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [dipanBtn setImage:[UIImage imageNamed:@"home_second_dipan"] forState:UIControlStateNormal];
    dipanBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [dipanBtn setTitle:@"底盘检查" forState:UIControlStateNormal];
    dipanBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    dipanBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [dipanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    dipanBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -dipanBtn.titleLabel.bounds.size.width - 75, 5*kRate, 0);
    
    [_secondView addSubview:dipanBtn];
}

- (void)dipanBtnAction
{
    NSLog(@"底盘检查");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:2]];
}

//广告位
- (void)addAdView
{
    UIImageView *secondImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kSecondBtnWidth + 10*kRate, kSecondBtnWidth + 15*kRate, 2*kSecondBtnWidth - 20*kRate, kSecondBtnWidth - 30*kRate)];
    secondImgView.image = [UIImage imageNamed:@"home_second_ad"];
    secondImgView.userInteractionEnabled = YES;
    [_secondView addSubview:secondImgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondAd:)];
    [secondImgView addGestureRecognizer:tap];
    
}

- (void)secondAd:(UITapGestureRecognizer *)gesture
{
    NSLog(@"中间的广告位");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:1]];
}

//空调清洗
- (void)addKongtiaoBtn
{
    UIButton *kongtiaoBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*3, kSecondBtnWidth, kSecondBtnWidth, kSecondBtnWidth)];
    [kongtiaoBtn addTarget:self action:@selector(kongtiaoBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [kongtiaoBtn setImage:[UIImage imageNamed:@"home_second_kongtiao"] forState:UIControlStateNormal];
    kongtiaoBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [kongtiaoBtn setTitle:@"空调清洗" forState:UIControlStateNormal];
    kongtiaoBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    kongtiaoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [kongtiaoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    kongtiaoBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -kongtiaoBtn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:kongtiaoBtn];
}

- (void)kongtiaoBtnAction
{
    NSLog(@"空调清洗");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:0]];
}

//清洗进气管道
- (void)addJinqiguanBtn
{
    UIButton *jinqiguanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, kSecondBtnWidth*2, kSecondBtnWidth, kSecondBtnWidth)];
    [jinqiguanBtn addTarget:self action:@selector(jinqiguanBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [jinqiguanBtn setImage:[UIImage imageNamed:@"home_second_jinqiguandao"] forState:UIControlStateNormal];
    jinqiguanBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 35*kRate, 35*kRate, 30*kRate);
    
    [jinqiguanBtn setTitle:@"清洗进气管道" forState:UIControlStateNormal];
    jinqiguanBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    jinqiguanBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [jinqiguanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    jinqiguanBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -jinqiguanBtn.titleLabel.bounds.size.width - 50, 5*kRate, 0);
    
    [_secondView addSubview:jinqiguanBtn];
}

- (void)jinqiguanBtnAction
{
    NSLog(@"清洗进气管道");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:3]];
}

//真皮护理
- (void)addZhenpiBtn
{
    UIButton *zhenpiBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth, kSecondBtnWidth*2, kSecondBtnWidth, kSecondBtnWidth)];
    [zhenpiBtn addTarget:self action:@selector(zhenpiBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [zhenpiBtn setImage:[UIImage imageNamed:@"home_second_zhenpi"] forState:UIControlStateNormal];
    zhenpiBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [zhenpiBtn setTitle:@"真皮护理" forState:UIControlStateNormal];
    zhenpiBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    zhenpiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [zhenpiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zhenpiBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -zhenpiBtn.titleLabel.bounds.size.width - 60, 5*kRate, 0);
    
    [_secondView addSubview:zhenpiBtn];
}

- (void)zhenpiBtnAction
{
    NSLog(@"真皮护理");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:2]];
}

//玻璃镀膜
- (void)addBoliBtn
{
    UIButton *boliBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*2, kSecondBtnWidth*2, kSecondBtnWidth, kSecondBtnWidth)];
    [boliBtn addTarget:self action:@selector(boliBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [boliBtn setImage:[UIImage imageNamed:@"home_second_boli"] forState:UIControlStateNormal];
    boliBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [boliBtn setTitle:@"玻璃镀膜" forState:UIControlStateNormal];
    boliBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    boliBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [boliBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    boliBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -boliBtn.titleLabel.bounds.size.width - 70, 5*kRate, 0);
    
    [_secondView addSubview:boliBtn];
}

- (void)boliBtnAction
{
    NSLog(@"玻璃镀膜");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:1]];
}

//更多
- (void)addMoreBtn
{
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSecondBtnWidth*3, kSecondBtnWidth*2, kSecondBtnWidth, kSecondBtnWidth)];
    [moreBtn addTarget:self action:@selector(moreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [moreBtn setImage:[UIImage imageNamed:@"home_second_more"] forState:UIControlStateNormal];
    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(20*kRate, 30*kRate, 35*kRate, 25*kRate);
    
    [moreBtn setTitle:@"更 多>" forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:12.0*kRate];
    moreBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    moreBtn.titleEdgeInsets = UIEdgeInsetsMake(kSecondBtnWidth - 35*kRate, -moreBtn.titleLabel.bounds.size.width - 55, 5*kRate, 0);
    
    [_secondView addSubview:moreBtn];
}

- (void)moreBtnAction
{
    NSLog(@"更多");
    
    [self postNotificationWithIndex:[NSNumber numberWithInt:0]];
}

#pragma mark --- 给ParentVC发送一个通知，将具体显示哪一个页面的参数传过去
- (void)postNotificationWithIndex:(NSNumber *)index
{
    [self.tabBarController setSelectedIndex:1];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:index, @"index", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"页面index" object:nil userInfo:dic];
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
    _fifthImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_forthView.frame) + 10*kRate, kScreenWidth, 100*kRate)];
    _fifthImgView.userInteractionEnabled = YES;
    _fifthImgView.image = [UIImage imageNamed:@"ad_01"];
    [_scrollView addSubview:_fifthImgView];
    
    UITapGestureRecognizer *fifthTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fifthTapAction)];
    [_fifthImgView addGestureRecognizer:fifthTap];
}

- (void)fifthTapAction
{
    NSLog(@"最下方的广告位");
}



@end
