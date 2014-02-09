//
//  CenterChangeEvent.m
//  InnerFear
//
//  Created by Jamieson Abbott on 2/9/14.
//
//

#import "CenterChangeEvent.h"

@implementation CenterChangeEvent

- (id)initWithType:(NSString *)type
{
    if ((self = [super initWithType:type bubbles:NO]))
    {
        self.center = [[SPPoint alloc] init];
    }
    return self;
}

@end
