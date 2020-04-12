//
//  HttpServerce.m
//  MW
//
// 2018/8/28.
//
//

#import "HttpServerce.h"

@implementation HttpServerce
#pragma mark - 添加一个HttpCommService的单例方法
+(HttpServerce *)instance{
    static HttpServerce *comInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        comInstance = [[HttpServerce alloc] init];
    });
    return comInstance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        if (!self.manager) {
            self.manager = [AFHTTPSessionManager manager];
            self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
            self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
                        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html", @"text/plain", @"application/json", @"image/png", @"text/javascript", nil];
            self.manager.requestSerializer.timeoutInterval = 120;
            
        }
    }
    return self;
}

#pragma mark -添加一个GET请求的方法
-(void)sendHttpGetMethod:(NSString *) urlString andParameters:(NSDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack{
    NSString *url = urlString;
    [self.manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callBack(responseObject, YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSDictionary * dict = @{@"errmsg":error.domain,@"errcode":[NSString stringWithFormat:@"%ld",(long)error.code]};
        callBack(dict,NO);
    }];
}
#pragma mark -添加一个POST请求的方法
-(void)sendHttpPostMethod:(NSString *) urlString andParameters:(NSDictionary *) params completion:(void(^)(id objects, BOOL isSuccess))callBack{
    NSString *url = [NSString stringWithFormat:@"%@",urlString];
    [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSString *_isSuccess = nil;
        _isSuccess = [NSString stringWithFormat:@"%@",responseObject[@"Code"]];
        if ([_isSuccess isEqualToString:@"200"]) {

            callBack(responseObject, YES);
        }else{

            callBack(responseObject, NO);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSDictionary * dict = @{@"errmsg":error.domain,@"errcode":[NSString stringWithFormat:@"%ld",(long)error.code]};

        callBack(dict,NO);
    }];
    
}

@end
