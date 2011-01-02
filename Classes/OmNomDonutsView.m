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
@synthesize timer;

-(id)initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
	if(self) {
		[self setUp];
	}
	return self;
}

-(void)setUp{
	donutArray = [[NSMutableArray alloc] init];
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addDonut) userInfo:nil repeats:YES];
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
	for(id object in donutArray){
		if ([touch view] == object) 
			[self animateDonutPress:object];
	}
}


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
						 NSLog(@"Done!");
					 }];

}

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
