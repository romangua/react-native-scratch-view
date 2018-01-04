#import "RNScratchImageViewManagerController.h"
#import "MDScratchImageView.h"
#import "RNScratchImageViewManager.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>


@implementation RNScratchImageViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scratch_image.png"]];
    UIImage *bluredImage = [UIImage imageNamed:@"scratch_pattern.png"];
    
    MDScratchImageView *scratchImageView = [[MDScratchImageView alloc] initWithFrame:imageView.frame];
    scratchImageView.delegate = self;
    scratchImageView.image = bluredImage;
    
    [self.view addSubview:imageView];
    [self.view addSubview:scratchImageView];
    
    return self.view;
}

#pragma mark - MDScratchImageViewDelegate

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress {
    NSLog(@"%s %p progress == %.2f", __PRETTY_FUNCTION__, scratchImageView, maskingProgress);
}

@end
