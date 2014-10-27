//
//  DungeonScene.m
//  MazeCrawler1
//
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import "DungeonScene.h"

#import "Dungeon_1.h"
#import "Dungeon_2.h"
#import "Dungeon_3.h"
#import "Dungeon_4.h"
#import "Dungeon_5.h"
#import "Dungeon_6.h"
#import "Dungeon_7.h"
#import "Dungeon_8.h"
#import "Dungeon_9.h"

#define kSceneSlideDuration 0.6

@implementation DungeonScene

// Initialize the general scene attributes
//- (void)initScene:(int)scene withPlayerGridPosition:(CGPoint)position
- (void)initScene:(int)scene withPlayerGridPositionX:(int)x andY:(int)y
{
    self.currentScene = scene;
	
    _playerPosition.x = x;
    _playerPosition.y = y;
    NSLog(@"Loaded Scene: %d\n",self.currentScene);
    NSLog(@"Initial Player Position X: %d, Y: %d\n\n\n", _playerPosition.x, _playerPosition.y);
	
    CGPoint newPlayerPosition = CGPointMake(_playerPosition.x * kGridSquareSize - kPlayerRadius, _playerPosition.y * kGridSquareSize - kPlayerRadius);
    [self createPlayerAtPosition:newPlayerPosition];
	
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    
    self.startLocation = [touch locationInNode:self];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Create a touch object to get the input touches
    UITouch *touch = [touches anyObject];
    self.endLocation = [touch locationInNode:self];
	
	// Check if this is a left/right swipe
    if (fabs(self.endLocation.y - self.startLocation.y) < kMaxVerticalMovement &&
        fabs(self.endLocation.x - self.startLocation.x) > kMinSwipeDistance) {
        
        if (self.endLocation.x > self.startLocation.x) {
            [self moveRight];
        }
        if (self.endLocation.x < self.startLocation.x) {
            [self moveLeft];
        }
    }
	
	// Check if this is an up/down swipe
    if (fabs(self.endLocation.y - self.startLocation.y) > kMinSwipeDistance &&
        fabs(self.endLocation.x - self.startLocation.x) < kMaxHorizontalMovement) {
        
        if (self.endLocation.y < self.startLocation.y) {
            [self moveDown];
        }
        if (self.endLocation.y > self.startLocation.y) {
            [self moveUp];
        }
    }
	
	// Now check if the scene is different since we might have moved the player
    //[self checkHasChangedScene]; // This is no longer necessary...
}

#pragma mark -
#pragma mark Player Move Methods

-(void)moveLeft
{
    //NSLog(@"Moving Left\n");
	
	// Get the player sprite
    SKSpriteNode *ball = (SKSpriteNode*)[self childNodeWithName:@"Player"];
	
	// Create the actions to perform
	SKAction *updatePositionAction = [SKAction runBlock:^{
		[self checkHasChangedScene];
	}];
	SKAction *move = [SKAction moveByX:-kGridSquareSize y:0 duration:(1 / kPlayerSpeed)];
	SKAction *moveAction = [SKAction sequence:@[move,updatePositionAction]];
	
	// run the actions
    //if (![ball hasActions])
	//{
        [ball runAction:moveAction];
		//_playerPosition.x--;
	//}
    //[self checkHasChangedScene];
}

-(void)moveRight
{
    //NSLog(@"Moving Right\n");
    SKSpriteNode *ball = (SKSpriteNode*)[self childNodeWithName:@"Player"];
    
    //SKAction *moveAction = [SKAction moveByX:kGridSquareSize y:0 duration:(1 / kPlayerSpeed)];
	
	SKAction *updatePositionAction = [SKAction runBlock:^{
		[self checkHasChangedScene];
	}];
	SKAction *move = [SKAction moveByX:kGridSquareSize y:0 duration:(1 / kPlayerSpeed)];
	SKAction *moveAction = [SKAction sequence:@[move,updatePositionAction]];
	
    //if (![ball hasActions])
	//{
        [ball runAction:moveAction];
		//_playerPosition.x++;
	//}
    //[self checkHasChangedScene];
}

