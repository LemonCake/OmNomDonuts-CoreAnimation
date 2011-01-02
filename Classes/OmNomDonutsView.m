//
//  OmNomDonutsView.m
//  OmNomDonuts
//
//  Created by John Z Wu on 12/31/10.
//  Copyright 2010 TFM. All rights reserved.
//

#import "OmNomDonutsView.h"
#import "Donut.h"


@implementation OmNomDonutsView

@synthesize donutArray;
@synthesize donutTimer;
@synthesize updateTimer;

-(id)initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
	if(self) {
		[self setUp];
	}
	return self;
}

-(void)setUp{
	donutArray = [[NSMutableArray alloc] init];
	donutTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(addDonut) userInfo:nil repeats:YES];
	updateTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	// If the touch was on the donut, do stuff
	for(Donut* tapDonut in donutArray){
		if ([touch view] == tapDonut) {
			CGPoint point = [touch locationInView:self];
			CGPoint donutCenter = tapDonut.center;
			
			float xDifference = abs(point.x-donutCenter.x);
			float yDifference = abs(point.y-donutCenter.y);
			float distanceToCenter = sqrt(xDifference*xDifference+yDifference*yDifference);
			
			if(distanceToCenter <= tapDonut.frame.size.width/2) {
				NSLog(@"HIT");
				[self animateDonutPress:tapDonut];
			}
		}
	}
}

#if 0
- (void)animateDonutPress:(id)sender {
	Donut *tapDonut = (Donut *)sender; 
	[UIView animateWithDuration:1
						  delay:0
						options:UIViewAnimationCurveLinear
					 animations:^{
						 tapDonut.alpha = 0;
					 } 
					 completion:^(BOOL finished){
						 [tapDonut removeFromSuperview];
						 [donutArray removeObjectIdenticalTo:tapDonut];
					 }];

}

#else

- (void)animateDonutPress:(id)sender {
	NSLog(@"animateDonutPress");
	Donut *tapDonut = (Donut *)sender;
	CALayer *donutLayer = tapDonut.layer;
	CABasicAnimation *theAnimation;
	theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
	theAnimation.duration=1;
	theAnimation.delegate=self;
	theAnimation.repeatCount=0;
	theAnimation.autoreverses=NO;
	theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
	theAnimation.toValue=[NSNumber numberWithFloat:0.0];
	[donutLayer addAnimation:theAnimation forKey:@"animateOpacity"];
}
	

#endif

- (void)addDonut {
	
	Donut *idonut = [[Donut alloc] init];
	idonut.center = CGPointMake(arc4random()%320,arc4random()%460);
	CGAffineTransform transform = CGAffineTransformMakeScale(0.01,0.01);
	idonut.transform = transform;
	[donutArray addObject:idonut];
	[self addSubview:idonut];
	[self animateDonutScaleUp:idonut value:1];
	
	[idonut release];


}


// For the alternate implementation, replace 1 with 0 on the next line.

#if 1

- (void)animateDonutScaleUp:(id)sender value:(NSUInteger)x {
	Donut *tapDonut = (Donut *)sender;
	CGAffineTransform transform = CGAffineTransformMakeScale(0.01 + 0.0025*x, 0.01 + 0.0025*x);
	[UIView animateWithDuration:3./156
						  delay:0
						options:UIViewAnimationCurveLinear   
					 animations:^{
						 tapDonut.transform = transform;
					 }
					 completion:^(BOOL finished){
						 if(x+1>156){
							 [self animateDonutScaleDown:tapDonut value:1];
							 return;
						 }
						 [self animateDonutScaleUp:tapDonut value:x+1];
							 
					 }];
	
}

- (void)animateDonutScaleDown:(id)sender value:(NSUInteger)x {
	Donut *tapDonut = (Donut *)sender;
	CGAffineTransform transform = CGAffineTransformMakeScale(0.4-0.0025*x,0.4-0.0025*x);
	[UIView animateWithDuration:3./156
						  delay:0
						options:UIViewAnimationCurveLinear
					 animations:^{
						 tapDonut.transform = transform;
					 }
					 completion:^(BOOL finished){
						 if(x+1>156){
							 [tapDonut removeFromSuperview];
							 [donutArray removeObjectIdenticalTo:tapDonut];
							 return;
						 }
						 [self animateDonutScaleDown:tapDonut value:x+1];
					 }];
	
}

#else

- (void)animateDonutScaleUp:(id)sender value:(NSUInteger)x {
	NSLog(@"asfdasdf");
	Donut *lastDonut = (Donut *)sender;
	CALayer *donutLayer = lastDonut.layer;
	CGAffineTransform fromTransformAffine = CGAffineTransformMakeScale(0.01, 0.01);
	CGAffineTransform toTransformAffine = CGAffineTransformMakeScale(0.4, 0.4);
	CATransform3D fromTransform = CATransform3DMakeAffineTransform(fromTransformAffine);
	CATransform3D toTransform = CATransform3DMakeAffineTransform(toTransformAffine);
	CABasicAnimation *theAnimation;
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform"];
	theAnimation.duration=4;
	theAnimation.delegate=self;
	theAnimation.repeatCount=0;
	theAnimation.autoreverses=YES;
	theAnimation.fromValue=[NSValue valueWithCATransform3D:fromTransform];
	theAnimation.toValue=[NSValue valueWithCATransform3D:toTransform];
	[donutLayer addAnimation:theAnimation forKey:@"animateSize"];
}

- (void)animateDonutScaleDown:(id)sender value:(NSUInteger)x {
	Donut *lastDonut = (Donut *)sender;
	CGAffineTransform transform = CGAffineTransformMakeScale(0.01,0.01);
	[UIView animateWithDuration:3
						  delay:0
						options:UIViewAnimationCurveEaseOut
					 animations:^{
						 lastDonut.transform = transform;
					 }
					 completion:^(BOOL finished){
						 [lastDonut removeFromSuperview];
						 [donutArray removeObjectIdenticalTo:lastDonut];
					 }];
}


#endif

- (void)animationDidStart:(CAAnimation *)theAnimation {
	CAPropertyAnimation *anim = (CAPropertyAnimation *)theAnimation;
	if ([anim.keyPath isEqual:@"opacity"]) {
		NSLog(@"animateOpacity");
	}
	/*
	for (Donut *tapDonut in donutArray) {
		CALayer *donutLayer = tapDonut.layer;
		if (theAnimation == [donutLayer animationForKey:@"animateSize"]){
			NSLog(@"animateSize");
			//[NSRunLoop addTimer:updateTimer forMode:NSDefaultRunLoopMode];
		}

	}
	 */
	
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	
}


-(void)updateSize{
	
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[donutArray release];
    [super dealloc];
}


@end
