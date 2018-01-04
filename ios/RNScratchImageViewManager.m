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
    UIImage *image = [UIImage imageNamed:@"paint01-01.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    UIImage *bluredImage = [UIImage imageNamed:@"paint01-01blur.png"];
    
    MDScratchImageView *scratchImageView = [[MDScratchImageView alloc] initWithFrame:imageView.frame];
    scratchImageView.delegate = self;
    scratchImageView.image = bluredImage;
    
    [self.view addSubview:imageView];
    [self.view addSubview:scratchImageView];
    
    return self;
}

#pragma mark - MDScratchImageViewDelegate

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress {
    NSLog(@"%s %p progress == %.2f", __PRETTY_FUNCTION__, scratchImageView, maskingProgress);
}

@end
