//
//  NetworkManager.h
//  Tracker
//
//  Created by jin xm on 2025/1/16.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject

+ (instancetype)sharedManager;

- (void)setBaseURL:(NSString *)baseURL;
- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval;
- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
- (void)setJWTToken:(NSString *)token;

- (void)getRequestWithURL:(NSString *)urlString
               parameters:(NSDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

- (void)postRequestWithURL:(NSString *)urlString
                parameters:(NSDictionary *)parameters
                   success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure;

- (void)putRequestWithURL:(NSString *)urlString
               parameters:(NSDictionary *)parameters
                  success:(void (^)(id responseObject))success
                  failure:(void (^)(NSError *error))failure;

- (void)deleteRequestWithURL:(NSString *)urlString
                  parameters:(NSDictionary *)parameters
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure;

@end
