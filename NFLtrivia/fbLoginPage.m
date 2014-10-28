//
//  fbLoginPage.m
//  NFLtrivia
//
//  Created by administrator on 12/09/14.
//
//

#import "fbLoginPage.h"
#import "firstCategoryDuplicateViewController.h"


NSString *firstName;
NSString *lastName;
NSString *facebookId;
NSString *imageUrl;




@interface fbLoginPage ()

@end

@implementation fbLoginPage

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
    
    [FBLoginView class];

 
    FBLoginView *loginView = [[FBLoginView alloc] init];
    loginView.delegate = self;
  
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
  
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTick:) userInfo:nil repeats:YES];
   
    NSLog(@"nameeeeee ");
    
    [self.navigationController setNavigationBarHidden:YES];
}


-(void)onTick:(NSTimer*)timer{
    
    
    
    [self retrieveDetails];
    
    

    
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];

    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
     
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}






-(void)retrieveDetails
{
   
    
    NSLog(@"retrieve details");
    
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 firstName = user.first_name;
                lastName = user.last_name;
                 facebookId = user.objectID;
                 NSString *email = [user objectForKey:@"email"];
                imageUrl = [[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", facebookId];
                 
                 
                 NSLog(@"firstname%@",firstName);
                 NSLog(@"lastname%@",lastName);
                 NSLog(@"facebukid%@",facebookId);
                 NSLog(@"email%@",email);
                 NSLog(@"imageurl%@",imageUrl);
               
               
                [self sessionForFacebook];
                 
             }
         }];
        
    }
    
    
}


-(void)sessionForFacebook
{
    if (![facebookId  isEqual: @""]) {
          [self openFacebookSession];
        
        
    }
}





// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = user.objectID;
    self.nameLabel.text = user.name;
//NSLog(@"nameeeeeenhvjghjg ");
    
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
    
  NSLog(@"nameeeeeenhvjghjg ");
}
/*
// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)openFacebookSession
{
    [timer invalidate];
    timer = nil;
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:
                            @"user_photos",
                            nil];
    
    [FBSession openActiveSessionWithReadPermissions:permissions
                                   allowLoginUI:YES
                              completionHandler: ^(FBSession *session, FBSessionState state, NSError *error){
                                  [self sessionStateChanged:session state:state error:error];
                                 
                                  
                              }];
     NSLog(@"hidfdfd");
}


- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    NSLog(@"state of fb :%lu",state);
    switch (state) {
        case FBSessionStateOpen:
        {
            NSLog(@"FBSessionStateOpen");
            
            
           
         double delayInSeconds = 0.100;
           dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
           dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
               
               firstCategoryDuplicateViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
               [self.navigationController pushViewController:secondViewController animated:YES];
               
               secondViewController.userId=facebookId;
               secondViewController.profileUrl=imageUrl;
               secondViewController.firstName=firstName;
               secondViewController.lastName=lastName;
               
         //      NSLog(@"fir%@",firstName);
            //   NSLog(@"las%@",lastName);
             //  NSLog(@"facid%@",facebookId);
              
              // NSLog(@"imal%@",imageUrl);

             
           });
            
            break;
        }
            
        case FBSessionStateClosed:
        {
            NSLog(@"FBSessionStateClosed");
            break;
        }
            
        case FBSessionStateClosedLoginFailed:
        {
            [FBSession.activeSession closeAndClearTokenInformation];
            NSLog(@"Facebook State Closed or Failed");
            
            break;
        }
        default:
        {
            break;
        }
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
}







// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}




@end
