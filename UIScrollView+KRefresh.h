//
//  UIScrollView+KRefresh.h
//  RightLoadMore
//
//  Created by 远方 on 2017/5/15.
//  Copyright © 2017年 远方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRefresh.h"

@interface UIScrollView (KRefresh)

- (KRefresh *)addKRefreshAction:(void (^)(KRefresh *refresh))actionHandler;

@end
