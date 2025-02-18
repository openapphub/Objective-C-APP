//
//  LoginViewController.m
//  Tracker
//
//  Created by jin xm on 2025/1/16.
//

#import <Masonry/Masonry.h>
#import "APIConstants.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "NetworkManager.h"
#import "RegisterViewController.h"


@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 初始化控件
    [self setupUI];

    // 设置布局
    [self setupConstraints];
}

- (void)setupUI {
    // 用户名输入框
    self.usernameTextField = [[QMUITextField alloc] init];
    self.usernameTextField.placeholder = @"用户名";
    self.usernameTextField.backgroundColor = [UIColor qmui_colorWithHexString:@"#F5F5F5"];
    self.usernameTextField.layer.cornerRadius = 5;
    self.usernameTextField.layer.masksToBounds = YES;
    [self.view addSubview:self.usernameTextField];

    // 密码输入框
    self.passwordTextField = [[QMUITextField alloc] init];
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.backgroundColor = [UIColor qmui_colorWithHexString:@"#F5F5F5"];
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.layer.masksToBounds = YES;
    [self.view addSubview:self.passwordTextField];

    // 登录按钮
    self.loginButton = [[QMUIButton alloc] init];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.backgroundColor = [UIColor qmui_colorWithHexString:@"#007AFF"];
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
    [self.loginButton addTarget:self action:@selector(loginButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];

    // 注册按钮
    self.registerButton = [[QMUIButton alloc] init];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.registerButton.backgroundColor = [UIColor qmui_colorWithHexString:@"#34C759"];
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.layer.masksToBounds = YES;
    [self.registerButton addTarget:self action:@selector(registerButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
}

- (void)setupConstraints {
    CGFloat margin = 20;
    CGFloat textFieldHeight = 40;
    CGFloat buttonHeight = 40;

    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.left.equalTo(self.view.mas_left).offset(margin);
        make.right.equalTo(self.view.mas_right).offset(-margin);
        make.height.mas_equalTo(textFieldHeight);
    }];

    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.usernameTextField.mas_bottom).offset(margin);
        make.left.equalTo(self.view.mas_left).offset(margin);
        make.right.equalTo(self.view.mas_right).offset(-margin);
        make.height.mas_equalTo(textFieldHeight);
    }];

    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(margin);
        make.left.equalTo(self.view.mas_left).offset(margin);
        make.right.equalTo(self.view.mas_right).offset(-margin);
        make.height.mas_equalTo(buttonHeight);
    }];

    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom).offset(margin);
        make.left.equalTo(self.view.mas_left).offset(margin);
        make.right.equalTo(self.view.mas_right).offset(-margin);
        make.height.mas_equalTo(buttonHeight);
    }];
}

- (void)loginButtonTapped {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;

    // 简单的验证
    if (username.length == 0 || password.length == 0) {
        [QMUITips showError:@"用户名和密码不能为空"];
        return;
    }

    // 登录接口调用
    // {
//    "username": "admin",
//    "password": "admin1234"
//  }
    NSDictionary *params = @{
            @"username": username, @"password": password
    };
    [[NetworkManager sharedManager] postRequestWithURL:kAPIEndpointLogin
                                            parameters:params
                                               success:^(id responseObject) {
        NSLog(@"Response: %@", responseObject);

        /**
           Response: {
             code = 200;
             data =     {
                 accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsInVzZXJuYW1lIjoiYWRtaW4iLCJpc3MiOiJqaW54bSIsInN1YiI6IjEiLCJleHAiOjE3MzcxMDMxMTIsImlhdCI6MTczNzAxNjcxMn0.J1JhGbKT-2HAfK1RR506shcNLFuYlJIpGP6QCo_Cq10";
                 id = 1;
                 refreshToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMSIsInVzZXJuYW1lIjoiYWRtaW4iLCJpc3MiOiJqaW54bSIsInN1YiI6IjEiLCJleHAiOjE3Mzc2MjE1MTIsImlhdCI6MTczNzAxNjcxMn0.bVp0fozicJHcCiYq7SEtAGbTAGsnCHWbbfiYm7RKsrM";
                 username = admin;
             };
             message = success;
           }
         */
        if ([responseObject[@"code"] integerValue] == 200) {
            NSDictionary *data = responseObject[@"data"];
            NSString *accessToken = data[@"accessToken"];
            NSString *refreshToken = data[@"refreshToken"];
            NSLog(@"accessToken: %@", accessToken);
            NSLog(@"refreshToken: %@", refreshToken);
            NSString *username = data[@"username"];
            // 保存用户名称 + token, 用于后续接口调用
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:username
                         forKey:@"username"];
            [defaults setObject:accessToken
                         forKey:@"accessToken"];
            [defaults setObject:refreshToken
                         forKey:@"refreshToken"];
            [defaults synchronize];
            [QMUITips showSucceed:@"登录成功"];
            // 跳转到tabbar
//            [self.navigationController pushViewController:[[MainTabBarController alloc] init] animated:YES];
            // 登录成功后，切换到 MainTabBarController， 设置为首页
            MainTabBarController *tabBarController = [[MainTabBarController alloc] init];

            // 添加动画效果
            [UIView transitionWithView:self.view.window
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                self.view.window.rootViewController = tabBarController;
            }
                            completion:nil];
        }
    }
                                               failure:^(NSError *error) {
        NSLog(@"Error: %@", error.localizedDescription);
        [QMUITips showError:@"登录失败"];
    }];

    // 模拟登录成功
//    [self saveUserInfoWithUsername:username];
//    [QMUITips showSucceed:@"登录成功"];

    // 跳转到首页
//    [self.navigationController pushViewController:[[MainTabBarController alloc] init] animated:YES];
}

- (void)registerButtonTapped {
    // 跳转到注册页面
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
}

- (void)saveUserInfoWithUsername:(NSString *)username password:(NSString *)password {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    [defaults setObject:username forKey:@"username"];
    [defaults setObject:password forKey:@"password"];
    [defaults synchronize];
}

@end
