//
//  MainTabBarController.m
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建首页视图控制器
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
//    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
//                                                      image:[UIImage imageNamed:@"home"]
//                                              selectedImage:[UIImage imageNamed:@"home_selected"]];
    // 使用系统图标 sf
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                       image:[UIImage systemImageNamed:@"house"]
                                               selectedImage:[UIImage systemImageNamed:@"house.fill"]];
    
    // 创建添加支出视图控制器
    DiscoverViewController *disCoverVC = [[DiscoverViewController alloc] init];
    UINavigationController *disCoverVCNav = [[UINavigationController alloc] initWithRootViewController:disCoverVC];
    disCoverVCNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                     image:[UIImage systemImageNamed:@"lightbulb.min"]
                                             selectedImage:[UIImage systemImageNamed:@"lightbulb.min.fill"]];
    
    // 创建统计视图控制器
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    UINavigationController *profileNav = [[UINavigationController alloc] initWithRootViewController:profileVC];
    profileNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人"
                                                            image:[UIImage systemImageNamed:@"person"]
                                                    selectedImage:[UIImage systemImageNamed:@"person.fill"]];
    
    // 设置TabBar的视图控制器数组
    self.viewControllers = @[homeNav, disCoverVCNav, profileNav];
}

@end

