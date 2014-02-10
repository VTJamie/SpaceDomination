//
//  Fleet.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "Fleet.h"
#import "Planet.h"

@implementation Fleet

- (id)initWithSide: (int) team
{
    if ((self = [super init]))
    {
        self.team = team;
        self.currentLoc = [[SPPoint alloc] init];

        [self setup];
    }
    return self;
}

- (void)dealloc
{
    
}

- (void)setup
{ 
    self.shipImage = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"ship"]];
    
    self.shipImage.pivotX = self.shipImage.width / 2.0;
    self.shipImage.pivotY = self.shipImage.height / 2.0;
    self.shipImage.x = Sparrow.stage.width / 2.0;
    self.shipImage.y = Sparrow.stage.height / 2.0;
    [self addChild:self.shipImage];

}

@end
