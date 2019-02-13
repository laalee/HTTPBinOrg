//
//  HTTPBinView.m
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/2/13.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "HTTPBinView.h"

#define StatusViewWidth 200

@interface HTTPBinView ()
{
    UIButton *fetchButton;
    UIView *borderView;
    UIView *statusView;
    UILabel *percentLabel;
    NSLayoutConstraint *statusViewWidthConstraint;
}
@end

@implementation HTTPBinView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupHTTPBinView];
    }
    return self;
}

- (void)setupHTTPBinView {
    [self setupImageView];
    [self setupFetchButton];
    [self setupPercentLabel];
    [self setupBorderView];
    [self setupStatusView];
}

- (void)setupImageView {
    
    self.imageView = [UIImageView new];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.imageView];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [self addConstraint:widthConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    [self addConstraint:heightConstraint];
    
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraint:verticalConstraint];
    
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.5 constant:0];
    [self addConstraint:horizontalConstraint];
}

- (void)setupFetchButton {
    
    fetchButton = [UIButton new];
    
    fetchButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:fetchButton];
    
    [fetchButton setTitle:@"Fetch Data" forState:UIControlStateNormal];
    
    [fetchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fetchButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
    [fetchButton.layer setBackgroundColor:[UIColor lightGrayColor].CGColor];
    [fetchButton.layer setCornerRadius:10.0];
    [fetchButton.layer setShadowOffset:CGSizeMake(3, 3)];
    [fetchButton.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [fetchButton.layer setShadowOpacity:0.5];
    
    [fetchButton addTarget:self action:@selector(executeOperation) forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:fetchButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:150];
    [self addConstraint:widthConstraint];
    
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:fetchButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraint:verticalConstraint];
    
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:fetchButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self addConstraint:horizontalConstraint];
}

- (void)setupPercentLabel {
    
    percentLabel = [UILabel new];
    
    percentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:percentLabel];
    
    [percentLabel setText:@"0"];
    
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:percentLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraint:verticalConstraint];
    
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:percentLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:70];
    [self addConstraint:horizontalConstraint];
}

- (void)setupBorderView
{
    borderView = [[UIView alloc] init];
    
    borderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:borderView];
    
    borderView.layer.borderColor = [UIColor blackColor].CGColor;
    borderView.layer.borderWidth = 3.0f;
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:StatusViewWidth];
    [self addConstraint:widthConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    [self addConstraint:heightConstraint];
    
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self addConstraint:verticalConstraint];
    
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:borderView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:100];
    [self addConstraint:horizontalConstraint];
}

- (void)setupStatusView
{
    statusView = [[UIView alloc] init];
    
    statusView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:statusView];
    
    [statusView setBackgroundColor:[UIColor darkGrayColor]];
    
    statusViewWidthConstraint = [NSLayoutConstraint constraintWithItem:statusView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
    [self addConstraint:statusViewWidthConstraint];
    
    NSLayoutConstraint *statusViewHeightConstraint = [NSLayoutConstraint constraintWithItem:statusView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:borderView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self addConstraint:statusViewHeightConstraint];
    
    NSLayoutConstraint *statusViewLeftConstraint = [NSLayoutConstraint constraintWithItem:statusView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:borderView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    [self addConstraint:statusViewLeftConstraint];
    
    NSLayoutConstraint *statusViewHorizontalConstraint = [NSLayoutConstraint constraintWithItem:statusView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:borderView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self addConstraint:statusViewHorizontalConstraint];
}

- (void)executeOperation
{
    [self.delegate executeOperation];
    
    [percentLabel setText:@"0"];
    
    statusViewWidthConstraint.constant = 0;
    
    [self layoutIfNeeded];
    
    self.imageView.image = nil;
}

- (void)updateStatusWithPercent:(NSString*)percent
{
    [percentLabel setText:percent];
    CGFloat widthPercent = [percent integerValue] / 100.0;
    
    statusViewWidthConstraint.constant = StatusViewWidth * widthPercent;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)updateStatusWithError:(NSString*)error
{
    [percentLabel setText:error];
}

@end
