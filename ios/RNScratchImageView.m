#import <React/RCTComponent.h>

@interface RNScratchImageView : RCTView 
@end

@implementation RNScratchImageView {
    MDScratchImageView *_scratchImageView;
}

- (instancetype)init
{
    self = [super init];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scratched_image.png"]];
    //UIImage *bluredImage = [UIImage imageNamed:@"scratch_pattern.png"];
    
    _scratchImageView = [[MDScratchImageView alloc] initWithFrame:imageView.frame];
    _scratchImageView.delegate = self;
    _scratchImageView.image = bluredImage;
    
    //[self addSubview:imageView];
    [self addSubview:_scratchImageView];
    
    return self;
    
}
@end
