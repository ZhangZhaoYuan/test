//
//  HttpServerce.h
//  MW
//
// 2018/8/28.
//
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface HttpServerce : NSObject
@property (nonatomic, strong) AFHTTPSessionManager *manager;
+(HttpServerce *)instance;
-(void)sendHttpGetMethod:(NSString *) urlString andParameters:(NSDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack;
-(void)sendHttpPostMethod:(NSString *) urlString andParameters:(NSDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack;
@end
