
//
//  KRefreshView.m
//  RightLoadMore
//
//  Created by 远方 on 2017/5/15.
//  Copyright © 2017年 远方. All rights reserved.
//

#import "KRefreshView.h"

@interface KRefreshView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) NSString *currentText;

@end

@implementation KRefreshView

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.textLabel];
        [self addSubview:self.imageView];
    }
    return self;
}

#pragma mark - Override

- (void)layoutSubviews {
    [self updateLocation];
    [super layoutSubviews];
}

- (void)updateLocation {
    [_textLabel sizeToFit];
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    _textLabel.center = center;
    
    center.x -= CGRectGetMidX(_textLabel.bounds) + CGRectGetMidX(_imageView.bounds) + 5;
    _imageView.center = center;
}

#pragma mark - KRefreshView

- (void)showWithState:(KRefreshState)state config:(KRefreshConfig *)config animated:(BOOL)animated {
    switch (state) {
        case KRefreshStateIdle: {
            [self showIdleWithConfig:config animated:animated];
            break;
        }
        case KRefreshStateReady: {
            [self showRedayWithConfig:config animated:animated];
            break;
        }
        case KRefreshStateRefreshing: {
            [self showRefreshingWithConfig:config animated:animated];
            break;
        }
    }
}

#pragma mark - Private

- (void)showIdleWithConfig:(KRefreshConfig *)config animated:(BOOL)animated {
    void (^action)(void) = ^{
        _imageView.transform = CGAffineTransformIdentity;
    };
    
    if (animated) {
        [UIView animateWithDuration:config.animationDurationSlow animations:action completion:nil];
    } else {
        action();
    }
    
    _imageView.hidden = NO;
    self.currentText = config.textIdle;
}

- (void)showRedayWithConfig:(KRefreshConfig *)config animated:(BOOL)animated {
    void (^action)(void) = ^{
        _imageView.transform = CGAffineTransformRotate(_imageView.transform, DegreesToRadians(180));
    };
    
    if (animated) {
        [UIView animateWithDuration:config.animationDurationSlow animations:action completion:nil];
    } else {
        action();
    }
    self.currentText = config.textReady;
}

- (void)showRefreshingWithConfig:(KRefreshConfig *)config animated:(BOOL)animated {
    _imageView.hidden = YES;
    self.currentText = config.textRefreshing;
}

#pragma mark - Setter

- (void)setCurrentText:(NSString *)currentText {
    _currentText = currentText;
    _textLabel.text = currentText;
    [self updateLocation];
}

#pragma mark - Getter

- (UILabel *)textLabel {
    if (!_textLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:14];
        label.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.text = KRefreshIdleText;
        _textLabel = label;
    }
    return _textLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [UIImageView new];
        imageView.bounds = CGRectMake(0, 0, 16, 16);
        _imageView = imageView;
        _imageView.image = [UIImage imageNamed:@"k_arrow"];
    }
    return _imageView;
}

@end
