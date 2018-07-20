//
//  KRefreshView.h
//  RightLoadMore
//
//  Created by 远方 on 2017/5/15.
//  Copyright © 2017年 远方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRefreshConfig.h"

@interface KRefreshView : UIView

- (void)showWithState:(KRefreshState)state config:(KRefreshConfig *)config animated:(BOOL)animated;

@end
