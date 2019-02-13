//
//  HTTPBinOrg.m
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/1/30.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "HTTPBinOrg.h"

#define HTTPStatusCodeError @"HTTPStatusCodeError"
#define DataError @"DataError"

@implementation HTTPBinOrg

- (void)fetchGetResponseWithCallback:(void(^)(NSDictionary *, NSError *))callback {
    
    NSURL *url = [NSURL URLWithString:@"https://httpbin.org/get"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            callback(nil, error);
            
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        NSInteger httpStatusCode = [httpResponse statusCode];
        
        if (httpStatusCode < 200 || httpStatusCode >= 300) {
            
            callback(nil, [NSError errorWithDomain:HTTPStatusCodeError code:httpStatusCode userInfo:nil]);
            
            return;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if (!dict) {
            
            callback(nil, [NSError errorWithDomain:DataError code:0 userInfo:nil]);
            
            return;
        }
        
        callback(dict, nil);
    }];
    
    [sessionDataTask resume];
}

- (void)postCustomerName:(NSString *)name callback:(void(^)(NSDictionary *, NSError *))callback {
    
    NSURL *url = [NSURL URLWithString:@"https://httpbin.org/post"];

    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *args = [NSString stringWithFormat:@"custname=%@", name];
    request.HTTPBody = [args dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            callback(nil, error);
            
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        NSInteger httpStatusCode = [httpResponse statusCode];
        
        if (httpStatusCode < 200 || httpStatusCode >= 300) {
            
            callback(nil, [NSError errorWithDomain:HTTPStatusCodeError code:httpStatusCode userInfo:nil]);
            
            return;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if (!dict) {
            
            callback(nil, [NSError errorWithDomain:DataError code:0 userInfo:nil]);
            
            return;
        }
        
        callback(dict, nil);
    }];
    
    [sessionDataTask resume];
}

- (void)fetchImageWithCallback:(void(^)(UIImage *, NSError *))callback {
    
    NSURL *url = [NSURL URLWithString:@"https://httpbin.org/image/png"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            
            callback(nil, error);
            
            return;
        }

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        NSInteger httpStatusCode = [httpResponse statusCode];
        
        if (httpStatusCode < 200 || httpStatusCode >= 300) {
            
            callback(nil, [NSError errorWithDomain:HTTPStatusCodeError code:httpStatusCode userInfo:nil]);
            
            return;
        }

        UIImage *image = [UIImage imageWithData:data];
        
        if (!image) {
            
            callback(nil, [NSError errorWithDomain:DataError code:0 userInfo:nil]);
            
            return;
        }
        
        callback(image, nil);
    }];
    
    [sessionDataTask resume];
}

@end
