//
//  APIClient.m
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import "APIConstants.h"
// k前缀表示是常量 konstant

// 基础 URL
NSString *const kAPIBaseURL = @"https://api.example.com";

// 用户相关接口
NSString *const kAPIEndpointLogin = @"/api/v1/users/login";
NSString *const kAPIEndpointRegister = @"/api/v1/users";
NSString *const kAPIEndpointUserProfile = @"/user/profile";

// 订单相关接口
NSString *const kAPIEndpointCreateOrder = @"/order/create";
NSString *const kAPIEndpointOrderList = @"/order/list";

// 请求方法
NSString *const kHTTPMethodGET = @"GET";
NSString *const kHTTPMethodPOST = @"POST";
