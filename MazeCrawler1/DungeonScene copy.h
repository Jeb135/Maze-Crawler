//
//  DungeonScene.h
//  MazeCrawler1
//
//  Created by Benjamin Bachman on 10/13/14.
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define kMaxVerticalMovement 60
#define kMaxHorizontalMovement 60
#define kMinSwipeDistance 32

#define kGridSquareSize 32
#define kMapHorizontalSize 480
#define kMapVerticalSize 320

#define kSceneSlideDirectionUp 0
#define kSceneSlideDirectionRight 1
#define kSceneSlideDirectionDown 2
#define kSceneSlideDirectionLeft 3

#define kPlayerSpeed 6.0
#define kPlayerRadius 16

struct PlayerPosition
{
    int x;
    int y;
};

@interface DungeonScene : SKScene

@property (nonatomic) CGPoint startLocation;
@property (nonatomic) CGPoint endLocation;
@property (nonatomic) int currentScene;
@property (nonatomic) struct PlayerPosition playerPosition;

// Transition from one scene to another Method
- (void)initScene:(int)scene withPlayerGridPosition:(CGPoint)position;

- (void)moveLeft;
- (void)moveRight;
- (void)moveDown;
- (void)moveUp;
- (void)checkHasChangedScene;
- (void)transitionToSceneNum:(int)sceneNum slideDirection:(int)direction;

- (void)createPlayerAtPosition:(CGPoint)position;

@end
