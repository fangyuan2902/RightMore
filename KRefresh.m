//
//  KRefresh.m
//  RightLoadMore
//
//  Created by 远方 on 2017/5/15.
//  Copyright © 2017年 远方. All rights reserved.
//

#define KRefreshKeyPathContentOffset @"contentOffset"
#define KRefreshKeyPathContentSize @"contentSize"

#import "KRefresh.h"
#import "KRefreshView.h"

@interface KRefresh ()

@property (nonatomic, strong) KRefreshConfig *config;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) KRefreshView *refreshView;
@property (nonatomic, assign) KRefreshState state;
@property (nonatomic, copy) void (^actionHandler)(KRefresh *refresh);

@end

@implementation KRefresh

#pragma mark - Initialization

- (instancetype)initWithScrollView:(UIScrollView *)scroll action:(void (^)(KRefresh *))actionHandler {
    if (self = [super init]) {
        _actionHandler = actionHandler;
        _config = [KRefreshConfig defaultConfig];
        _refreshView = [[KRefreshView alloc] init];
        _state = KRefreshStateIdle;
        [self setContext];
    }
    return self;
}

- (void)setContext {
    [self addSubview:_refreshView];
    [_refreshView showWithState:KRefreshStateIdle config:_config animated:NO];
//    self.backgroundColor = [UIColor orangeColor];
}

#pragma mark - Override

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    [self removeObservers];
    if (newSuperview) { // 新的父控件
        _scrollView = (UIScrollView *)newSuperview;
        _scrollView.alwaysBounceHorizontal = YES;
        
        [self addObservers];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLocation];
}

#pragma mark - Location

- (void)updateLocation {
    CGFloat x = MAX(_scrollView.contentSize.width, CGRectGetWidth(_scrollView.bounds)) + KRefreshViewWidth;
    CGFloat width = CGRectGetHeight(_scrollView.bounds);;
    
    CGRect frame = CGRectMake(x, 0, width, KRefreshViewWidth);
    self.transform = CGAffineTransformIdentity;
    self.frame = frame;
    _refreshView.frame = self.bounds;
    
    [self setAnchorPoint:CGPointMake(0, 0) forView:self];
    self.transform = CGAffineTransformRotate(self.transform, DegreesToRadians(90));
}

- (void)updatePositionWhenContentsSizeIsChanged:(NSDictionary *)change {
    CGSize oldContentSize = [change[NSKeyValueChangeOldKey] CGSizeValue];
    CGSize newContentSize = [change[NSKeyValueChangeNewKey] CGSizeValue];
    CGPoint center = self.center;
    
    newContentSize.width = MAX(_scrollView.contentSize.width, CGRectGetWidth(_scrollView.bounds));
    center.x += newContentSize.width - oldContentSize.width;
    self.center = center;
}

//设置view的anchorPoint，同时保证view的frame不改变
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

#pragma mark - KVO

- (void)addObservers {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    [self.scrollView addObserver:self forKeyPath:KRefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:KRefreshKeyPathContentSize options:options context:nil];
}

- (void)removeObservers {
    [self.superview removeObserver:self forKeyPath:KRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:KRefreshKeyPathContentSize];;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:KRefreshKeyPathContentSize]) {
        [self updatePositionWhenContentsSizeIsChanged: change];
        return;
    }
    
    if (self.hidden) return;
    if ([keyPath isEqualToString:KRefreshKeyPathContentOffset]) {
        [self scrollViewDidScroll:_scrollView];
    }
}

#pragma mark - Public

- (void)beginRefresh {
    if (_state != KRefreshStateRefreshing) {
        self.state = KRefreshStateRefreshing;
        if (_actionHandler) {
            _actionHandler(self);
        }
        if (_state == KRefreshStateRefreshing) {
            self.state = KRefreshStateIdle;
        }
    }
}

#pragma mark - Private

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_state == KRefreshStateRefreshing) return;
    
    if (scrollView.isDragging) {
        if (_state == KRefreshStateIdle && [self isScrolledOverReadyOffset]) {
            self.state = KRefreshStateReady;
        } else if (_state == KRefreshStateReady && ![self isScrolledOverReadyOffset]) {
            self.state = KRefreshStateIdle;
        }
    } else {
        if (_state == KRefreshStateReady) {
            [self beginRefresh];
        }
    }
}

- (BOOL)isScrolledOverReadyOffset {
    CGFloat readyOffset = _config.readyOffset;
    return self.scrollView.contentOffset.x >= (self.scrollView.contentSize.width - self.scrollView.frame.size.width) + readyOffset;
}

#pragma mark - Setter

- (void)setState:(KRefreshState)state {
    KRefreshState oldState = _state;
    if (oldState == state) return;
    _state = state;
    [_refreshView showWithState:state config:_config animated:YES];
}

@end

