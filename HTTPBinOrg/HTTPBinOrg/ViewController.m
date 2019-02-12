//
//  ViewController.m
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/1/30.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "ViewController.h"
#import "HTTPBinOrg.h"
#import "HTTPBinManager.h"

#define StatusViewWidth 200

@interface ViewController ()
{
    UILabel *percentLabel;
    UIView *statusView;
}
@property HTTPBinOrg *httpBinOrg;
@property UIStackView *stackView;
@property UIImageView *imageView;
@property NSLayoutConstraint *statusViewWidthConstraint;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupFetchButton];
    
    [self setupStatusView];
    [self setupStatusLabel];
}

- (void)setupImage {
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.imageView];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    [self.view addConstraint:widthConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:verticalConstraint];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.stackView.arrangedSubviews[2] attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.view addConstraint:topConstraint];
}

- (void)setupFetchButton {
    
    UIButton *button = [[UIButton alloc] init];
    
    button.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:button];
    
    [button setTitle:@"Fetch Data" forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [button.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [button.layer setCornerRadius:10.0];
    [button.layer setShadowOffset:CGSizeMake(3, 3)];
    [button.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [button.layer setShadowOpacity:0.5];
    
    [button addTarget:self action:@selector(executeOperation) forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
    [self.view addConstraint:widthConstraint];

    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:verticalConstraint];
    
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:horizontalConstraint];
}

- (void)setupStatusView
{
    UIView *borderView = [[UIView alloc] init];
    
    borderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:borderView];
    
    borderView.layer.borderColor = [UIColor blackColor].CGColor;
    borderView.layer.borderWidth = 3.0f;
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:StatusViewWidth];
    [self.view addConstraint:widthConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:verticalConstraint];
    
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:100];
    [self.view addConstraint:horizontalConstraint];
    
    statusView = [[UIView alloc] init];
    
    statusView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:statusView];
    
    [statusView setBackgroundColor:[UIColor darkGrayColor]];
    
    self.statusViewWidthConstraint = [NSLayoutConstraint constraintWithItem:statusView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
    [self.view addConstraint:self.statusViewWidthConstraint];
    
    NSLayoutConstraint *statusViewHeightConstraint = [NSLayoutConstraint constraintWithItem:statusView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:borderView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.view addConstraint:statusViewHeightConstraint];
    
    NSLayoutConstraint *statusViewLeftConstraint = [NSLayoutConstraint constraintWithItem:statusView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:borderView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    [self.view addConstraint:statusViewLeftConstraint];
    
    NSLayoutConstraint *statusViewHorizontalConstraint = [NSLayoutConstraint constraintWithItem:statusView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:borderView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:statusViewHorizontalConstraint];
}

- (void)setupStatusLabel {
    
    percentLabel = [[UILabel alloc] init];
    
    percentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:percentLabel];
    
    [percentLabel setText:@"0"];
    
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:percentLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:verticalConstraint];
    
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:percentLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:70];
    [self.view addConstraint:horizontalConstraint];
}

- (void)executeOperation
{
    [HTTPBinManager.sharedInstance executeOperation];
    HTTPBinManager.sharedInstance.delegate = self;
}

- (void)manager:(nonnull HTTPBinManager *)manager didChangeStatusWithPercent:(nonnull NSString *)percent
{
    CGFloat widthPercent = [percent integerValue] / 100.0;

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->percentLabel setText:percent];
        
        self.statusViewWidthConstraint.constant = StatusViewWidth * widthPercent;
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    });
}

- (void)manager:(nonnull HTTPBinManager *)manager didCancelWithError:(nonnull NSString *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self->percentLabel setText:@"0"];
        
        self.statusViewWidthConstraint.constant = 0;
        
        [self.view layoutIfNeeded];
    });
}

@end
