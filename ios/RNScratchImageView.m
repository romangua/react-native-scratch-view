#import "RNScratchImageView.h"
#import "MDScratchImageView.h"

@interface RNScratchImageView () <MDScratchImageViewDelegate>
@end

@implementation RNScratchImageView {
    MDScratchImageView *_scratchImageView;
}

- (instancetype)init
{
    self = [super init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scratched_image.png"]];
    UIImage *bluredImage = [UIImage imageNamed:@"scratch_pattern.png"];
    
    _scratchImageView = [[MDScratchImageView alloc] initWithFrame:imageView.frame];
    _scratchImageView.delegate = self;
    
    [_scratchImageView setImage:bluredImage radius:[@"5" intValue]];
    _scratchImageView.image = bluredImage;
    
    [self addSubview:imageView];
    [self addSubview:_scratchImageView];
    
    NSLog(@"entro");
    
    
    return self;
}

#pragma mark - MDScratchImageViewDelegate

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress {
    NSLog(@"%s %p progress == %.2f", __PRETTY_FUNCTION__, scratchImageView, maskingProgress);
}

@end
