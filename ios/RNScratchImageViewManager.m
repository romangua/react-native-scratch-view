#import <React/RCTViewManager.h>
#import "RNScratchImageViewManagerController.h"
#import "MDScratchImageView.h"

@interface RNScratchImageViewManager : RCTViewManager
@end

@interface RNScratchImageViewManagerController () <MDScratchImageViewDelegate>
@end

@implementation RNScratchImageViewManager

RCT_EXPORT_MODULE()

- (UIView *)view
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentInset = UIEdgeInsetsMake([[UIApplication sharedApplication] statusBarFrame].size.height, 0.0f, 0.0f, 0.0f);
    scrollView.canCancelContentTouches = NO;
    scrollView.delaysContentTouches = NO;
    [self.view addSubview:scrollView];
    
    NSArray *imagesDicts = @[ @{@"sharp" : @"scratched_image.png", @"blured" : @"scratch_pattern.png"}];
    
    CGFloat step = 10.0f;
    CGFloat currentY = step;
    for (NSDictionary *dictionary in imagesDicts) {
        UIImage *sharpImage = [UIImage imageNamed:[dictionary objectForKey:@"sharp"]];
        
        CGFloat width = MIN(floorf(scrollView.bounds.size.width * 0.6f), sharpImage.size.width);
        CGFloat height = sharpImage.size.height * (width / sharpImage.size.width);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(floorf(scrollView.bounds.size.width * 0.5f - width * 0.5f), currentY, width, height)];
        imageView.image = sharpImage;
        [scrollView addSubview:imageView];
        
        UIImage *bluredImage = [UIImage imageNamed:[dictionary objectForKey:@"blured"]];
        NSString *radiusString = [dictionary objectForKey:@"radius"];
        MDScratchImageView *scratchImageView = [[MDScratchImageView alloc] initWithFrame:imageView.frame];
        scratchImageView.delegate = self;
        if (nil == radiusString) {
            scratchImageView.image = bluredImage;
        } else {
            [scratchImageView setImage:bluredImage radius:[radiusString intValue]];
            scratchImageView.image = bluredImage;
        }
        [scrollView addSubview:scratchImageView];
        
        currentY = CGRectGetMaxY(imageView.frame) + step;
    }
    scrollView.contentSize = CGSizeMake(scrollView.bounds.size.width, currentY);
    
    return scrollView;
}


@end
