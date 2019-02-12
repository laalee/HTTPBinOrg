//
//  HTTPBinManager.m
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/2/12.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "HTTPBinManager.h"
#import "HTTPBinManagerOperation.h"

@interface HTTPBinManager ()

@end

@implementation HTTPBinManager

+ (instancetype)sharedInstance
{
    static HTTPBinManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HTTPBinManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)executeOperation
{
    [self.delegate manager:self didCancelWithError:@"clear"];
    
    [self.queue cancelAllOperations];
    
    HTTPBinManagerOperation *operation = [[HTTPBinManagerOperation alloc] init];
    
    operation.delegate = self;
    
    [self.queue addOperation:operation];
}

#pragma mark - HTTPBinOperationDelegate

- (void)operation:(HTTPBinManagerOperation *)operation didChangeStatusWithPercent:(NSString*)percent
{
    [self.delegate manager:self didChangeStatusWithPercent:percent];
}

- (void)operation:(HTTPBinManagerOperation *)operation didCancelWithError:(NSString*)error
{
    [self.delegate manager:self didCancelWithError:error];
}

@end
