//
//  ProfileViewController.m
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import "ProfileViewController.h"

@implementation ProfileViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人";
    
    // 示例：添加一个测试按钮
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [testButton setTitle:@"测试网络请求" forState:UIControlStateNormal];
    [testButton addTarget:self
                  action:@selector(testRequestButtonTapped)
        forControlEvents:UIControlEventTouchUpInside];
    testButton.frame = CGRectMake(100, 100, 200, 44);
    [self.view addSubview:testButton];
}

- (void)testRequestButtonTapped {
    NSLog(@"请求");
}

@end
