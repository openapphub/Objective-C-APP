//
//  BaseViewController.h
//  Tracker
//
//  Created by jin xm on 2025/1/14.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
// 网络请求基础方法
- (void)requestWithURL:(NSString *)urlString
              params:(NSDictionary *)params
             success:(void(^)(id response))success
             failure:(void(^)(NSError *error))failure;
@end

