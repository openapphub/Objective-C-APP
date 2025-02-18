//
//  BaseNavigationController.m
//  Tracker
//
//  Created by jin xm on 2025/1/16.
//

// BaseNavigationController.m
#import "BaseNavigationController.h"

@interface BaseNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 设置导航栏样式
    self.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationBar.titleTextAttributes = @{
        NSForegroundColorAttributeName: UIColorBlack,
        NSFontAttributeName: [UIFont boldSystemFontOfSize:18]
    };
    self.navigationBar.tintColor = UIColorBlack;
    self.navigationBar.translucent = NO;
    
    // 启用手势返回
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    // 设置代理
       self.delegate = self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 设置返回按钮
    if (self.viewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(handleBackButtonClick)];
    }
    
    // 拦截某些页面的跳转
//    if ([viewController isKindOfClass:[RestrictedViewController class]]) {
//        [QMUITips showError:@"无权访问该页面" inView:self.view hideAfterDelay:1.5];
//        return;
//    }
    
    // 调用父类方法
    [super pushViewController:viewController animated:animated];
}

- (void)handleBackButtonClick {
    [self popViewControllerAnimated:YES];
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleDarkContent; // 设置状态栏文字为白色
//}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 只有在非根页面时才允许手势返回
    return self.viewControllers.count > 1;
}
// 页面声明周期
//#pragma mark - UINavigationControllerDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    NSLog(@"即将显示页面: %@", viewController);
//}
//
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    NSLog(@"已显示页面: %@", viewController);
//}
@end
