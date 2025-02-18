//
//  LoginViewController.h
//  Tracker
//
//  Created by jin xm on 2025/1/16.
//

//#import <Foundation/Foundation.h>
//
//NS_ASSUME_NONNULL_BEGIN
//
//@interface LoginViewController : NSObject
//
//@end
//
//NS_ASSUME_NONNULL_END

#import "BaseViewController.h"

@interface LoginViewController : BaseViewController

@property (nonatomic, strong) QMUITextField *usernameTextField;
@property (nonatomic, strong) QMUITextField *passwordTextField;
@property (nonatomic, strong) QMUIButton *loginButton;
@property (nonatomic, strong) QMUIButton *registerButton;

@end
