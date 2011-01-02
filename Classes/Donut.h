//
//  Donut.h
//  OmNomDonuts
//
//  Created by John Z Wu on 12/31/10.
//  Copyright 2010 TFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface Donut : UIView {
	UIImage *donutImage;
	NSUInteger hitcount;
}

@property NSUInteger hitcount;
-(id)init;
-(id)nextImage;
-(void)changeImage;

@end