-(void)moveDown
{
    //NSLog(@"Moving Down\n");
    SKSpriteNode *ball = (SKSpriteNode*)[self childNodeWithName:@"Player"];
    
    //SKAction *moveAction = [SKAction moveByX:0 y:-kGridSquareSize duration:(1 / kPlayerSpeed)];
	
	SKAction *updatePositionAction = [SKAction runBlock:^{
		[self checkHasChangedScene];
	}];
	SKAction *move = [SKAction moveByX:0 y:-kGridSquareSize duration:(1 / kPlayerSpeed)];
	SKAction *moveAction = [SKAction sequence:@[move,updatePositionAction]];
	
    //if (![ball hasActions])
	//{
        [ball runAction:moveAction];
		//_playerPosition.y--;
	//}
    //[self checkHasChangedScene];
}

-(void)moveUp
{
    //NSLog(@"Moving Up\n");
    SKSpriteNode *ball = (SKSpriteNode*)[self childNodeWithName:@"Player"];
    
    //SKAction *moveAction = [SKAction moveByX:0 y:kGridSquareSize duration:(1 / kPlayerSpeed)];
	
	SKAction *updatePositionAction = [SKAction runBlock:^{
		[self checkHasChangedScene];
	}];
	SKAction *move = [SKAction moveByX:0 y:kGridSquareSize duration:(1 / kPlayerSpeed)];
	SKAction *moveAction = [SKAction sequence:@[move,updatePositionAction]];
	
    //if (![ball hasActions])
	//{
        [ball runAction:moveAction];
		//_playerPosition.y++;
	//}
    //[self checkHasChangedScene];
}

#pragma mark -
#pragma mark Scene Update Methods

- (void)checkHasChangedScene
{
	// Get the player sprite node and check if its in the world...
    SKSpriteNode *ball = (SKSpriteNode*)[self childNodeWithName:@"Player"];
	int toSceneNum = 0;
	int transitionDirection = 0;
    bool shouldChangeScene = YES;

	CGFloat currentXPos = ((ball.position.x + kPlayerRadius) / kGridSquareSize);
	CGFloat currentYPos = ((ball.position.y + kPlayerRadius) / kGridSquareSize);
	
	_playerPosition.x = (int)roundf(currentXPos); // Make an integer for ease of consideration
	_playerPosition.y = (int)roundf(currentYPos); // Make an integer for eas of consideration
	
	// Inform us in debug console what's going on...
	NSLog(@"Real_Float X: %f Y: %f",currentXPos,currentYPos);
	NSLog(@"Real_Int X: %i Y: %d",_playerPosition.x, _playerPosition.y);
	NSLog(@"Current Scene: %d\n\n",self.currentScene);
	//NSLog(@"MapMod: %d", (kMapHorizontalSize / kGridSquareSize));
	
	// Now check whether the player has moved outside of the world
	if (_playerPosition.x > (kMapHorizontalSize /kGridSquareSize)) {
		toSceneNum = self.currentScene + 1;
		transitionDirection = kSceneSlideDirectionRight;
		_playerPosition.x = 1;
		shouldChangeScene = YES;
	}
	if (_playerPosition.x < 1) {
		toSceneNum = self.currentScene - 1;
		transitionDirection = kSceneSlideDirectionLeft;
		//self.newPlayerPosition = CGPointMake(kMapHorizontalSize - kPlayerRadius, (int)ball.position.y);
		_playerPosition.x = kMapHorizontalSize / kGridSquareSize;
		shouldChangeScene = YES;
	}
	if (_playerPosition.y > (kMapVerticalSize / kGridSquareSize)) {
		toSceneNum = self.currentScene - 3;
		transitionDirection = kSceneSlideDirectionUp;
		//self.newPlayerPosition = CGPointMake((int)ball.position.x, kPlayerRadius);
		_playerPosition.y = 1;
		shouldChangeScene = YES;
	}
	if (_playerPosition.y < 1) {
		toSceneNum = self.currentScene + 3;
		transitionDirection = kSceneSlideDirectionDown;
		//self.newPlayerPosition = CGPointMake((int)ball.position.x, kMapVerticalSize + kPlayerRadius);
		_playerPosition.y = (kMapVerticalSize / kGridSquareSize);
		shouldChangeScene = YES;
	}
	
	if (toSceneNum >= 1 && toSceneNum <= 9 && shouldChangeScene) {
		[self transitionToSceneNum:toSceneNum slideDirection:transitionDirection];
	}
}

