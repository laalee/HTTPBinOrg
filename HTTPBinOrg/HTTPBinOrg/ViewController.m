//
//  ViewController.m
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/1/30.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import "ViewController.h"
#import "HTTPBinOrg.h"

@interface ViewController ()
@property HTTPBinOrg *httpBinOrg;
@property UIStackView *stackView;
@property UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupButtons];
    
    [self setupImage];
    
    self.httpBinOrg = [[HTTPBinOrg alloc] init];
}

- (void)fetchGetResponseWithCallback {
    
    [self.httpBinOrg fetchGetResponseWithCallback:^(NSDictionary * _Nonnull dict, NSError * _Nonnull error) {
        
        NSLog(@"ViewController.fetchGetResponseWithCallback, dict = %@", dict);
    }];
}

- (void)postCustomerName {
    
    NSString *customerName = @"Annie";
    
    [self.httpBinOrg postCustomerName:customerName callback:^(NSDictionary * _Nonnull dict, NSError * _Nonnull error) {
        
        NSLog(@"ViewController.postCustomerName, dict = %@", dict);
    }];
}

- (void)fetchImageWithCallback {
    
    __weak ViewController *weakSelf = self;
    
    [self.httpBinOrg fetchImageWithCallback:^(UIImage * _Nonnull image, NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.imageView setImage:image];
        });
        
        NSLog(@"ViewController.fetchImageWithCallback");
    }];
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

- (void)setupButtons {
    
    self.stackView = [[UIStackView alloc] init];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    self.stackView.spacing = 10;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.stackView];
    
    NSArray *buttonTitle = [[NSArray alloc] initWithObjects:@"Get", @"Post customer name", @"Fetch image", nil];

    NSArray *buttonSelector = [[NSArray alloc] initWithObjects:@"fetchGetResponseWithCallback", @"postCustomerName", @"fetchImageWithCallback", nil];
    
    for (int i = 0; i < [buttonTitle count]; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self.stackView addArrangedSubview:button];

        SEL NSSelectorFromString (NSString *aSelectorName);
        [button addTarget:self action:NSSelectorFromString(buttonSelector[i]) forControlEvents:UIControlEventTouchUpInside];
    }
    
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.stackView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:300];
    [self.view addConstraint:widthConstraint];
    
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.stackView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200];
    [self.view addConstraint:heightConstraint];
    
    NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint constraintWithItem:self.stackView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    [self.view addConstraint:verticalConstraint];
    
    NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint constraintWithItem:self.stackView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [self.view addConstraint:horizontalConstraint];
}

@end
