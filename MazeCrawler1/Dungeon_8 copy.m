//
//  Dungeon_8.m
//  MazeCrawler1
//
//  Created by Benjamin Bachman on 10/13/14.
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import "Dungeon_8.h"

@implementation Dungeon_8

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor blueColor];
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Dungeon_8";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end