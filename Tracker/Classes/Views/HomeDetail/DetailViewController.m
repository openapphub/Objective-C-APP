//
//  HomeDetailViewController.m
//  Tracker
//
//  Created by jin xm on 2025/1/16.
//

#import "DetailViewController.h"
#import "BaseNavigationController.h"

@interface DetailViewController ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
    // 检查 navigationController 是否是 BaseNavigationController
    if ([self.navigationController isKindOfClass:[BaseNavigationController class]]) {
        NSLog(@"navigationController 是 BaseNavigationController，全局替换已生效");
    } else {
        NSLog(@"navigationController 不是 BaseNavigationController，全局替换未生效");
    }
}

- (void)setupUI {
    // 设置页面标题
    self.title = @"详情";
    
    // 初始化 UI 组件
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.qmui_width - 40, 30)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, self.view.qmui_width - 40, 200)];
    self.descriptionLabel.font = [UIFont systemFontOfSize:16];
    self.descriptionLabel.numberOfLines = 0;
    [self.view addSubview:self.descriptionLabel];
}

- (void)loadData {
    // 根据传递的数据更新 UI
    if (self.detailItem) {
        self.titleLabel.text = self.detailItem[@"title"];
        self.descriptionLabel.text = self.detailItem[@"description"];
    }
}

@end
