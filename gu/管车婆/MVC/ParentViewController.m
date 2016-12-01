//
//  ParentViewController.m
//  管车婆
//
//  Created by 李伟 on 16/9/27.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ParentViewController.h"

#define kTitleWidth kScreenWidth/_titleArray.count
#define kTitleHeight 45*kRate
#define kTitleBgColor [UIColor colorWithWhite:0.300 alpha:1.000]

@interface ParentViewController ()<UIScrollViewDelegate>
{
    UIView *titleView;
    
    UIButton *selectButton;//选中按钮
    UIView *_sliderView;//选中按钮下面的小滑块
    UIScrollView *_scrollContentView;
    
    UILabel* titleLabel;//导航栏标题
}
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation ParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buttonArray = [NSMutableArray array];
    
    [self.navigationItem setHidesBackButton:YES];//将默认的返回按钮隐藏
    [self setNavBgColorWithRed:22 Green:129 Blue:252];//设置导航栏背景颜色
    
}

- (void)addObserver
{
    //添加观察者，监听HomeViewController中发送过来的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(theViewToShow:) name:@"页面index" object:nil];
}

- (void)theViewToShow:(NSNotification *)notification
{
    int index = [[[notification userInfo] objectForKey:@"index"] intValue];
    _selectedNum = index;
    
    if (titleView) {
        [titleView removeFromSuperview];
    }
    [self initWithTitleButton];
    
    if (_scrollContentView) {
        [_scrollContentView removeFromSuperview];
    }
    [self initWithController];
}

#pragma mark
#pragma mark *****************  设置导航栏  *****************
//导航栏标题(文字)
- (void)setNavigationItemTitle:(NSString *)title
{
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,180,44)];
    titleLabel.text = title;
    
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font            = [UIFont boldSystemFontOfSize:18*kRate];  //设置文本字体与大小
    titleLabel.textColor       = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}


//设置导航栏背景颜色
- (void)setNavBgColorWithRed:(int)red Green:(int)green Blue:(int)blue
{
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1]];
}

//设置返回按钮
- (void)setBackButtonWithImageName:(NSString *)imageName
{
    //    [self.navigationItem setHidesBackButton:YES];//将默认的返回按钮隐藏
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(25*kRate, 30*kRate, 45*kRate, 16.2*kRate);
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [btn addTarget: self action: @selector(goBackAction) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = back;
}

      ///返回按钮Action
- (void)goBackAction
{
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma  mark *****************  设置同步滑动页  ********************

#pragma mark ----设置标题按钮

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    if (!titleView) {
        [self initWithTitleButton];
    }
}

- (void)initWithTitleButton
{
    //标题视图
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTitleHeight)];
    titleView.backgroundColor = [UIColor whiteColor];//背景色
    [self.view addSubview:titleView];
    
    if (_titleFrame.size.height == 0) {
        
        if (self.navigationController.navigationBar) {
            titleView.frame = CGRectMake(0, 64, kScreenWidth, kTitleHeight);
        } else {
            titleView.frame = CGRectMake(0, 0, kScreenWidth, kTitleHeight);
        }
        
    } else {
        
        titleView.frame = _titleFrame;
        
    }
    
    
    
    //标题按钮
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(kTitleWidth*i, 0, kTitleWidth, kTitleHeight);
        [titleBtn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:kTitleBgColor forState:UIControlStateNormal];
        titleBtn.tag = 100 + i;
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
        [titleBtn addTarget:self action:@selector(scrollViewSelectToIndex:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleBtn];
        
        if (i == _selectedNum) {
            selectButton = titleBtn;
            [selectButton setTitleColor:[UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1] forState:UIControlStateNormal];//按钮选中状态下的颜色
        }
        
        [_buttonArray addObject:titleBtn];
    }
    
    //底部蓝色小滑块
    UIView *sliderV = [[UIView alloc] initWithFrame:CGRectMake(kTitleWidth*_selectedNum, kTitleHeight - 0.5, kTitleWidth, 0.5)];
    sliderV.backgroundColor = [UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1];
    [titleView addSubview:sliderV];
    _sliderView = sliderV;
}

- (void)scrollViewSelectToIndex:(UIButton *)btn
{
    NSLog(@"_selectedNum:%d; btn.tag-100:%ld", _selectedNum, btn.tag-100);
    
    //点击相应按钮后，小滑块随之滑动，按钮颜色改变
    [self selectButton:(btn.tag - 100)];
    
    //点击相应按钮后，显示对应的视图
    [UIView animateWithDuration:0 animations:^{
        _scrollContentView.contentOffset = CGPointMake(kScreenWidth * (btn.tag-100), 0);
    }];
    
    //选择细分服务视图
    [self selectDetailServeWithBtn:btn];
}

//选择某个标题按钮（小滑块随之滑动，按钮颜色改变）
- (void)selectButton:(NSInteger)index
{
    self.selectedNum = (int)index;
    
    [selectButton setTitleColor:kTitleBgColor forState:UIControlStateNormal];
    selectButton = _buttonArray[index];
    [selectButton setTitleColor:[UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1] forState:UIControlStateNormal];//按钮选中状态下变为蓝色
    [UIView animateWithDuration:0.3 animations:^{
        _sliderView.frame = CGRectMake(kTitleWidth * index, kTitleHeight - 0.5, kTitleWidth, 0.5);
    }];
}

//监听滚动事件,以实现通过左右滑动视图也可以使上面的标题按钮与之同步。
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //当滑动选择细分服务的View的时候也会调用scrollViewDidScroll方法，为确保滑动选择细分服务的View的时候不调用selectButton方法，需进行如下判断。
    //    if (scrollView.contentOffset.x != 0) {//这个判断用下面的indexF>0代替了
    //        NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    //        [self selectButton:index];
    //    }
    
    float indexF = scrollView.contentOffset.x / kScreenWidth;
    
    if (indexF > 0) {
        NSInteger index = scrollView.contentOffset.x / kScreenWidth;
        [self selectButton:index];
    }
    
    
}

//选择细分服务视图
- (void)selectDetailServeWithBtn:(UIButton *)btn
{
    NSLog(@"选择细分服务视图");
}

#pragma mark ----设置标题按钮对应的视图控制器

- (void)setControllerArray:(NSArray *)controllerArray
{
    _controllerArray = controllerArray;
    [self initWithController];
}

- (void)initWithController
{
    //配置scrollView的位置、尺寸以及内容大小
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(titleView.frame))];
    
    scrollView.contentOffset = CGPointMake(kScreenWidth*_selectedNum, 0);
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(kScreenWidth * _controllerArray.count, 0);//scrollView的起始位置
    [self.view insertSubview:scrollView atIndex:0];//如果直接使用addSubView添加视图的话，会导致选择详细信息的视图被scrollView给覆盖而显示不出来
    _scrollContentView = scrollView;
    
    //将各个控制器中的View视图填充到scrollView对应的内容位置上
    for (int i = 0; i < _controllerArray.count; i++) {
        UIView *view_c = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        UIViewController *vc = _controllerArray[i];
        view_c = vc.view;
        view_c.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight);
        
        [scrollView addSubview:view_c];
    }
}

#pragma mark 
#pragma mark 复写deallock,移除观察者
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"页面index" object:nil];
}


@end
