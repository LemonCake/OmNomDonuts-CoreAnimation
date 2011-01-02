//
//  OmNomDonutsView.h
//  OmNomDonuts
//
//  Created by John Z Wu on 12/31/10.
//  Copyright 2010 TFM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Donut;

@interface OmNomDonutsView : UIView {
	NSMutableArray *donutArray;
	NSTimer *timer;
}

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSMutableArray *donutArray;

-(void)setUp;
-(void)animateDonutPress:(id)sender;
-(void)addDonut;
-(void)animateDonutScaleUp:(id)sender value:(NSUInteger)x;
-(void)animateDonutScaleDown:(id)sender value:(NSUInteger)x;

@end
