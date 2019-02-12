//
//  HTTPBinOrgTests.m
//  HTTPBinOrgTests
//
//  Created by Annie Lee on 2019/1/30.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HTTPBinOrg.h"

@interface HTTPBinOrgTests : XCTestCase

@end

@implementation HTTPBinOrgTests

- (void)testFetchGetResponseInTime {
    
    HTTPBinOrg *httpBinOrg = [[HTTPBinOrg alloc] init];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"FetchGetResponseInTime"];
    
    NSString *url = @"https://httpbin.org/get";
    
    [httpBinOrg fetchGetResponseWithCallback:^(NSDictionary * _Nonnull dict, NSError * _Nonnull error) {
        
        NSString *dictUrl = dict[@"url"];
        
        XCTAssert([url isEqualToString:dictUrl]);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testPostCustomerNameInTime {
    
    HTTPBinOrg *httpBinOrg = [[HTTPBinOrg alloc] init];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"PostCustomerNameInTime"];
    
    NSString *customerName = @"AnnieTest";
    
    [httpBinOrg postCustomerName:customerName callback:^(NSDictionary * _Nonnull dict, NSError * _Nonnull error) {
        
        NSDictionary *dictFrom = dict[@"form"];
        NSString *callbackName = dictFrom[@"custname"];

        XCTAssert([customerName isEqualToString:callbackName]);
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)testFetchImageInTime {
    
    HTTPBinOrg *httpBinOrg = [[HTTPBinOrg alloc] init];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"FetchImageInTime"];
    
    [httpBinOrg fetchImageWithCallback:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
        
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

@end
