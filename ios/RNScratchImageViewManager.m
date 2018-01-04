#import "RNScratchImageViewManagerController.h"
#import "MDScratchImageView.h"
#import "RNScratchImageViewManager.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>

/*@interface RNScratchImageViewManagerController () <MDScratchImageViewDelegate>
 @end
 */
@implementation RNScratchImageViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    UIImage *image = [UIImage imageNamed:@"scratched_image"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    UIImage *bluredImage = [UIImage imageNamed:@"scratch_pattern"];
    
    MDScratchImageView *scratchImageView = [[MDScratchImageView alloc] init];
    scratchImageView.delegate = self;
    scratchImageView.image = bluredImage;
    
    return [self.view addSubview:scratchImageView];
}

#pragma mark - MDScratchImageViewDelegate

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress {
    NSLog(@"%s %p progress == %.2f", __PRETTY_FUNCTION__, scratchImageView, maskingProgress);
}

@end
