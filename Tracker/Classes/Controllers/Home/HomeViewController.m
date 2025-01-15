//
//  HomeViewController.m
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import <QMUIKit/QMUIKit.h>
#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) QMUIEmptyView *emptyView;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";

    // 示例：添加一个测试按钮
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [testButton setTitle:@"测试网络请求" forState:UIControlStateNormal];
    [testButton addTarget:self
                   action:@selector(testRequestButtonTapped)
         forControlEvents:UIControlEventTouchUpInside];
    testButton.frame = CGRectMake(100, 100, 200, 44);
    [self.view addSubview:testButton];
    // 创建 QMUIEmptyView
    // 显示 emptyView
    [self showEmptyViewWithText:@"暂无数据"
                     detailText:@"请稍后再试"
                    buttonTitle:@"刷新"
                   buttonAction:@selector(refreshData)];
    // 测试主题配色
    // 设置一个视图的背景色为红色
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    redView.backgroundColor = UIColorRed;
    [self.view addSubview:redView];

    // 设置一个视图的背景色为绿色
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, 100, 100)];
    greenView.backgroundColor = UIColorGreen;
    [self.view addSubview:greenView];
}

- (void)testRequestButtonTapped {
    [self requestWithURL:@"https://api.example.com/test"
                  params:@{ @"test": @"value" }
                 success:^(id response) {
        NSLog(@"请求成功：%@", response);
    }
                 failure:^(NSError *error) {
        NSLog(@"请求失败：%@", error);
    }];
}

- (void)showEmptyViewWithText:(NSString *)text
                   detailText:(NSString *)detailText
                  buttonTitle:(NSString *)buttonTitle
                 buttonAction:(SEL)action {
    // 创建或获取 emptyView
    self.emptyView = [[QMUIEmptyView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.emptyView];

    // 设置内容
    [self.emptyView setImage:[UIImage imageNamed:@"empty_icon"]];
    [self.emptyView setTextLabelText:@"暂无数据"];
    [self.emptyView setDetailTextLabelText:@"请稍后再试"];
    [self.emptyView setActionButtonTitle:@"刷新"];
    [self.emptyView setLoadingViewHidden:YES];

    // 设置按钮点击事件
    if (action) {
        [self.emptyView.actionButton addTarget:self
                                        action:action
                              forControlEvents:UIControlEventTouchUpInside];
    }

    // 显示 emptyView
    self.emptyView.hidden = NO;
    
}

- (void)refreshData {
    NSLog(@"刷新数据");
    // 隐藏 emptyView
    self.emptyView.hidden = YES;
}

@end
