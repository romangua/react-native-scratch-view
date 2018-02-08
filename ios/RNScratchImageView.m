#import "RNScratchImageView.h"
#import "MDScratchImageView.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>
#import "UIView+React.h"

@interface RNScratchImageView () <MDScratchImageViewDelegate>

@property (nonatomic, copy) RCTBubblingEventBlock onRevealPercentChanged;
@property (nonatomic, copy) RCTBubblingEventBlock onRevealed;
@property (nonatomic) CGSize viewSize;


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

- (void)reactSetFrame:(CGRect)frame
{
    [super reactSetFrame: frame];
    _viewSize = frame.size;
    [self reloadView];
}

-(void)reloadView {
    NSURL *urlScratched = [NSURL URLWithString:_imageScratchedName];
    NSData *dataScratched = [NSData dataWithContentsOfURL:urlScratched];
    UIImage *imageResize = [self scaleImage:[UIImage imageWithData:dataScratched] toSize:_viewSize];
    
    _imageScratched = [[UIImageView alloc] initWithImage:imageResize];
    
    NSURL *urlPattern = [NSURL URLWithString:_imagePatternName];
    NSData *dataPattern = [NSData dataWithContentsOfURL:urlPattern];
    _imagePattern = [self scaleImage:[UIImage imageWithData:dataPattern] toSize:_viewSize];
    
    _scratchImageView = [[MDScratchImageView alloc] initWithFrame:_imageScratched.frame];
    _scratchImageView.delegate = self;
    
    [_scratchImageView setImage:_imagePattern radius:[_strokeWidth intValue]];
    _scratchImageView.image = _imagePattern;
    
    [self addSubview:_imageScratched];
    [self addSubview:_scratchImageView];
}

- (void)setStrokeWidth:(NSNumber*)strokeWidth {
    _strokeWidth = strokeWidth;
}

- (void)setImageScratched:(NSDictionary*)imageScratched {
    _imageScratchedName = imageScratched[@"uri"];
}

- (void)setImagePattern:(NSDictionary*)imagePattern {
    _imagePatternName = imagePattern[@"uri"];
}

#pragma mark - MDScratchImageViewDelegate

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress{
    if (maskingProgress >= 0.99) {
        self.onRevealed(@{});
        return;
    }
    
    self.onRevealPercentChanged(@{@"value": @(maskingProgress*100)});
}

- (UIImage *)scaleImage:(UIImage *)originalImage toSize:(CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    
    if (originalImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM(context, -M_PI_2);
        CGContextTranslateCTM(context, -size.height, 0.0f);
        CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), originalImage.CGImage);
    } else {
        CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), originalImage.CGImage);
    }
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(context);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIImage *image = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    
    return image;
}

@end
