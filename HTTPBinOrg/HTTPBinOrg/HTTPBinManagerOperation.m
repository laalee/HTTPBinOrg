//
//  HTTPBinManagerOperation.m
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/2/12.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "HTTPBinManagerOperation.h"
#import "HTTPBinOrg.h"

@implementation HTTPBinManagerOperation

- (void)main {
    
    HTTPBinOrg *httpBinOrg = [[HTTPBinOrg alloc] init];
        
    // first API
    
    self.semaphore = dispatch_semaphore_create(0);
    
    [httpBinOrg fetchGetResponseWithCallback:^(NSDictionary * _Nonnull dict, NSError * _Nonnull error) {

        if(error) {
            
            [self.delegate operation:self willCancelWithError:error];
            
        } else {
            
            [self.delegate operation:self didChangeStatusWithPercent:33];
        }

        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    if (self.cancelled) {
        
        return;
    }
    
    // second API
    
    self.semaphore = dispatch_semaphore_create(0);

    NSString *customerName = @"Annie";
    
    [httpBinOrg postCustomerName:customerName callback:^(NSDictionary * _Nonnull dict, NSError * _Nonnull error) {
        
        if(error) {
            
            [self.delegate operation:self willCancelWithError:error];
            
        } else {
            
            [self.delegate operation:self didChangeStatusWithPercent:66];
        }

        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    if (self.cancelled) {
        
        return;
    }
    
    // third API
    
    self.semaphore = dispatch_semaphore_create(0);
    
    [httpBinOrg fetchImageWithCallback:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
        
        if(error) {
            
            [self.delegate operation:self willCancelWithError:error];
            
        } else {
            
            [self.delegate operation:self didChangeStatusWithPercent:100];
            
            [self.delegate operation:self updateDataWithImage:image];
        }

        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
}

- (void)cancel
{
    [super cancel];
    
    if (self.semaphore) {
        
        dispatch_semaphore_signal(self.semaphore);
    }
}

@end
