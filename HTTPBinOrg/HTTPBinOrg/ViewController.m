//
//  ViewController.m
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/1/30.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "ViewController.h"
#import "HTTPBinManager.h"

@interface ViewController ()
@property HTTPBinView *httpBinView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHttpBinView];
}

- (void)setupHttpBinView
{
    self.httpBinView = [HTTPBinView new];
    self.httpBinView.delegate = self;
    self.httpBinView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.httpBinView];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.httpBinView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    [self.view addConstraint:topConstraint];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.httpBinView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraint:bottomConstraint];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.httpBinView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    [self.view addConstraint:leadingConstraint];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.httpBinView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    [self.view addConstraint:trailingConstraint];
}

#pragma mark - HTTPBinManagerDelegate

- (void)manager:(nonnull HTTPBinManager *)manager didChangeStatusWithPercent:(nonnull NSString *)percent
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.httpBinView updateStatusWithPercent:percent];
    });
}

- (void)manager:(nonnull HTTPBinManager *)manager didCancelWithError:(nonnull NSString *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.httpBinView updateStatusWithError:error];
    });
}

- (void)manager:(nonnull HTTPBinManager *)manager didGetImage:(nonnull UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.httpBinView.imageView setImage:image];
    });
}

#pragma mark - HTTPBinViewDelegate

- (void)executeOperation
{
    [HTTPBinManager.sharedInstance executeOperation];
    HTTPBinManager.sharedInstance.delegate = self;
}

@end
