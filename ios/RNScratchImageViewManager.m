#import "MDScratchImageView.h"
#import "RNScratchImageViewManager.h"
#import "RNScratchImageView.h"


@implementation RNScratchImageViewManager

RCT_EXPORT_MODULE()

RCT_EXPORT_VIEW_PROPERTY(strokeWidth, NSNumber*)
RCT_EXPORT_VIEW_PROPERTY(imageScratched, NSDictionary*)
RCT_EXPORT_VIEW_PROPERTY(imagePattern, NSDictionary*)
RCT_EXPORT_VIEW_PROPERTY(revealPercent, NSNumber*)

RCT_EXPORT_VIEW_PROPERTY(onRevealPercentChanged, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onRevealed, RCTBubblingEventBlock)

- (UIView *)view
{
    RNScratchImageView *view = [[RNScratchImageView alloc] init];
    view.clipsToBounds = YES;
    return view;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}


@end
