//
//  UIScrollView+KRefresh.m
//  RightLoadMore
//
//  Created by 远方 on 2017/5/15.
//  Copyright © 2017年 远方. All rights reserved.
//

#import "UIScrollView+KRefresh.h"

@implementation UIScrollView (KRefresh)

- (KRefresh *)addKRefreshAction:(void (^)(KRefresh *refresh))actionHandler {
    KRefresh *refresh = [[KRefresh alloc] initWithScrollView:self action:actionHandler];
    [self addSubview:refresh];
    return refresh;
}

@end
