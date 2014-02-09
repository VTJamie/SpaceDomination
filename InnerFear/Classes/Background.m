//
//  Background.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/8/14.
//
//

#import "Background.h"

@implementation Background

- (id)init
{
    if ((self = [super init]))
    {
        self.tiles = [[NSMutableArray alloc] init];
        [self setup];
    }
    return self;
}

- (void)dealloc
{

}

- (void)setup
{
    SPImage *tempimage = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"stars"]];
    
    int gameWidth  = Sparrow.stage.width;
    int gameHeight = Sparrow.stage.height;
    int imageWidth = tempimage.width;
    int imageHeight = tempimage.height;
    
    int tileWidth = gameWidth / imageWidth + 2;
    int tileHeight = gameHeight / imageHeight + 2;
    NSLog(@"%d, %d", tileWidth, tileHeight);
    
    for (int x = 0; x < tileWidth; x++)
    {
        for (int y = 0; y < tileHeight; y++)
        {
            SPImage* image = [[SPImage alloc] initWithTexture:[Media atlasTexture:@"stars"]];
            image.pivotX = 0;
            image.pivotY = 0;
            image.x = -imageWidth + imageWidth * x;
            image.y = -imageHeight + imageHeight * y;
            [self.tiles addObject:image];
            [self addChild:image];
        }
    }
    
    [[Game instance] addEventListener:@selector(onCenterChange:) atObject:self forType:EVENT_TYPE_NEW_CENTER_TRIGGERED];
    
}

- (void) redrawTiles: (SPPoint*) newcenter {
    for (SPImage* image in self.tiles)
    {
        image.x -= newcenter.x;
        image.y -= newcenter.y;
        
        if (image.y > Sparrow.stage.height)
        {
            image.y = -image.height + image.y - Sparrow.stage.height;
        }
        
        if (image.x > Sparrow.stage.width)
        {
            image.x = -image.width + image.x - Sparrow.stage.width;
        }
        
        if (image.x + image.width < 0)
        {
            image.x = Sparrow.stage.width + (image.x + image.width);
        }
        
        if (image.y + image.height < 0)
        {
            image.y = Sparrow.stage.height + (image.y + image.height);
        }
    }
}

- (void) onCenterChange: (CenterChangeEvent*) event
{
    [self redrawTiles:event.center];
}


@end
