//
//  HTTPBinManagerOperation.h
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/2/12.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HTTPBinManagerOperation;

NS_ASSUME_NONNULL_BEGIN

@protocol HTTPBinOperationDelegate <NSObject>
- (void)operation:(HTTPBinManagerOperation *)operation didChangeStatusWithPercent:(NSString*)percent;
- (void)operation:(HTTPBinManagerOperation *)operation didCancelWithError:(NSString*)error;
@end

@interface HTTPBinManagerOperation : NSOperation
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (weak, nonatomic) id <HTTPBinOperationDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
