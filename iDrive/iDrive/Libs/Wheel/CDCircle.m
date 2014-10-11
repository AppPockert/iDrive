/*
   Copyright (C) <2012> <Wojciech Czelalski/CzekalskiDev>

   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
#define degreesToRadians(x) (M_PI * (x) / 180.0)
#define kRotationDegrees 90
#import "CDCircle.h"
#import <QuartzCore/QuartzCore.h>
#import "CDCircleGestureRecognizer.h"
#import "CDCircleThumb.h"
#import "CDCircleOverlayView.h"
#import "CDTouchUpGestureRecognizer.h"
#import "UIImage+ColorAtPixel.h"

@implementation CDCircle
@synthesize circle, recognizer, path, numberOfSegments, separatorStyle, overlayView, separatorColor, ringWidth, circleColor, thumbs, overlay;
@synthesize delegate, dataSource;
@synthesize inertiaeffect;
//Need to add property "NSInteger numberOfThumbs" and add this property to initializer definition, and property "CGFloat ringWidth equal to circle radius - path radius.

//Circle radius is equal to rect / 2 , path radius is equal to rect1/2.

- (id)initWithFrame:(CGRect)frame numberOfSegments:(NSInteger)nSegments ringWidth:(CGFloat)width {
	self = [super initWithFrame:frame];

	if (self) {
		self.inertiaeffect = YES;
		self.recognizer = [[CDCircleGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[self addGestureRecognizer:self.recognizer];
		self.opaque = NO;
		self.numberOfSegments = nSegments;
		self.separatorStyle = CDCircleThumbsSeparatorBasic;
		self.ringWidth = width;
		self.circleColor = [UIColor clearColor];

		CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(frame) - (2 * ringWidth), CGRectGetWidth(frame) - (2 * ringWidth));
		self.thumbs = [NSMutableArray array];
		for (int i = 0; i < self.numberOfSegments; i++) {
			CDCircleThumb *thumb = [[CDCircleThumb alloc] initWithShortCircleRadius:rect1.size.height / 2 longRadius:frame.size.height / 2 numberOfSegments:self.numberOfSegments];
			[self.thumbs addObject:thumb];
		}
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextSaveGState(ctx);
	CGContextSetBlendMode(ctx, kCGBlendModeCopy);

	[self.circleColor setFill];
	circle = [UIBezierPath bezierPathWithOvalInRect:rect];
	[circle closePath];
	[circle fill];


	CGRect rect1 = CGRectMake(0, 0, CGRectGetHeight(rect) - (2 * ringWidth), CGRectGetWidth(rect) - (2 * ringWidth));
	rect1.origin.x = rect.size.width / 2  - rect1.size.width / 2;
	rect1.origin.y = rect.size.height / 2  - rect1.size.height / 2;


	path = [UIBezierPath bezierPathWithOvalInRect:rect1];
	[self.circleColor setFill];
	[path fill];
	CGContextRestoreGState(ctx);


	//Drawing Thumbs
	CGFloat fNumberOfSegments = self.numberOfSegments;
	CGFloat perSectionDegrees = 360.f / fNumberOfSegments;
	CGFloat totalRotation = 360.f / fNumberOfSegments;
	CGPoint centerPoint = CGPointMake(rect.size.width / 2, rect.size.height / 2);


	CGFloat deltaAngle = 0.f;

	for (int i = 0; i < self.numberOfSegments; i++) {
		CDCircleThumb *thumb = [self.thumbs objectAtIndex:i];
		thumb.tag = i;

		UIImage *image = [self.dataSource circle:self iconForThumbAtRow:thumb.tag];
		thumb.iconView.image = image;

		CGFloat radius = rect1.size.height / 2 + ((rect.size.height / 2 - rect1.size.height / 2) / 2) - thumb.yydifference;
		CGFloat x = centerPoint.x + (radius * cos(degreesToRadians(perSectionDegrees)));
		CGFloat yi = centerPoint.y + (radius * sin(degreesToRadians(perSectionDegrees)));



		[thumb setTransform:CGAffineTransformMakeRotation(degreesToRadians((perSectionDegrees + kRotationDegrees)))];
		if (i == 0) {
			deltaAngle = degreesToRadians(360 - kRotationDegrees) + atan2(thumb.transform.a, thumb.transform.b);
			[thumb.iconView setIsSelected:YES];
			self.recognizer.currentThumb = thumb;
		}


		//set position of the thumb
		thumb.layer.position = CGPointMake(x, yi);

		perSectionDegrees += totalRotation;

		[self addSubview:thumb];
	}

	[self setTransform:CGAffineTransformRotate(self.transform, deltaAngle)];
}

- (void)tapped:(CDCircleGestureRecognizer *)arecognizer {
	if (arecognizer.ended == NO) {
		CGPoint point = [arecognizer locationInView:self];
		if ([path containsPoint:point] == NO) {
			[self setTransform:CGAffineTransformRotate([self transform], [arecognizer rotation])];
		}
	}
}

#pragma - SingleTapGestureRecognizer

- (void)setSingleTapEnabled:(BOOL)singleTapEnabled {
	_singleTapEnabled = singleTapEnabled;

	if (singleTapEnabled) {
		_singleTapRecoginzer = [[CDTouchUpGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
		[self addGestureRecognizer:_singleTapRecoginzer];
	}
	else {
		[self removeGestureRecognizer:_singleTapRecoginzer];
		_singleTapRecoginzer = nil;
	}
}

- (void)singleTapped:(CDTouchUpGestureRecognizer *)touchUpRecoginzer {
	CGPoint touchPoint = [touchUpRecoginzer locationInView:self];
	CDCircleThumb *touchedThumb;
	for (CDCircleThumb *thumb in[self thumbs]) {
		if (CGRectContainsPoint(thumb.frame, touchPoint)) {
			CGPoint pointInTuhmb = [touchUpRecoginzer locationInView:thumb];
			if ([self isAlphaVisibleAtPoint:pointInTuhmb forThumb:thumb]) {
				NSLog(@"Thumb %i tapped, current thumb %i", thumb.tag, self.recognizer.currentThumb.tag);
				touchedThumb = thumb;
				break;
			}
		}
	}

	if (touchedThumb) {
		[self rotateTo:touchedThumb];
	}
}

- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point forThumb:(CDCircleThumb *)thumb {
	CGSize iSize = thumb.iconView.image.size;
	CGSize bSize = thumb.iconView.bounds.size;
	point.x *= (bSize.width != 0) ? (iSize.width / bSize.width) : 1;
	point.y *= (bSize.height != 0) ? (iSize.height / bSize.height) : 1;

	CGColorRef pixelColor = [[thumb.iconView.image colorAtPixel:point] CGColor];
	CGFloat alpha = CGColorGetAlpha(pixelColor);
	return alpha >= 0.1f;
}

- (void)rotateTo:(CDCircleThumb *)thumb {
	if (self.recognizer.currentThumb.tag == thumb.tag) {
		return;
	}

	float rotation;
	int direction;
	if (self.recognizer.currentThumb.tag < thumb.tag) {
		direction = ABS(self.recognizer.currentThumb.tag - thumb.tag) >= self.numberOfSegments / 2.f ? 1 : -1;
	}
	else {
		direction = ABS(self.recognizer.currentThumb.tag - thumb.tag) >= self.numberOfSegments / 2.f ? -1 : 1;
	}

	int different = MIN(ABS(self.recognizer.currentThumb.tag - thumb.tag), ABS(self.recognizer.currentThumb.tag - thumb.tag + self.numberOfSegments));
	rotation = direction * different * (360.f / self.numberOfSegments);

	[UIView animateWithDuration:0.25f animations: ^{
	    [self setTransform:CGAffineTransformRotate([self transform], degreesToRadians(rotation))];
	} completion: ^(BOOL finished) {
	    self.recognizer.currentThumb = thumb;
	    [self.delegate circle:self didMoveToSegment:thumb.tag thumb:thumb];
	}];
}

@end
