//
//  LoopView.m
//  网易新闻
//
//  Created by 杰佬 on 16/4/12.
//  Copyright © 2016年 魏明杰. All rights reserved.
//

#import "LoopView.h"
#import "LoopViewFlowLayout.h"
#import "LoopViewCell.h"

@interface LoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *URLs;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL enableTimer;

@end

@implementation LoopView

- (instancetype)initWithURLs:(NSArray <NSString *> *)URLs titles:(NSArray <NSString *> *)titles {
    if (self = [super init]) {
        self.URLs = URLs;
        self.titles = titles;
        
        self.pageControl.numberOfPages = self.URLs.count;
        self.titleLabel.text = self.titles[0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.URLs.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            [self addTimer];
        });
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
/**
 *  初始化子控件
 */

- (void)setup {
    // UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[LoopViewFlowLayout alloc] init]];
    collectionView.delegate = self;
    // 设置分页效果
    collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    // 设置背景颜色
    collectionView.backgroundColor = [UIColor whiteColor];
    // 注册cell
    [collectionView registerClass:[LoopViewCell class] forCellWithReuseIdentifier:@"fuck"];
    // 设置数据源
    collectionView.dataSource = self;
    
    [self addSubview:collectionView];
    
    self.collectionView = collectionView;
    // UILabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    // UIPageControl
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    // 设置当前显示页的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    self.enableTimer = YES;
}

#pragma mark - 布局子控件的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleH = 30.0f;
    // 设置子控件frame
    CGRect frame = self.bounds;
    frame.size.height -= titleH;
    self.collectionView.frame = frame;
    
    CGFloat marginX = 20;
    // 设置pageControl的frame
    CGFloat pageW = 40;
    CGFloat pageX = frame.size.width - pageW - marginX;
    CGFloat pageY = self.collectionView.frame.size.height;
    CGFloat pageH = titleH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    // 标题
    CGFloat titleX = marginX * 0.5;
    CGFloat titleY = pageY;
    CGFloat titleW = pageX - titleX;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);


}

#pragma mark - 定时器方法

- (void)addTimer {
    if (self.timer) {
        return;
    }
    if (!self.enableTimer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (void)update {
    NSInteger page = self.collectionView.contentOffset.x / self.frame.size.width;
    CGFloat offsetX = (page + 1) * self.collectionView.frame.size.width;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES] ;
    

}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark - UICollectionView 数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.URLs.count * 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fuck" forIndexPath:indexPath];
    cell.URL = self.URLs[indexPath.item % self.URLs.count];
//    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    return cell;
}

#pragma mark - UIScollView 代理方法

//手拽即将停止时调用
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = scrollView.contentOffset.x / self.frame.size.width;
    if (page == [self.collectionView numberOfItemsInSection:0] - 1 ) {
        self.collectionView.contentOffset = CGPointMake((self.URLs.count - 1) * self.frame.size.width, 0);
    }
    if (page == 0) {
        self.collectionView.contentOffset = CGPointMake((self.URLs.count) * self.frame.size.width, 0);
    }
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 计算页号
    NSInteger page =  (CGFloat)scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    
    // 根据页号获得标题
    self.titleLabel.text = self.titles[page % self.titles.count];
    self.pageControl.currentPage = page % self.URLs.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

@end
