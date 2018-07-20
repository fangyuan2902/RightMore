//
//  KRefresh.h
//  RightLoadMore
//
//  Created by 远方 on 2017/5/15.
//  Copyright © 2017年 远方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRefreshConfig.h"

@interface KRefresh : UIView

- (instancetype)initWithScrollView:(UIScrollView *)scroll action:(void (^)(KRefresh *refresh))actionHandler;

- (void)beginRefresh;

@end

