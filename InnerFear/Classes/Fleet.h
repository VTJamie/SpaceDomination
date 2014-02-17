//
//  Fleet.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import <Foundation/Foundation.h>
#import "Sapphire.h"
#import "Mako.h"
#import "Babylon.h"

@interface Fleet : SPSprite
@property (nonatomic, retain) SPImage* shipImage;
@property (nonatomic, assign) int team;
@property (nonatomic, retain) SPPoint* currentLoc;
@property (nonatomic, retain) SPTween* currenttween;
@property (nonatomic, assign) double fleetSpeedMultiplier;
@property (nonatomic, retain) NSMutableArray* ships;


- (id)initWithSide: (int) team;

- (void) advanceTime: (double) passedTime;
- (void)setup;
- (NSArray*) sapphireShips;
- (NSArray*) babylonShips;
- (NSArray*) makoShips;

- (Sapphire*) popSapphire;
- (Babylon*) popBabylon;
- (Mako*) popMako;

- (Ship*) getShipWithShields;

@end
