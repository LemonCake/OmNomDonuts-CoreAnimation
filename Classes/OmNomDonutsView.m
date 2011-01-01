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

@synthesize donut;
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
	NSLog(@"%d",arc4random()%320);
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
						options: UIViewAnimationCurveEaseOut
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
	CGAffineTransform transform = CGAffineTransformMakeScale(0.1,0.1);
	idonut.transform = transform;
	[donutArray addObject:idonut];
	[self addSubview:[donutArray objectAtIndex:donutArray.count-1]];
	
	[self animateDonutScaleUp:[donutArray objectAtIndex:donutArray.count-1]];
	
	[idonut release];


}

- (void)animateDonutScaleUp:(id)sender {
	Donut *tapDonut = (Donut *)sender;
	CGAffineTransform transform = CGAffineTransformMakeScale(.4, .4);
	[UIView animateWithDuration:3
						  delay:0
						options:UIViewAnimationCurveEaseOut
					 animations:^{
						 tapDonut.transform = transform;
					 }
					 completion:^(BOOL finished){
						 [self animateDonutScaleDown:tapDonut];
					 }];
}

- (void)animateDonutScaleDown:(id)sender {
	Donut *tapDonut = (Donut *)sender;
	CGAffineTransform transform = CGAffineTransformMakeScale(0.01,0.01);
	[UIView animateWithDuration:3
						  delay:0
						options:UIViewAnimationCurveEaseOut
					 animations:^{
						 tapDonut.transform = transform;
					 }
					 completion:^(BOOL finished){
						 [tapDonut removeFromSuperview];
						 [donutArray removeObjectIdenticalTo:tapDonut];
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
	[donut release];
	[donutArray release];
    [super dealloc];
}


@end
