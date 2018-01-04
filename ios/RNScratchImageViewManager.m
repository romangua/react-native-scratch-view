#import "MDScratchImageView.h"
#import "RNScratchImageViewManager.h"
#import "RNScratchImageView.h"


@implementation RNScratchImageViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    return [[RNScratchImageView alloc] init];
}

@end
