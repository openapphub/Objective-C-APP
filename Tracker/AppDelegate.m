//
//  AppDelegate.m
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import <QMUIKit/QMUIKit.h>
#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "BaseViewController.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "NetworkManager.h"

//#import "QMUIConfigurationTemplate.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 初始化 MainTabBarController
    MainTabBarController *tabBarController = [[MainTabBarController alloc] init];

    // 设置网络管理器
    [self setupNetworkManager];

    // 初始化 UIWindow
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    // 根据用户登录状态设置根视图控制器
    if (self.setupCheckUserLogin) {
        self.window.rootViewController = tabBarController;
    } else {
        UINavigationController *loginNavController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
        self.window.rootViewController = loginNavController;
    }

    // 显示窗口
    [self.window makeKeyAndVisible];

    return YES;
}

// 初始化设置接口请求配置
- (void)setupNetworkManager {
    [[NetworkManager sharedManager] setBaseURL:@"http://167.253.157.69:3810"];
    [[NetworkManager sharedManager] setTimeoutInterval:60];
    [[NetworkManager sharedManager] setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 从 NSUserDefaults 中读取 Token
    NSString *jwtToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"JWTAuthToken"];

    // 设置 Token 到 NetworkManager
    if (jwtToken) {
        [[NetworkManager sharedManager] setJWTToken:jwtToken];
    }
}

// 检查用户登录状态
- (Boolean)setupCheckUserLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:@"username"];

//       NSString *password = [defaults objectForKey:@"password"];
    if (username) {
        return true;
    }

    return false;
}

//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
