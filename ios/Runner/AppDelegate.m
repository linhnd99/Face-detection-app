#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "MobileFaceNet.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];

    [self LoadModel];

  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void) LoadModel
{
    MobileFaceNet *mobileFaceNet = [[MobileFaceNet alloc] init];
    
    UIImage *image1 = [UIImage imageNamed:@"image2.png"];
    UIImage *image2 = [UIImage imageNamed:@"image1.png"];
    
//    CGDataProviderRef provider = CGImageGetDataProvider(image1.CGImage);
//    NSData* data = (id)CFBridgingRelease(CGDataProviderCopyData(provider));
//    NSLog(@"data image 1: %@",data);
//
//    provider = CGImageGetDataProvider(image2.CGImage);
//    data=(id)CFBridgingRelease(CGDataProviderCopyData(provider));
//    NSLog(@"data image 2: %@",data);
    
    
    float res = [mobileFaceNet compare:image1 with:image2];
    NSLog(@"res: %f",res);
}

@end
