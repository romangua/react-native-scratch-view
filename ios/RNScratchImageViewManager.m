#import <React/RCTViewManager.h>
#import "MDScratchImageView.h"
#import "RNScratchImageView"

@interface RNScratchImageViewManager : RCTViewManager <MDScratchImageViewDelegate>

@end

@implementation RNScratchImageViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    return [[RNScratchImageView alloc] init];
}

#pragma mark - MDScratchImageViewDelegate

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress {
    NSLog(@"%s %p progress == %.2f", __PRETTY_FUNCTION__, scratchImageView, maskingProgress);
}

@end
