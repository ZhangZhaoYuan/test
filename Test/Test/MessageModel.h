//
//  MessageModel.h
//  Test
//
//  Created by xinxin on 2020/4/12.
//  Copyright © 2020 PM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageModel : NSObject
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *creationTime;
@end

NS_ASSUME_NONNULL_END
