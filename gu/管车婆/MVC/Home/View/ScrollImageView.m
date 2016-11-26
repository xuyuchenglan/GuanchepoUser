//
//  ScrollImageView.m
//  ScrollView实现图片轮播
//
//  Created by 李伟 on 16/8/9.
//  Copyright © 2016年 Norman Lee. All rights reserved.
//

#import "ScrollImageView.h"



#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ScrollImageView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray       *dataSourceUrls;//url的数据源
@property (nonatomic, strong) NSArray       *dataSourcePlaceImages;//预留图片的数据源
@property (nonatomic, assign) NSInteger       imageCount;//图片的张数

@end

@implementation ScrollImageView

- (instancetype)initWithFrame:(CGRect)frame andPictureUrls:(NSArray *)urls andPlaceHolderImages:(NSArray *)images
{
    if (self = [super initWithFrame:frame]) {
        
        _dataSourcePlaceImages = [NSArray arrayWithArray:images];
        _dataSourceUrls = [NSArray arrayWithArray:urls];
        //图片的个数应该取决于最小的那一个 防止数组传入的个数不一致导致崩溃
        _imageCount = _dataSourcePlaceImages.count<_dataSourceUrls.count?_dataSourcePlaceImages.count:_dataSourceUrls.count;
        
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self initScrollViewImage];
        [self addTimer];
    }
    
    return self;
}

#pragma mark Private Method
- (void)initScrollViewImage
{
    //第一张图片(向前拖拽，为了循环，第一张图应该和显示的最后一张图一样)
    UIImageView *firstImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, kSelfWidth, kSelfHeight)];
    firstImg.userInteractionEnabled = YES;
    firstImg.image = [UIImage imageNamed:[_dataSourcePlaceImages firstObject]];
    firstImg.tag = 11;
    [self.scrollView addSubview:firstImg];
    
    UITapGestureRecognizer * tapFirst = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheImageView:)];
    [firstImg addGestureRecognizer:tapFirst];
    
    //最后一张图片(向后拖拽，为了循环，最后一张图应该和显示的第一张图一样)
    UIImageView *lastImg = [[UIImageView alloc] initWithFrame:CGRectMake((_imageCount + 1) * kSelfWidth, 0, kSelfWidth, kSelfHeight)];
    lastImg.image = [UIImage imageNamed:[_dataSourcePlaceImages lastObject]];
    lastImg.tag = 22;
    [self.scrollView addSubview:lastImg];
    
    UITapGestureRecognizer * tapLast = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheImageView:)];
    [lastImg addGestureRecognizer:tapLast];
    
    //第二张图 → 倒数第二张图
    //这里用最少的那个数组
    NSArray * array = _dataSourcePlaceImages.count<_dataSourceUrls.count?_dataSourcePlaceImages:_dataSourceUrls;
    for (NSInteger i = 0; i < array.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_dataSourcePlaceImages[i]]];
        imageView.frame = CGRectMake(kSelfWidth * (i + 1), 0, kSelfWidth, kSelfHeight);
        imageView.userInteractionEnabled = YES;
        imageView.tag = i + 33;
        [self.scrollView addSubview:imageView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheImageView:)];
        [imageView addGestureRecognizer:tap];
    }
    
    //开始显示第二张图片
    self.scrollView.contentOffset = CGPointMake(kSelfWidth, 0);
    self.scrollView.contentSize = CGSizeMake((_imageCount + 2) * kSelfWidth, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextPage
{
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    NSInteger index = self.pageControl.currentPage;
    if (index == _imageCount + 1) {
        index = 0;
    } else {
        index ++;
    }
    [self.scrollView setContentOffset:CGPointMake((index + 1) * scrollWidth, 0) animated:YES];
}

- (void)scrollViewFinish:(UIScrollView *)scrollView
{
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    NSInteger index = (self.scrollView.contentOffset.x + scrollWidth * 0.5) / scrollWidth;
    if (index == _imageCount + 1) {
        //显示最后一张的时候，强制设置为第二张（也就是轮播图的第一张），这样就开始无限循环了
        [self.scrollView setContentOffset:CGPointMake(scrollWidth, 0) animated:NO];
    } else if (index == 0) {
        //显示第一张的时候，强制设置为倒数第二张（轮播图最后一张），实现倒序无限循环
        [self.scrollView setContentOffset:CGPointMake(_imageCount * scrollWidth, 0) animated:NO];
    }
}


#pragma mark - scrollViewTapGesture method
-(void)tapTheImageView:(UITapGestureRecognizer *)gesture
{
    UIImageView * imageView = (UIImageView *)gesture.view;
    if (_delegate && [_delegate respondsToSelector:@selector(scrollImageView:didTapImageView:atIndex:)])
    {
        NSInteger index ;
        NSArray * array = _dataSourcePlaceImages.count<_dataSourceUrls.count?_dataSourcePlaceImages:_dataSourceUrls;
        if (imageView.tag == 11)
        {
            index = 0;
        }else if(imageView.tag == 22)
        {
            index = array.count-1;
        }else
        {
            index = imageView.tag - 33;
        }
        [_delegate scrollImageView:self didTapImageView:imageView atIndex:index];
    }

}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    NSInteger index = (self.scrollView.contentOffset.x + scrollWidth * 0.5) / scrollWidth;
    if (index == _imageCount + 2) {
        index = 1;
    } else if (index == 0) {
        index = _imageCount;
    }
    self.pageControl.currentPage = index - 1;//当前在第几页（第几张图片）
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"开始拖动");
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

/**
 *  当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法不会被调用，
 *  下面两个方法为有效的动画方法，
 *  setContentOffset:<#(CGPoint)#> animated:<#(BOOL)#>
 *  scrollRectToVisible:<#(CGRect)#> animated:<#(BOOL)#>
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //此方法，
    [self scrollViewFinish:scrollView];
}

/**
 *  滚动视图减速完成,滚动将停止时,调用该方法。一次有效滑动,只执行一次。
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewFinish:scrollView];
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        //我觉得它的大小应该和它父试图有关联
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kSelfWidth, kSelfHeight)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((kSelfWidth - 100) * 0.5f, kSelfHeight - 40, 100, 20)];
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        _pageControl.numberOfPages = _imageCount;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}

@end
