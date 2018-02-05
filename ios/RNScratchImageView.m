#import "RNScratchImageView.h"
#import "MDScratchImageView.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@interface RNScratchImageView () <MDScratchImageViewDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onRevealPercentChanged;
@property (nonatomic, copy) RCTBubblingEventBlock onRevealed;

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher;

@end

@implementation RNScratchImageView {
    RCTEventDispatcher *_eventDispatcher;
    MDScratchImageView *_scratchImageView;
    UIImageView *_imageScratched;
    UIImage *_imagePattern;
    
    NSString *_imageScratchedName;
    NSString *_imagePatternName;
    NSNumber *_strokeWidth;
}

- (instancetype)initWithEventDispatcher:(RCTEventDispatcher *)eventDispatcher
{
    if ((self = [super init])) {
        _eventDispatcher = eventDispatcher;
        
        // Aca se pueden setear variables por defecto
        _strokeWidth = @10;
        
    }
    return self;
}

-(void)reloadView {
    NSURL *urlScratched = [NSURL URLWithString:_imageScratchedName];
    NSData *dataScratched = [NSData dataWithContentsOfURL:urlScratched];
    _imageScratched = [[UIImageView alloc] initWithImage:[UIImage imageWithData:dataScratched]];
    
    NSURL *urlPattern = [NSURL URLWithString:_imagePatternName];
    NSData *dataPattern = [NSData dataWithContentsOfURL:urlPattern];
    _imagePattern = [UIImage imageWithData:dataPattern];
    
    _scratchImageView = [[MDScratchImageView alloc] initWithFrame:_imageScratched.frame];
    _scratchImageView.delegate = self;
    
    [_scratchImageView setImage:_imagePattern radius:[_strokeWidth intValue]];
    _scratchImageView.image = _imagePattern;
    
    [self addSubview:_imageScratched];
    [self addSubview:_scratchImageView];
}

- (void)setStrokeWidth:(NSNumber*)strokeWidth {
    _strokeWidth = strokeWidth;
    
    [self reloadView];
}

- (void)setImageScratched:(NSDictionary*)imageScratched {
    _imageScratchedName = imageScratched[@"uri"];
    
    [self reloadView];
}

- (void)setImagePattern:(NSDictionary*)imagePattern {
    _imagePatternName = imagePattern[@"uri"];
    
    [self reloadView];
}

#pragma mark - MDScratchImageViewDelegate

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress{
    if (maskingProgress >= 0.95) {
        self.onRevealed(@{});
        return;
    }
    
    self.onRevealPercentChanged(@{@"value": @(maskingProgress*100)});
}

@end
