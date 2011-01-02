//
//  Donut.m
//  OmNomDonuts
//
//  Created by John Z Wu on 12/31/10.
//  Copyright 2010 TFM. All rights reserved.
//

#import "Donut.h"


@implementation Donut


- (id)init {
	donutImage = [UIImage imageNamed:@"donut.png"];
	CGRect frame = CGRectMake(0, 0, donutImage.size.width, donutImage.size.height);
	if (self = [self initWithFrame:frame]) {
		self.opaque = NO;
		self.layer.cornerRadius = self.frame.size.width/2;
		
		self.layer.contents = (id)donutImage.CGImage;
	}
	return self;
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
