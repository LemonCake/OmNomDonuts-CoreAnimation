//
//  OmNomDonutsViewController.m
//  OmNomDonuts
//
//  Created by John Z Wu on 12/31/10.
//  Copyright 2010 TFM. All rights reserved.
//

#import "OmNomDonutsViewController.h"
#import "Donut.h"
#import "Common.h"
#import "SingletonSoundManager.h"

@implementation OmNomDonutsViewController

@synthesize donutArray;
@synthesize donutTimer;
@synthesize tapDonutArray;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self setUp];
    [super viewDidLoad];
}

-(void)setUp{
	donutArray = [[NSMutableArray alloc] init];
	tapDonutArray = [[NSMutableArray alloc] init];
	donutTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addDonut) userInfo:nil repeats:YES];
	sharedSoundManager = [SingletonSoundManager sharedSoundManager];
	[sharedSoundManager loadSoundWithKey:@"omnom" fileName:@"omnom" fileExt:@"caf" frequency:44100];
	[sharedSoundManager loadSoundWithKey:@"hit" fileName:@"hit" fileExt:@"caf" frequency:44100];

}

- (void)addDonut {
	Donut *idonut = [[Donut alloc] init];
	idonut.center = CGPointMake(arc4random()%320,arc4random()%460);
	CGAffineTransform transform = CGAffineTransformMakeScale(0.01,0.01);
	idonut.transform = transform;
	
	[donutArray addObject:idonut];
	
	NSLog(@"Donut Array now has %d members",donutArray.count);
	[self.view addSubview:idonut];
	[self animateDonutScaleUp:idonut value:1];
	[idonut release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	// If the touch was on the donut, do stuff
	for(Donut* tapDonut in donutArray){
		if ([touch view] == tapDonut) {
			CGPoint point = [touch locationInView:self.view];
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

#if 1
- (void)animateDonutPress:(id)sender {
	NSLog(@"animateDonutPress");
	Donut *tapDonut = (Donut *)sender;
	
	// Removes donut from view if hitcount is >= 2 else load the next donut image
	if(tapDonut.hitcount >= 2) {
		 [UIView animateWithDuration:0.5
						  delay:0
						options:UIViewAnimationCurveLinear
					 animations:^{
						 tapDonut.alpha = 0;
					 } 
					 completion:^(BOOL finished){
						 [tapDonut removeFromSuperview];
						 [donutArray removeObjectIdenticalTo:tapDonut];
					 }];
		[sharedSoundManager playSoundWithKey:@"omnom" gain:1.0f pitch:0.5f location:Vector2fZero shouldLoop:NO];
	} else {
		tapDonut.changeImage;
		[sharedSoundManager playSoundWithKey:@"hit" gain:1.0f pitch:0.5f location:Vector2fZero shouldLoop:NO];
	}
	
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

#if 1

- (void)animateDonutScaleUp:(id)sender value:(NSUInteger)x {
	Donut *tapDonut = (Donut *)sender;
	CGAffineTransform transform = CGAffineTransformMakeScale(0.01 + 0.005*x, 0.01 + 0.005*x);
	[UIView animateWithDuration:2./38
						  delay:0
						options:UIViewAnimationCurveLinear   
					 animations:^{
						 tapDonut.transform = transform;
					 }
					 completion:^(BOOL finished){
						 if(x>37){
							 [self animateDonutScaleDown:tapDonut value:1];
							 return;
						 }
						 [self animateDonutScaleUp:tapDonut value:x+1];
						 
					 }];
	
}

- (void)animateDonutScaleDown:(id)sender value:(NSUInteger)x {
	Donut *tapDonut = (Donut *)sender;
	CGAffineTransform transform = CGAffineTransformMakeScale(0.2-0.005*x,0.2-0.005*x);
	[UIView animateWithDuration:2./38
						  delay:0
						options:UIViewAnimationCurveLinear
					 animations:^{
						 tapDonut.transform = transform;
					 }
					 completion:^(BOOL finished){
						 if(x>37){
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
	CGAffineTransform toTransformAffine = CGAffineTransformMakeScale(0.2, 0.2);
	CATransform3D fromTransform = CATransform3DMakeAffineTransform(fromTransformAffine);
	CATransform3D toTransform = CATransform3DMakeAffineTransform(toTransformAffine);
	CABasicAnimation *theAnimation;
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform"];
	theAnimation.duration=2;
	theAnimation.delegate=self;
	theAnimation.repeatCount=0;
	theAnimation.autoreverses=YES;
	theAnimation.fromValue=[NSValue valueWithCATransform3D:fromTransform];
	theAnimation.toValue=[NSValue valueWithCATransform3D:toTransform];
	[donutLayer addAnimation:theAnimation forKey:@"animateSize"];
}
/*
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
 */

#endif

- (void)animationDidStart:(CAAnimation *)theAnimation {
	
	for (Donut *tapDonut in donutArray) {
		CALayer *donutLayer = tapDonut.layer;
		if (theAnimation == [donutLayer animationForKey:@"animateOpacity"]){
			tapDonut.userInteractionEnabled = NO;
			[tapDonutArray addObject:tapDonut];
			NSLog(@"tapDonutArray now has %d members",tapDonutArray.count);
			NSLog(@"animateOpacityStart");
		}
		
	}
	
	
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
	CAPropertyAnimation *anim = (CAPropertyAnimation *)theAnimation;
	if(anim.keyPath == @"opacity") {
		NSLog(@"animateOpacityEnd");
		Donut *tapDonut = [tapDonutArray objectAtIndex:0];
		tapDonut.layer.opacity = 0;
		[tapDonut removeFromSuperview];
		[tapDonutArray removeObjectAtIndex:0];
		[donutArray removeObjectIdenticalTo:tapDonut];
		NSLog(@"tap Donut now has %d members",tapDonutArray.count);
		NSLog(@"Donut Array now has %d members",donutArray.count);
	}
}




/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[tapDonutArray release];
	[donutTimer release];
	[donutArray release];
    [super dealloc];
}

@end
