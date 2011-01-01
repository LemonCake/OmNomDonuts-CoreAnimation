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
	Donut *donut;
	NSTimer *time;
}

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSMutableArray *donutArray;
@property (nonatomic, retain) Donut *donut;

-(void)setUp;
-(void)animateDonutPress:(id)sender;
-(void)addDonut;
-(void)animateDonutScaleUp:(id)sender;
-(void)animateDonutScaleDown:(id)sender;

@end
