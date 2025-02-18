//
//  APIClient.h
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import <Foundation/Foundation.h>

/**
 在 Objective-C 中，extern 是一个关键字，用于声明 外部变量 或 外部常量。它的作用是告诉编译器：“这个变量或常量是在其他地方定义的，你可以在当前文件中使用它，但不要在这里分配内存。”
 */

// 基础 URL
extern NSString *const kAPIBaseURL;

// 用户相关接口
extern NSString *const kAPIEndpointLogin;
extern NSString *const kAPIEndpointRegister;
extern NSString *const kAPIEndpointUserProfile;

// 订单相关接口
extern NSString *const kAPIEndpointCreateOrder;
extern NSString *const kAPIEndpointOrderList;

// 请求方法
extern NSString *const kHTTPMethodGET;
extern NSString *const kHTTPMethodPOST;
