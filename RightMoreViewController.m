//
//  RightMoreViewController.m
//  AllKinds
//
//  Created by 远方 on 2017/6/23.
//  Copyright © 2017年 远方. All rights reserved.
//

#import "RightMoreViewController.h"
#import "UIScrollView+KRefresh.h"

@interface RightMoreViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation RightMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRefresh];
}

- (void)viewDidLayoutSubviews {
    self.scrollView.contentSize = [UIScreen mainScreen].bounds.size;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)addRefresh {
    [self.scrollView addKRefreshAction:^(KRefresh *refresh) {
        NSLog(@"PullRefreshPositionRight");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
