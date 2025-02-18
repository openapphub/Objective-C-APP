//
//  NetworkManager.m
//  Tracker
//
//  Created by jin xm on 2025/1/16.
//

#import "NetworkManager.h"
#import "LoginViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface NetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, strong) NSString *baseURL;

@end

@implementation NetworkManager

+ (instancetype)sharedManager {
    static NetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        // 默认超时时间
        [_sessionManager.requestSerializer setTimeoutInterval:30];
    }
    return self;
}

- (void)setBaseURL:(NSString *)baseURL {
    _baseURL = baseURL;
    _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    [self.sessionManager.requestSerializer setTimeoutInterval:timeoutInterval];
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (void)setJWTToken:(NSString *)token {
    if (token) {
        [self.sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", token] forHTTPHeaderField:@"Authorization"];
    } else {
        [self.sessionManager.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
    }
}

- (void)getRequestWithURL:(NSString *)urlString
               parameters:(NSDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure {
    NSString *fullURL = self.baseURL ? [self.baseURL stringByAppendingString:urlString] : urlString;
    
    NSLog(@"get 请求的 URL：%@", fullURL);

    [self.sessionManager GET:fullURL
                  parameters:parameters
                     headers:nil
                    progress:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         if (success) {
                             success(responseObject);
                         }
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         [self handleFailure:task error:error failure:failure];
                     }];
}

- (void)postRequestWithURL:(NSString *)urlString
                parameters:(NSDictionary *)parameters
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure {
    NSString *fullURL = self.baseURL ? [self.baseURL stringByAppendingString:urlString] : urlString;
    
    NSLog(@"post 请求的 URL：%@", fullURL);
    [self.sessionManager POST:fullURL
                   parameters:parameters
                      headers:nil
                     progress:nil
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          if (success) {
                              success(responseObject);
                          }
                      }
                      failure:^(NSURLSessionDataTask *task, NSError *error) {
                          [self handleFailure:task error:error failure:failure];
                      }];
}

- (void)putRequestWithURL:(NSString *)urlString
               parameters:(NSDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure {
    NSString *fullURL = self.baseURL ? [self.baseURL stringByAppendingString:urlString] : urlString;
    
    [self.sessionManager PUT:fullURL
                  parameters:parameters
                     headers:nil
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         if (success) {
                             success(responseObject);
                         }
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         [self handleFailure:task error:error failure:failure];
                     }];
}

- (void)deleteRequestWithURL:(NSString *)urlString
                  parameters:(NSDictionary *)parameters
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure {
    NSString *fullURL = self.baseURL ? [self.baseURL stringByAppendingString:urlString] : urlString;
    
    [self.sessionManager DELETE:fullURL
                     parameters:parameters
                        headers:nil
                        success:^(NSURLSessionDataTask *task, id responseObject) {
                            if (success) {
                                success(responseObject);
                            }
                        }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            [self handleFailure:task error:error failure:failure];
                        }];
}

- (void)handleFailure:(NSURLSessionDataTask *)task error:(NSError *)error failure:(void (^)(NSError *error))failure {
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    if (response.statusCode == 401) {
        // Token 失效，清除本地 Token
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"JWTAuthToken"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // 跳转到登录页面
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *loginVC = [[LoginViewController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
        });
    } else {
        if (failure) {
            failure(error);
        }
    }
}

@end
