//
//  RegisterViewController.m
//  Tracker
//
//  Created by jin xm on 2025/1/16.
//

#import "RegisterViewController.h"

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 用户名输入框
    self.usernameTextField = [[QMUITextField alloc] init];
    self.usernameTextField.placeholder = @"用户名";
    self.usernameTextField.backgroundColor = [UIColor qmui_colorWithHexString:@"#F5F5F5"];
    self.usernameTextField.layer.cornerRadius = 5;
    self.usernameTextField.layer.masksToBounds = YES;
    self.usernameTextField.frame = CGRectMake(20, 100, self.view.qmui_width - 40, 40);
    [self.view addSubview:self.usernameTextField];
    
    // 密码输入框
    self.passwordTextField = [[QMUITextField alloc] init];
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.backgroundColor = [UIColor qmui_colorWithHexString:@"#F5F5F5"];
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.layer.masksToBounds = YES;
    self.passwordTextField.frame = CGRectMake(20, 160, self.view.qmui_width - 40, 40);
    [self.view addSubview:self.passwordTextField];
    
    // 注册按钮
    self.registerButton = [[QMUIButton alloc] init];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.registerButton.backgroundColor = [UIColor qmui_colorWithHexString:@"#34C759"];
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.layer.masksToBounds = YES;
    self.registerButton.frame = CGRectMake(20, 220, self.view.qmui_width - 40, 40);
    [self.registerButton addTarget:self action:@selector(registerButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
}

- (void)registerButtonTapped {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    // 简单的验证
    if (username.length == 0 || password.length == 0) {
        [QMUITips showError:@"用户名和密码不能为空"];
        return;
    }
    
    // 模拟注册成功
    [self saveUserInfoWithUsername:username password:password];
    [QMUITips showSucceed:@"注册成功"];
    
    // 返回登录页面
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveUserInfoWithUsername:(NSString *)username password:(NSString *)password {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:@"username"];
    [defaults setObject:password forKey:@"password"];
    [defaults synchronize];
}
@end
