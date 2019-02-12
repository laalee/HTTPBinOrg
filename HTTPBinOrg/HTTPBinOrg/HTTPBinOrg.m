//
//  HTTPBinOrg.m
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/1/30.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "HTTPBinOrg.h"

@implementation HTTPBinOrg

- (void)fetchGetResponseWithCallback:(void(^)(NSDictionary *, NSError *))callback {
    
    NSURL *url = [NSURL URLWithString:@"https://httpbin.org/get"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"HTTPBinOrg.fetchGetResponseWithCallback success.");
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
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
        
        NSLog(@"HTTPBinOrg.postCustomerName success.");

        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        callback(dict, error);
    }];
    
    [sessionDataTask resume];
}

- (void)fetchImageWithCallback:(void(^)(UIImage *, NSError *))callback {
    
    NSURL *url = [NSURL URLWithString:@"https://httpbin.org/image/png"];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"HTTPBinOrg.fetchImageWithCallback success.");
        
        UIImage *image = [UIImage imageWithData:data];
        
        callback(image, error);
    }];
    
    [sessionDataTask resume];
}

@end
