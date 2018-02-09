#import "RNScratchImageView.h"
#import "MDScratchImageView.h"
#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>
#import "UIView+React.h"

@interface RNScratchImageView () <MDScratchImageViewDelegate>
@property (nonatomic, copy) RCTBubblingEventBlock onRevealPercentChanged;
@property (nonatomic, copy) RCTBubblingEventBlock onRevealed;
@end

bool isImageScratchRevealed = false;
CGSize viewSize;
float revealPercentValue = 0.98f;
bool isUserSetRevealPercentValue = false;
int strokeWidthValue = 10;
NSString *imageScratchedValue;
NSString *imagePatternValue;

UIImageView *_imageScratched;
UIImage *_imagePattern;

@implementation RNScratchImageView {
    MDScratchImageView *_scratchImageView;
}

- (void)reactSetFrame:(CGRect)frame
{
    [super reactSetFrame: frame];
    viewSize = frame.size;
    
    [self reloadView];
}

-(void)reloadView {
    NSURL *urlScratched = [NSURL URLWithString:imageScratchedValue];
    NSData *dataScratched = [NSData dataWithContentsOfURL:urlScratched];
    UIImage *imageResize = [self scaleImage:[UIImage imageWithData:dataScratched] toSize:viewSize];
    
    _imageScratched = [[UIImageView alloc] initWithImage:imageResize];
    
    NSURL *urlPattern = [NSURL URLWithString:imagePatternValue];
    NSData *dataPattern = [NSData dataWithContentsOfURL:urlPattern];
    _imagePattern = [self scaleImage:[UIImage imageWithData:dataPattern] toSize:viewSize];
    
    _scratchImageView = [[MDScratchImageView alloc] initWithFrame:_imageScratched.frame];
    _scratchImageView.delegate = self;
    
    [_scratchImageView setImage:_imagePattern radius:strokeWidthValue];
    _scratchImageView.image = _imagePattern;
    
    [self addSubview:_imageScratched];
    [self addSubview:_scratchImageView];
}

- (void)setRevealPercent:(NSNumber*)revealPercent {
    revealPercentValue = [revealPercent floatValue] / 100;
    isUserSetRevealPercentValue = true;
}

- (void)setStrokeWidth:(NSNumber*)strokeWidth {
    strokeWidthValue = [strokeWidth intValue];
}

- (void)setImageScratched:(NSDictionary*)imageScratched {
    imageScratchedValue = imageScratched[@"uri"];
}

- (void)setImagePattern:(NSDictionary*)imagePattern {
    imagePatternValue = imagePattern[@"uri"];
}

#pragma mark - MDScratchImageViewDelegate

- (void)mdScratchImageView:(MDScratchImageView *)scratchImageView didChangeMaskingProgress:(CGFloat)maskingProgress{
    
    if (maskingProgress >= revealPercentValue && !isImageScratchRevealed) {
        isImageScratchRevealed = true;
        self.onRevealed(@{});
        
        NSString* res;
        if(isUserSetRevealPercentValue)
            res = [NSString stringWithFormat:@"%.02f", revealPercentValue*100];
        else
            res = [NSString stringWithFormat:@"%d", 100];
        
        self.onRevealPercentChanged(@{@"value": res});
        return;
    }
    
    if (!isImageScratchRevealed) {
        NSString* formattedNumber = [NSString stringWithFormat:@"%.02f", maskingProgress*100];
        self.onRevealPercentChanged(@{@"value": (formattedNumber)});
    }
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
