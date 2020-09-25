//
//  MobileFaceNet.h
//  Runner
//
//  Created by linhnd99hit on 9/24/20.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

static float mfn_threshold = 0.8f;

NS_ASSUME_NONNULL_BEGIN

@interface MobileFaceNet : NSObject

- (float)compare:(UIImage *)image1 with:(UIImage *)image2;

@end
NS_ASSUME_NONNULL_END
