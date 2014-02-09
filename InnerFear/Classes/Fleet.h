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
@property (nonatomic, assign) int team;

- (id)initWithSide: (int) team;
- (void)setup;



@end
