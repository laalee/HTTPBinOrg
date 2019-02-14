//
//  HTTPBinView.h
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/2/13.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HTTPBinView;

NS_ASSUME_NONNULL_BEGIN

@protocol HTTPBinViewDelegate <NSObject>
- (void)executeOperation;
@end

@interface HTTPBinView : UIView
@property (weak, nonatomic) id <HTTPBinViewDelegate> delegate;
@property UIImageView *imageView;
- (void)updateStatusWithPercent:(NSInteger)percent;
- (void)updateStatusWithError:(NSError*)error;
@end

NS_ASSUME_NONNULL_END
