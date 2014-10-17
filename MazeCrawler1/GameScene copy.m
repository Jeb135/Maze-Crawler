//
//  GameScene.m
//  MazeCrawler1
//
//  Created by Benjamin Bachman on 10/12/14.
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import "GameScene.h"
#import "Dungeon_1.h"

#define kMaxVerticalMovement 4
#define kMaxHorizontallMovement 12
#define kMinSwipeDistance 20

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor yellowColor];
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    myLabel.text = @"Dungeon_1";
    myLabel.fontSize = 65;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame));
    
    [self addChild:myLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    
    self.startLocation = [touch locationInNode:self];
    self.endLocation = self.startLocation;
    NSLog(@"Starting Drag\n");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    self.endLocation = [touch locationInNode:self];
    
    if (fabs(self.endLocation.y - self.startLocation.y) < kMaxVerticalMovement &&
        fabs(self.endLocation.x - self.startLocation.x) > kMinSwipeDistance) {
        
        if (self.endLocation.x > self.startLocation.x) {
            [self moveRight];
        }
        
        if (self.endLocation.x < self.startLocation.x) {
            [self moveLeft];
        }
    }
    
}

-(void)moveLeft {
    NSLog(@"Moving Left\n");
    Dungeon_1 *newScene = [Dungeon_1 sceneWithSize:self.scene.size];
    [self.view presentScene:newScene transition:[SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:1.0]];
}

-(void)moveRight {
    NSLog(@"Moving Right\n");
    Dungeon_1 *newScene = [Dungeon_1 sceneWithSize:self.scene.size];
    [self.view presentScene:newScene transition:[SKTransition moveInWithDirection:SKTransitionDirectionRight duration:1.0]];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