- (void)transitionToSceneNum:(int)sceneNum slideDirection:(int)direction {
	
	// Create a new Dungeon Scene Object depending on scene map number
    DungeonScene *newScene;
    
    switch (sceneNum)
    {
        case 1:
            newScene = [Dungeon_1 sceneWithSize:self.scene.size];
            self.currentScene = 1;
            break;
        case 2:
            newScene = [Dungeon_2 sceneWithSize:self.scene.size];
            self.currentScene = 2;
            break;
        case 3:
            newScene = [Dungeon_3 sceneWithSize:self.scene.size];
            self.currentScene = 3;
            break;
        case 4:
            newScene = [Dungeon_4 sceneWithSize:self.scene.size];
            self.currentScene = 4;
            break;
        case 5:
            newScene = [Dungeon_5 sceneWithSize:self.scene.size];
            self.currentScene = 5;
            break;
        case 6:
            newScene = [Dungeon_6 sceneWithSize:self.scene.size];
            self.currentScene = 6;
            break;
        case 7:
            newScene = [Dungeon_7 sceneWithSize:self.scene.size];
            self.currentScene = 7;
            break;
        case 8:
            newScene = [Dungeon_8 sceneWithSize:self.scene.size];
            self.currentScene = 8;
            break;
        case 9:
            newScene = [Dungeon_9 sceneWithSize:self.scene.size];
            self.currentScene = 9;
            break;
        default:
            break;
    }
    [newScene initScene:self.currentScene withPlayerGridPositionX:_playerPosition.x andY:_playerPosition.y];
    
    // Create a transition object with the proper slide direction
	// Changed the actual transition in order to give better sense of world exploration
    SKTransition *newSceneTransition;
    if (direction == kSceneSlideDirectionUp) {
        //newSceneTransition = [SKTransition moveInWithDirection:SKTransitionDirectionUp duration:kSceneSlideDuration];
		newSceneTransition = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:kSceneSlideDuration];
		//newSceneTransition = [SKTransition fadeWithDuration:kSceneSlideDuration];
    } else if (direction == kSceneSlideDirectionRight) {
        //newSceneTransition = [SKTransition moveInWithDirection:SKTransitionDirectionRight duration:kSceneSlideDuration];
		newSceneTransition = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:kSceneSlideDuration];
    } else if (direction == kSceneSlideDirectionDown) {
        //newSceneTransition = [SKTransition moveInWithDirection:SKTransitionDirectionDown duration:kSceneSlideDuration];
		newSceneTransition = [SKTransition pushWithDirection:SKTransitionDirectionUp duration:kSceneSlideDuration];
    } else if (direction == kSceneSlideDirectionLeft) {
        //newSceneTransition = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:kSceneSlideDuration];
		newSceneTransition = [SKTransition pushWithDirection:SKTransitionDirectionRight duration:kSceneSlideDuration];
    }
	
	// Present the new scene
    //[newScene createPlayerAtPosition:newPlayerPosition];
    [self.view presentScene:newScene transition:newSceneTransition];
}

- (void)createPlayerAtPosition:(CGPoint)position
{
    // Create the ball object and place it in the scene
    SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"Player_Ball_1"];
    ball.name = @"Player";
    ball.position = position;
    ball.zPosition = 11; // Really high zdepth.... Not much will be able to clip the player
	
	// Add physics to the player
	ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:kPlayerRadius];
    
    [self addChild:ball];
}

/* Overwritten in children
- (void)update:(NSTimeInterval)currentTime
{
	
}
 */

@end
