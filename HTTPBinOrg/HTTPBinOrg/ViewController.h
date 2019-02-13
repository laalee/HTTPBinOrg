//
//  ViewController.h
//  HTTPBinOrg
//
//  Created by Annie Lee on 2019/1/30.
//  Copyright © 2019 Annie Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPBinManager.h"
#import "HTTPBinView.h"

@interface ViewController : UIViewController <HTTPBinManagerDelegate, HTTPBinViewDelegate>

@end

