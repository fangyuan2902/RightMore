//
//  KRefreshConfig.h
//  RightLoadMore
//
//  Created by 远方 on 2017/5/15.
//  Copyright © 2017年 远方. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DegreesToRadians(degrees) ((degrees * M_PI) / 180.0)
#define KRefreshViewWidth 50.0
#define KRefreshReadyOffset 50.0
#define KRefreshAnimationDurationFast 0.25
#define KRefreshAnimationDurationSlow 0.4


#define KRefreshIdleText @"左拉加载更多"
#define KRefreshReadyText @"松开立即加载"
#define KRefreshRefreshingText @"正在加载..."

typedef NS_ENUM(NSUInteger, KRefreshState) {
    KRefreshStateIdle,
    KRefreshStateReady,
    KRefreshStateRefreshing,
};

@interface KRefreshConfig : NSObject

@property (nonatomic, strong) NSString *textIdle;//default "左拉可以加载"
@property (nonatomic, strong) NSString *textReady;//"default 松开立即加载"
@property (nonatomic, strong) NSString *textRefreshing;//default "正在加载..."

@property (nonatomic, assign) CGFloat viewHeight;   //default 50.0
@property (nonatomic, assign) CGFloat readyOffset;  //default 50.0

@property (nonatomic, assign) CGFloat animationDurationFast;//default 0.25
@property (nonatomic, assign) CGFloat animationDurationSlow;//default  0.4

+ (instancetype)defaultConfig;

@end
