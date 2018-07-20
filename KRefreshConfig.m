//
//  KRefreshConfig.m
//  RightLoadMore
//
//  Created by 远方 on 2017/5/15.
//  Copyright © 2017年 远方. All rights reserved.
//

#import "KRefreshConfig.h"

@implementation KRefreshConfig

+ (instancetype)defaultConfig {
    KRefreshConfig *config = [KRefreshConfig new];
    config.textIdle = KRefreshIdleText;
    config.textReady = KRefreshReadyText;
    config.textRefreshing = KRefreshRefreshingText;
    
    config.viewHeight = KRefreshViewWidth;
    config.readyOffset = KRefreshReadyOffset;
    config.animationDurationFast = KRefreshAnimationDurationFast;
    config.animationDurationSlow = KRefreshAnimationDurationSlow;
    
    return config;
}

@end
