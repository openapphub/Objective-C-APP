//
//  BaseViewController.m
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import "BaseViewController.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)requestWithURL:(NSString *)urlString
              params:(NSDictionary *)params
             success:(void(^)(id response))success
             failure:(void(^)(NSError *error))failure {
    // 使用NSURLSession发起网络请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    // 设置请求体
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params
                                                     options:0
                                                       error:&error];
    if (!jsonData) {
        if (failure) {
            failure(error);
        }
        return;
    }
    
    [request setHTTPBody:jsonData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                          completionHandler:^(NSData *data,
                                                            NSURLResponse *response,
                                                            NSError *error) {
        if (error) {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(error);
                });
            }
            return;
        }
        
        NSError *jsonError;
        id jsonResponse = [NSJSONSerialization JSONObjectWithData:data
                                                        options:0
                                                          error:&jsonError];
        if (jsonError) {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(jsonError);
                });
            }
            return;
        }
        
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(jsonResponse);
            });
        }
    }];
    
    [task resume];
}

@end
