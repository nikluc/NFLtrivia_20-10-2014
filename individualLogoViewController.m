//
//  individualLogoViewController.m
//  NFLtrivia
//
//  Created by administrator on 11/09/14.
//
//

#import "individualLogoViewController.h"

@interface individualLogoViewController ()

@end

@implementation individualLogoViewController
@synthesize imageViewPro,photoViewPro;

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
    
    NSLog(@"csdadasd  %@",photoViewPro);
    
  /*  self.imageViewPro.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: photoViewPro]]];
    
    imageViewPro.layer.cornerRadius = 25;
    imageViewPro.layer.borderWidth = 2.0f;
    imageViewPro.layer.borderColor = [UIColor cyanColor].CGColor;
    imageViewPro.clipsToBounds = YES;
    
      NSData *imageData = UIImagePNGRepresentation(imageViewPro.image);
     NSString *imageString = [[NSString alloc] initWithData:imageData encoding:NSASCIIStringEncoding];*/

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

@end
