//
//  Planet.h
//  InnerFear
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


//@property (nonatomic, retain) int team;

- (id) initWithTeam: (int) team X: (double) x Y: (double) y;
- (void) advanceTime: (double) passedTime;

@end
