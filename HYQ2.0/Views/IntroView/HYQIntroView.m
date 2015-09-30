//
//  HYQIntroView.m
//  HYQ2.0
//
//  Created by waveboyz on 15/8/21.
//  Copyright (c) 2015年 HZHaoYuanQu. All rights reserved.
//

#import "HYQIntroView.h"

@interface HYQIntroView ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UIButton *doneButton;
@property (strong, nonatomic) UIView *viewOne;
@property (strong, nonatomic) UIView *viewTwo;
@property (strong, nonatomic) UIView *viewThree;

@end

@implementation HYQIntroView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.frame];
        backgroundImageView.backgroundColor = NAVIBAR_GREEN_COLOR;
        
        [self addSubview:backgroundImageView];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        [self.scrollView addSubview:self.viewOne];
        [self.scrollView addSubview:self.viewTwo];
        [self.scrollView addSubview:self.viewThree];
        
        //Done Button
        [self addSubview:self.doneButton];
    }
    
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
    self.pageControl.currentPage = roundf(pageFraction);
}

-(UIView *)viewOne
{
    if (!_viewOne) {
        _viewOne = [[UIView alloc] initWithFrame:self.frame];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.image = [UIImage imageNamed:@"introview1"];
        [_viewOne addSubview:imageview];
    }
    
    return _viewOne;
}

-(UIView *)viewTwo
{
    if (!_viewTwo) {
        _viewTwo = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.image = [UIImage imageNamed:@"introview2"];
        [_viewTwo addSubview:imageview];
    }
    
    return _viewTwo;
}

-(UIView *)viewThree
{
    if (!_viewThree) {
        _viewThree = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, kScreenHeight)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.image = [UIImage imageNamed:@"introview3"];
        [_viewThree addSubview:imageview];
    }
    
    return _viewThree;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [_scrollView setDelegate:self];
        [_scrollView setPagingEnabled:YES];
        //设置引导页宽度
        [_scrollView setContentSize:CGSizeMake(self.frame.size.width*3, self.scrollView.frame.size.height)];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - 20, kScreenWidth, 10)];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
        [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
        [_pageControl setNumberOfPages:3];
    }
    
    return _pageControl;
}

-(UIButton *)doneButton
{
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth * 0.25,kScreenHeight - 100, self.frame.size.width*.5, 30)];
        [_doneButton setTintColor:[UIColor whiteColor]];
        [_doneButton setImage:[UIImage imageNamed:@"skip_icon"] forState:UIControlStateNormal];
        [_doneButton addTarget:self.delegate action:@selector(onDoneButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [_doneButton.layer setCornerRadius:5];
        [_doneButton setClipsToBounds:YES];
    }
    
    return _doneButton;
}

@end