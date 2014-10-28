//
//  individualLogoViewController.m
//  NFLtrivia
//
//  Created by administrator on 11/09/14.
//
//

#import "individualLogoViewController.h"

#import "twoCategoryViewController.h"





@interface individualLogoViewController ()

@end

@implementation individualLogoViewController
@synthesize imageViewPro,photoViewPro,photoId,userId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"photo  %@",photoViewPro);
    NSLog(@"photoid  %@",photoId);

   

}

    -(void)barButtonForTeamSelect:(id)sender{
        
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.imageViewPro.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: photoViewPro]]];
    
  //  imageViewPro.layer.cornerRadius = 25;
   // imageViewPro.layer.borderWidth = 2.0f;
  //  imageViewPro.layer.borderColor = [UIColor whiteColor].CGColor;
   // imageViewPro.clipsToBounds = YES;
    
    NSData *imageData = UIImagePNGRepresentation(imageViewPro.image);
    NSString *imageString = [[NSString alloc] initWithData:imageData encoding:NSASCIIStringEncoding];
    NSLog(@"image string %@",imageString);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saluudButton:(id)sender {
    
    
    [self performSegueWithIdentifier:@"firstPush" sender:self];
    
 
   
}

- (IBAction)changeTeam:(id)sender{
  [self.navigationController popViewControllerAnimated:TRUE];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"firstPush"]) {
        
        
        twoCategoryViewController *verifyViewController = segue.destinationViewController;
        [self dismissViewControllerAnimated:NO completion:nil];
        verifyViewController.photoId = photoId;
        verifyViewController.userId = userId;
        verifyViewController.photoName = self.photoName;
        verifyViewController.photoViewPro = photoViewPro;
        

        
    }
    
  }







@end
