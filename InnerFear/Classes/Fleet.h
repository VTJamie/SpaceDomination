//
//  Fleet.h
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import <Foundation/Foundation.h>

@interface Fleet : SPSprite

@property (nonatomic, retain) NSMutableArray* planets;
@property (nonatomic, retain) SPImage* shipImage;
@property (nonatomic, assign) int team;
@property (nonatomic, retain) SPPoint* currentLoc;
@property (nonatomic, retain) SPTween* currenttween;


- (id)initWithSide: (int) team;
- (void)setup;



@end
