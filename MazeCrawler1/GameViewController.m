//
//  GameViewController.m
//  MazeCrawler1
//
//  Copyright (c) 2014 Leaf Applications. All rights reserved.
//

#import "GameViewController.h"

#import "Dungeon_1.h"

@implementation SKScene (Unarchive)
/*
+ (instancetype)unarchiveFromFile:(NSString *)file {
    // Retrieve scene file path from the application bundle
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    // Unarchive the file to an SKScene object
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}
*/
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
	//skView.showsPhysics = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    Dungeon_1 *scene = [Dungeon_1 sceneWithSize:CGSizeMake(480,320)];
    [scene initScene:1 withPlayerGridPositionX:2 andY:1];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
	
	// Play some dungeon music
	if (![scene actionForKey:@"Music"])
	{
		SKAction *loopMusic = [SKAction playSoundFileNamed:@"Dungeon_3.mp3" waitForCompletion:YES];
		[scene runAction:[SKAction repeatActionForever:loopMusic] withKey:@"Music"];
	}
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
