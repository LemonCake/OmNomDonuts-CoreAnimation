//
//  Donut.m
//  OmNomDonuts
//
//  Created by John Z Wu on 12/31/10.
//  Copyright 2010 TFM. All rights reserved.
//

#import "Donut.h"


@implementation Donut
@synthesize hitcount;

- (id)init {
	hitcount = 0;
	donutImage = [UIImage	imageNamed:self.nextImage];
	CGRect frame = CGRectMake(0, 0, donutImage.size.width, donutImage.size.height);
	if (self = [self initWithFrame:frame]) {
		self.opaque = NO;
		self.layer.cornerRadius = self.frame.size.width/2;
		self.layer.contents = (id)donutImage.CGImage;
	}
	return self;
}

- (void)changeImage {
	hitcount++;
	donutImage = [UIImage imageNamed:self.nextImage];
	self.layer.contents = (id)donutImage.CGImage;
	return;
}

- (id)nextImage {
	NSString *filename;
	
	switch (hitcount)
	{
		case 0:
			filename = @"donut.png";
			break;
		case 1:
			filename = @"donut2.png";
			break;
		case 2:
			filename = @"donut3.png";
			break;
		default:
			break;
	}
	NSLog(@"Changing to: %s", filename);
	return filename;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	 // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
