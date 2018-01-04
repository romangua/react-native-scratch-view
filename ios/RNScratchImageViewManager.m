#import "MDScratchImageView.h"
#import "RNScratchImageViewManager.h"
#import "RNScratchImageView.h"

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
