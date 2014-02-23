//
//  Playable.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/23/14.
//
//

#import "SPSprite.h"

@interface Playable : SPSprite

@property (nonatomic, retain) SPPoint* currentcenter;
@property (nonatomic, retain) Fleet* player;
@property (nonatomic, retain) Fleet* computer;
@property (nonatomic, retain) Background* backgroundSprite;
@property (nonatomic, retain) GamePieceContainer* gamepieceSprite;
@property (nonatomic, assign) double overallscale;
@property (nonatomic, assign) int numberofplanets;
@property (nonatomic, retain) NSMutableArray* planets;
@property (nonatomic, assign) int minX;
@property (nonatomic, assign) int maxX;
@property (nonatomic, assign) int minY;
@property (nonatomic, assign) int maxY;
@property (nonatomic, assign) BOOL gameover;

- (void)start;

@end
