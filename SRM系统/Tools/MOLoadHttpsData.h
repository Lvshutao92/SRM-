//
//  MOLoadHttpsData.h
//  SRM系统
//
//  Created by 吕书涛 on 2018/11/8.
//  Copyright © 2018 吕书涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^SuccessBlock) (id responseObject);

typedef void (^FailedBlock) (id error);

@interface MOLoadHttpsData : NSObject
/** Post 请求 */
+(void)PostHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailedBlock)failureBlock;

/** Get 请求 */
+(void)GetHttpDataWithUrlStr:(NSString *)url Dic:(NSDictionary *)dic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailedBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END
