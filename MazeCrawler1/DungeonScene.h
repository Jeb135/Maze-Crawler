//
//  DungeonScene.h
//  MazeCrawler1
//
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define kMaxVerticalMovement 56 // Horizontal Swipe cannot exceed vertical variation
#define kMaxHorizontalMovement 56 // Vertical Swipe cannot exceed horizontal variation
#define kMinSwipeDistance 32 // A Swipe must be at least this long

#define kGridSquareSize 32 // The base tile size of our game
#define kMapHorizontalSize 480 // 15 tiles wide
#define kMapVerticalSize 320 // 10 tiles high

// Just constants to refer too instead of numbers...
#define kSceneSlideDirectionUp 0
#define kSceneSlideDirectionRight 1
#define kSceneSlideDirectionDown 2
#define kSceneSlideDirectionLeft 3

#define kPlayerSpeed 4.0
#define kPlayerRadius 16

// Simple struct to hold integer versions of the player's grid position
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
//- (void)initScene:(int)scene withPlayerGridPosition:(CGPoint)position;
- (void)initScene:(int)scene withPlayerGridPositionX:(int)x andY:(int)y;

- (void)moveLeft;
- (void)moveRight;
- (void)moveDown;
- (void)moveUp;
- (void)checkHasChangedScene;
- (void)transitionToSceneNum:(int)sceneNum slideDirection:(int)direction;

- (void)createPlayerAtPosition:(CGPoint)position;

@end
