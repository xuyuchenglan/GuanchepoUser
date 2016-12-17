//
//  MovableParentVC.m
//  管车婆
//
//  Created by 李伟 on 16/10/11.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "MovableParentVC.h"

#define kTitleWidth kScreenWidth/3
#define kTitleHeight 45*kRate
#define kTitleBgColor [UIColor colorWithWhite:0.300 alpha:1.000]


@interface MovableParentVC ()<UIScrollViewDelegate>
{
    UIButton *selectButton;//选中按钮
    UIView *_sliderView;//选中按钮下面的小滑块
    UIScrollView *_scroll;

    UIScrollView *_scrollView;
    
    UILabel* titleLabel;//导航栏标题
    
}
@property (nonatomic, strong) NSMutableArray *buttonArray;
@end

@implementation MovableParentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buttonArray = [NSMutableArray array];
    
    [self.navigationItem setHidesBackButton:YES];//将默认的返回按钮隐藏
    [self setNavBgColorWithRed:74 Green:154 Blue:252];//设置导航栏背景颜色
    
}

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
    btn.frame = CGRectMake(15*kRate, 30*kRate, 45*kRate, 18*kRate);
    
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
    [self initWithTitleButton];
    
}

- (void)initWithTitleButton
{
    //标题视图
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*2, kTitleHeight)];
    if (self.navigationController.navigationBar) {
        titleView.frame = CGRectMake(0, 64, kScreenWidth*2, kTitleHeight);
    } else {
        titleView.frame = CGRectMake(0, 0, kScreenWidth*2, kTitleHeight);
    }
    [self.view addSubview:titleView];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTitleHeight)];
    if (self.navigationController.navigationBar) {
        scroll.frame = CGRectMake(0, 64, kScreenWidth, kTitleHeight);
    } else {
        scroll.frame = CGRectMake(0, 0, kScreenWidth, kTitleHeight);
    }
    scroll.backgroundColor = [UIColor whiteColor];
    scroll.contentSize = CGSizeMake(kTitleWidth*_titleArray.count, kTitleHeight);
    scroll.bounces = NO;
    scroll.scrollEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    [scroll flashScrollIndicators];
    [self.view addSubview:scroll];
    _scroll = scroll;
    
    
    //标题按钮
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(kTitleWidth*i, 0, kTitleWidth, kTitleHeight-2);
        [titleBtn setTitle:_titleArray[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:kTitleBgColor forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15.0*kRate];
        titleBtn.tag = 100 + i;
        [titleBtn addTarget:self action:@selector(scrollViewSelectToIndex:) forControlEvents:UIControlEventTouchUpInside];
        [scroll addSubview:titleBtn];
        
        if (i == _selectedNum) {
            selectButton = titleBtn;
            [selectButton setTitleColor:[UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
        }
        
        [_buttonArray addObject:titleBtn];
    }
    
    //底部蓝色小滑块
    UIView *sliderV = [[UIView alloc] initWithFrame:CGRectMake(kTitleWidth*_selectedNum, kTitleHeight - 0.5, kTitleWidth, 0.5)];
    sliderV.backgroundColor = [UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1];
    [scroll addSubview:sliderV];
    _sliderView = sliderV;

    
}

- (void)scrollViewSelectToIndex:(UIButton *)btn
{
    //点击相应按钮后，小滑块随之滑动，按钮颜色改变
    [self selectButton:(btn.tag - 100)];
    
    //点击相应按钮后，显示对应的视图
    [UIView animateWithDuration:0 animations:^{
        _scrollView.contentOffset = CGPointMake(kScreenWidth * (btn.tag-100), 0);
    }];
    
    //进行相应网络请求并刷新页面
    [self getCarFamilyAndUpdateUIWithBtn:btn];
}

//选择某个标题按钮（小滑块随之滑动，按钮颜色改变）
- (void)selectButton:(NSInteger)index
{
    [selectButton setTitleColor:kTitleBgColor forState:UIControlStateNormal];
    selectButton = _buttonArray[index];
    [selectButton setTitleColor:[UIColor colorWithRed:0 green:126/255.0 blue:1 alpha:1] forState:UIControlStateNormal];
    CGRect rect = [selectButton.superview convertRect:selectButton.frame toView:self.view];
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.frame = CGRectMake(kTitleWidth * index, kTitleHeight - 0.5, kTitleWidth, 0.5);
        CGPoint contentOffset = _scroll.contentOffset;
        if (contentOffset.x - (kScreenWidth/2-rect.origin.x-kTitleWidth/2)<=0) {
            [_scroll setContentOffset:CGPointMake(0, contentOffset.y) animated:YES];
        } else if (contentOffset.x - (kScreenWidth/2-rect.origin.x-kTitleWidth/2)+kScreenWidth>=_titleArray.count*kTitleWidth) {
            [_scroll setContentOffset:CGPointMake(_titleArray.count*kTitleWidth-kScreenWidth, contentOffset.y) animated:YES];
        } else {
            [_scroll setContentOffset:CGPointMake(contentOffset.x - (kScreenWidth/2-rect.origin.x-kTitleWidth/2), contentOffset.y) animated:YES];
        }
        
    }];
    
}

//监听滚动事件,以实现通过左右滑动视图也可以使上面的标题按钮与之同步。
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / kScreenWidth;
    [self selectButton:index];
}

//进行相应网络请求并刷新页面
- (void)getCarFamilyAndUpdateUIWithBtn:(UIButton *)btn
{
    NSLog(@"//进行相应网络请求并刷新页面");
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
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTitleHeight, kScreenWidth, kScreenHeight - kTitleHeight)];
    if (self.navigationController.navigationBar) {
        scrollView.frame = CGRectMake(0, kTitleHeight + 64, kScreenWidth, kScreenHeight - kTitleHeight - 64);
    } else {
        scrollView.frame = CGRectMake(0, kTitleHeight, kScreenWidth, kScreenHeight - kTitleHeight);
    }
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = YES;
    scrollView.contentSize = CGSizeMake(kScreenWidth * _controllerArray.count, 0);
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    //将各个控制器中的View视图填充到scrollView对应的内容位置上
    for (int i = 0; i < _controllerArray.count; i++) {
        UIView *view_c = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        UIViewController *vc = _controllerArray[i];
        view_c = vc.view;
        view_c.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight);
        
        [scrollView addSubview:view_c];
    }
    
    
    //初始的时候选择的页面
    [self scrollViewSelectToIndex:selectButton];
}



@end
