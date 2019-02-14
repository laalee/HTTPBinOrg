//
//  HTTPBinOrg.m
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/1/30.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "HTTPBinOrg.h"

#define HTTPStatusCodeError @"HTTPStatusCodeError"
#define EmptyDataError @"EmptyDataError"
#define HTTPBinErrorDomain @"HTTPBinErrorDomain"

@implementation HTTPBinOrg

- (void)fetchGetResponseWithCallback:(void(^)(NSDictionary *, NSError *))callback {
    
    NSURL *url = [NSURL URLWithString:@"https://httpbin.org/get"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    [self HTTPBinSessionDataTaskWithRequest:request
                                 andSession:session
                                    Success:^(NSData * data) {
                                        
                                        NSError *jsonError = nil;
                                        
                                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                                        
                                        callback(dict, jsonError);
                                    }
                                    Failure:^(NSError * error) {
                                        
                                        callback(nil, error);
                                    }];
}

- (void)postCustomerName:(NSString *)name callback:(void(^)(NSDictionary *, NSError *))callback {
    
    NSURL *url = [NSURL URLWithString:@"https://httpbin.org/post"];

    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"custname=%@", name];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    [self HTTPBinSessionDataTaskWithRequest:request
                                 andSession:session
                                    Success:^(NSData * data) {
                                        
                                        NSError *jsonError = nil;
                                        
                                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                                        
                                        callback(dict, jsonError);
                                    }
                                    Failure:^(NSError * error) {
                                        
                                        callback(nil, error);
                                    }];
}

- (void)fetchImageWithCallback:(void(^)(UIImage *, NSError *))callback {
    
    NSURL *url = [NSURL URLWithString:@"https://httpbin.org/image/png"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    [self HTTPBinSessionDataTaskWithRequest:request
                                 andSession:session
                                    Success:^(NSData * data) {
                                        
                                        UIImage *image = [UIImage imageWithData:data];
                                        
                                        callback(image, nil);
                                    }
                                    Failure:^(NSError * error) {
                                        
                                        callback(nil, error);
                                    }];
}

- (void)HTTPBinSessionDataTaskWithRequest:(NSURLRequest*)request andSession:(NSURLSession*)session Success:(void(^)(NSData *))success Failure:(void(^)(NSError *))failure {
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            failure(error);
            
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        NSInteger httpStatusCode = [httpResponse statusCode];
        
        if (httpStatusCode < 200 || httpStatusCode >= 300) {
            
            NSError *statusError = [NSError errorWithDomain:HTTPBinErrorDomain
                                                       code:0
                                                   userInfo:@{NSLocalizedDescriptionKey: HTTPStatusCodeError,
                                                              @"StatusCode": [NSNumber numberWithInteger:httpStatusCode]
                                                              }];
            
            failure(statusError);
            
            return;
        }
        
        if (!data) {
            
            NSError *dataError = [NSError errorWithDomain:HTTPBinErrorDomain
                                                       code:0
                                                   userInfo:@{NSLocalizedDescriptionKey: EmptyDataError}];
            
            failure(dataError);
            
            return;
        }
        
        success(data);
    }];
    
    [sessionDataTask resume];
}

@end
