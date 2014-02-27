//
//  Planet.h
//  SpaceDomination
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#define RED_COLOR "RED"
#define GREEN_COLOR "GREEN"

#import "SPSprite.h"
#import "ShipFactory.h"

@interface Planet : SPSprite

@property (nonatomic, assign) int team;
@property (nonatomic, retain) SPImage* planetimage;
@property (nonatomic, retain) SPPoint* spaceLoc;
@property (nonatomic, assign) BOOL underattack;
@property (nonatomic, retain) ShipFactory* shipFactory;
@property (nonatomic, retain) NSMutableArray* ships;
@property (nonatomic, assign) double size;




//@property (nonatomic, retain) int team;

- (id) initWithTeam: (int) team X: (double) x Y: (double) y size: (double) size;
- (void) advanceTime: (double) passedTime;
- (void) changeTeam: (int) team;
- (NSArray*) sapphireShips;
- (NSArray*) babylonShips;
- (NSArray*) makoShips;

- (Sapphire*) popSapphire;
- (Babylon*) popBabylon;
- (Mako*) popMako;

- (Ship*) getShipWithShields;

@end
