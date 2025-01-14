//
//  DiscoverViewController.m
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import "DiscoverViewController.h"

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    
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
    [self requestWithURL:@"https://api.example.com/test"
                params:@{@"test": @"value"}
               success:^(id response) {
        NSLog(@"请求成功：%@", response);
    } failure:^(NSError *error) {
        NSLog(@"请求失败：%@", error);
    }];
}

@end
