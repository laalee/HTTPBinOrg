//
//  HTTPBinManager.h
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/2/12.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPBinManagerOperation.h"

@class HTTPBinManager;

NS_ASSUME_NONNULL_BEGIN

@protocol HTTPBinManagerDelegate <NSObject>
- (void)manager:(HTTPBinManager *)manager didChangeStatusWithPercent:(NSString*)percent;
- (void)manager:(HTTPBinManager *)manager didCancelWithError:(NSString*)error;
@end

@interface HTTPBinManager : NSObject <HTTPBinOperationDelegate>

@property (nonatomic, strong) NSOperationQueue *queue;
@property (strong, nonatomic) id <HTTPBinManagerDelegate> delegate;

+ (instancetype) sharedInstance;
- (void)executeOperation;

@end

NS_ASSUME_NONNULL_END
