//
//  WeatherHTTPClient.m
//  Weather
//
//  Created by App-Order on 1/17/14.
//  Copyright (c) 2014 Scott Sherwood. All rights reserved.
//

#import "WeatherHTTPClient.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Utility.h"
#import "Venue.h"
//#import "SVProgressHUD.h"
#import "UIImage+ImageCompress.h"
#import "SearchViewController.h"

#warning PASTE YOUR API KEY HERE
static NSString * const WorldWeatherOnlineAPIKey = @"PASTE YOUR API KEY HERE";

static NSString * const WorldWeatherOnlineURLString = @"http://api.worldweatheronline.com/free/v1/";
static NSString *const  loginURLString = @"http:/scorefolio.xululabs.us/nodeserv/userlogin.php";
static NSString *const  logoutURLString = @"http://scorefolio.xululabs.us/nodeserv/logout.php";
static NSString *const  AddVenueURLString =@"http://scorefolio.xululabs.us/nodeserv/crnode.php";
static NSString *const  SingUp = @"http://scorefolio.xululabs.us/nodeserv/register.php";
static NSString *const  addnewTeamURL = @"http://scorefolio.xululabs.us/nodeserv/crnode.php";
static NSString *const  addNewGameURL = @"http://scorefolio.xululabs.us/nodeserv/crnode.php";
static NSString *const  addNewGameURL1 = @"http://scorefolio.xululabs.us/nodeserv/crevent.php";
static NSString *const  movieimagesUrl = @"http://52.5.222.145:9000/myservice/upload";

@interface WeatherHTTPClient ()<Utilitydeleget>

@end
UIImage *compressimage;
NSData *imageData;
NSString *imageBase64;
NSString *imagesize;



@implementation WeatherHTTPClient

+ (WeatherHTTPClient *)sharedWeatherHTTPClient
{
    static WeatherHTTPClient *_sharedWeatherHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:WorldWeatherOnlineURLString]];
    });
    
    return _sharedWeatherHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

/*- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(NSUInteger)number
 {
 NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
 
 parameters[@"num_of_days"] = @(number);
 parameters[@"q"] = [NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
 parameters[@"format"] = @"json";
 parameters[@"key"] = WorldWeatherOnlineAPIKey;
 
 [self GET:@"weather.ashx" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
 if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)]) {
 [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
 }
 } failure:^(NSURLSessionDataTask *task, NSError *error) {
 if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
 [self.delegate weatherHTTPClient:self didFailWithError:error];
 }
 }];
 }*/

//#pragma mark - User LogIn
//
//-(void)loginWithUsername:(NSString *)userName password:(NSString *)password {
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"name"] = userName;
//    parameters[@"pass"] = password;
//
//
//    AFHTTPRequestOperationManager *operation = [AFHTTPRequestOperationManager manager];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    operation.requestSerializer = [AFJSONRequestSerializer serializer];
//    [operation.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
//    operation.responseSerializer.acceptableContentTypes = [operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    [operation POST:loginURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSLog(@"JSON: %@", responseObject);
//
//         NSDictionary *dataDictr =[responseObject objectForKey:@"data"];
//         NSDictionary *userDictr =[dataDictr objectForKey:@"user"];
//         NSString *UserID =[userDictr objectForKey:@"uid"];
//         NSString *csrfToken =[dataDictr objectForKey:@"X-CSRF-Token"];
//         NSString *sessionID =[dataDictr  objectForKey:@"sessid" ];
//         NSString *sessionName =[dataDictr  objectForKey:@"session_name" ];
//         NSString *sID_Name =[NSString stringWithFormat:@"%@=%@",sessionName,sessionID];
//         NSUserDefaults *sessidname =[NSUserDefaults standardUserDefaults];
//         [sessidname setObject:csrfToken forKey:@"csrfToken"];
//         [sessidname setObject:sID_Name forKey:@"sID_Name"];
//         [sessidname setObject:UserID forKey:@"UserID"];
//
//
//
//     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"Error: %@", error);
//
//     }];
//}
//
//#pragma mark -  User LogOut
//
//-(void)logout {
//    NSDictionary *logoutDictr =@{@"name":@"admin",@"pass":@"admin"};
//    NSUserDefaults *sessidname =[NSUserDefaults standardUserDefaults];
//    NSString *xcrfToken =[sessidname objectForKey:@"csrfToken"];
//    NSString *sID_Name = [sessidname objectForKey:@"sID_Name"];
//    [self.requestSerializer setValue:xcrfToken forHTTPHeaderField:@"X-CSRF-Token"];
//    [self.requestSerializer setValue:sID_Name forHTTPHeaderField:@"session"];
//    [self.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
//    self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    [self POST:logoutURLString parameters:logoutDictr success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//            [self.delegate weatherHTTPClient:self didFailWithError:error];
//        }
//
//    }];
//
//
//}
//
//
//#pragma mark - Venue Submitt
//
//-(void)saveVenueWithImageFileName:(NSString *)fileName WithUserAdress:(NSString *)userAddress WithTitle:(NSString *)title WithDescription:(NSString *)decription image:(UIImage *)UserImage {
//
//    compressimage = [UIImage compressImage:UserImage compressRatio:0.1f maxCompressRatio:0.1f];
//    imageData = UIImagePNGRepresentation(compressimage);
//    imageBase64 = [imageData base64EncodedStringWithOptions:0];
//    imagesize =[NSString stringWithFormat:@"%f", compressimage.size.width];
//
//    NSUserDefaults *sessidname =[NSUserDefaults standardUserDefaults];
//    NSString *xcrfToken =[sessidname objectForKey:@"csrfToken"];
//    NSString *sID_Name = [sessidname objectForKey:@"sID_Name"];
//    NSString *UserID =[sessidname objectForKey:@"UserID"];
//    NSDictionary *myJson =@{@"node":@{@"title" :title,@"type":@"venues",@"field_address_field":@{@"und":@[@{@"value":userAddress}]},@"body":@{@"und":@[@{@"value":decription}]}},@"user": @{@"name" :@"rehman",@"pass":@"rehman123"} ,@"file": @{@"file" :imageBase64,@"filename":fileName,@"filesize":imagesize,@"uid":UserID }};
//
//    [self.requestSerializer setValue:xcrfToken forHTTPHeaderField:@"X-CSRF-Token"];
//    [self.requestSerializer setValue:sID_Name forHTTPHeaderField:@"session"];
//    [self.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
//    self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//   [self POST:AddVenueURLString parameters:myJson success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//
//
//       BOOL status = [responseObject[@"status"]boolValue ];
//       if (status ) {
//           [self showAlertWithMessage:@"Venue added successfully." andTitle:@"Venue"];
//
//       }else {
//
//           [self showAlertWithMessage:@"Venue not added successfully." andTitle:@"Venue"];
//       }
//
//       } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//            [self.delegate weatherHTTPClient:self didFailWithError:error];
//        }     }];
//
//
//
//    }
//#pragma mark - Facility Submitt
//
//-(void)saveFacilityWithFileName:(NSString *)fileName WithTitle:(NSString *)title WithDecription:(NSString *)decription WithFacilityType:(NSString *)faciliyType WithLongited:(NSString *)myLongited WithLatited:(NSString *)myLatited WithSportType:(NSString *)SportType WithAmenityType:(NSString *)AmenityType WithSportStuff:(NSString *)SportStuff WithSportMaintinance:(NSString *)SportMaintinance WithBaseBallDiamond:(NSString *)BaseBallDiamond WithWrmUpSpace:(NSString *)WrmUpSpace WithPlayingSurface:(NSString *)PlayingSurafce WithFench:(NSString *)Fench WithBench:(NSString *)Bench WithTrackingSurface:(NSString *)TrackSurface WithGoalPosts:(NSString *)goalPosts WithIceRinkIndoorOutdoor:(NSString *)IceRinkIndoorOutdoor WithSingleMultipleRinks:(NSString *)SingleMultipleRinks1 WithSingleMultipleRinksString:(NSString *)singleMultipleRinksString2 WithSocerIndoorOutdoor:(NSString *)SocerIndoorOutdoor WithSoccerField65110:(NSString *)SoccerField65110 WithSoccerField5080:(NSString *)SoccerField5080 WithSoccerField4070:(NSString *)SoccerField4070 WithtennisCourtSize:(NSString *)TennisCourtSize WithTennisCourtIndoorOutdoor:(NSString *)TennisCourtIndoorOutdoor WithtennisCourtSingleMultiple:(NSString *)TennisCourtSingleMultiple WithtennisSurface:(NSString *)TennisSurface Withtrack:(NSString *)Track WithBasketballCourtIndorOutdor:(NSString *)BasketBallCourtIndorOutdor WithbasketbalCourtSingleMultiple:(NSString *)BasketbalCourtSingleMultiple WithAdjustableHeightHoops:(NSString *)AdjustableHeightHoops WithBasketBallSurface:(NSString *)BasketBallSurface WithIndoorTrainingFacility:(NSString *)IndoorTrainingFacility WithPoolIndoorOutdoor:(NSString *)PoolIndoorOutdoor WithPoolOlympic:(NSString *)PoolOlympic WithlockerRooms:(NSString *)LockerRooms WithPayAccess:(NSString *)PayAccess WithFanSeating:(NSString *)FanSeating WithConcessionStand:(NSString *)ConcessionStand WithRestroom:(NSString *)Restroom WithParkinglot:(NSString *)Parkinglot userImage:(UIImage *)image  {
//
//    compressimage = [UIImage compressImage:image compressRatio:0.1f maxCompressRatio:0.1f];
//    imageData = UIImagePNGRepresentation(compressimage);
//    imageBase64 = [imageData base64EncodedStringWithOptions:0];
//    imagesize =[NSString stringWithFormat:@"%f", compressimage.size.width];
//    NSUserDefaults *sessidname =[NSUserDefaults standardUserDefaults];
//    NSString *xcrfToken =[sessidname objectForKey:@"csrfToken"];
//    NSString *sID_Name = [sessidname objectForKey:@"sID_Name"];
//    NSString *UserID =[sessidname objectForKey:@"UserID"];
//
//    NSDictionary *facilityJson = @{@"node":@{@"body":@{@"und":@[@{@"value":decription}]},@"field_address_map":@{@"und":@[@{@"lat":myLatited,@"lng":myLongited}]},@"field_adjustable_height_hoops":@{@"und":@{@"value":AdjustableHeightHoops}},@"field_amenity":@{@"und":@{@"value":AmenityType}},@"field_basketball_courts_indor_ou":@{@"und":@{@"value":BasketBallCourtIndorOutdor}},@"field_basketball_courts_single_m":@{@"und":@{@"value":BasketbalCourtSingleMultiple}},@"field_basketball_surface":@{@"und":@{@"value":BasketBallSurface}},@"field_bench":@{@"und":@{@"value":Bench}},@"field_concession_stand_new":@{@"und":@{@"value":ConcessionStand}},@"field_facility_types":@{@"und":@{@"value":faciliyType}},@"field_fan_seating_new":@{@"und":@{@"value":FanSeating}},@"field_fence":@{@"und":@{@"value":Fench}},@"field_goal_posts":@{@"und":@{@"value":goalPosts}},@"field_ice_rink_indoor_outdoor":@{@"und":@{@"value":IceRinkIndoorOutdoor}},@"field_indoor_training_facility":@{@"und":@{@"value":IndoorTrainingFacility}},@"field_looker_rooms_new":@{@"und":@{@"value":LockerRooms}},@"field_multiple_rinks":@{@"und":@{@"value":singleMultipleRinksString2}},@"field_paddle_tennis_caged":@{@"und":@{@"value":LockerRooms}},@"field_parking_lot_new":@{@"und":@{@"value":Parkinglot}},@"field_pay_access_new":@{@"und":@{@"value":PayAccess}},@"field_playing_surface":@{@"und":@{@"value":PlayingSurafce}},@"field_pool_indoor_outdoor":@{@"und":@{@"value":PoolIndoorOutdoor}},@"field_pool_olympic":@{@"und":@{@"value":PoolOlympic}},@"field_restroom_new":@{@"und":@{@"value":Restroom}},@"field_single_rink":@{@"und":@{@"value":SingleMultipleRinks1}},@"field_size_you_can_t_play_on_the":@{@"und":@{@"value":TennisCourtSize}},@"field_soccer_field_40_x_70_u_10_":@{@"und":@{@"value":SoccerField4070}},@"field_soccer_field_50_x_80_u_12_":@{@"und":@{@"value":SoccerField5080}},@"field_soccer_field_65_x_110_yard":@{@"und":@{@"value":SoccerField65110}},@"field_soccer_field_indoor_outdoo":@{@"und":@{@"value":SocerIndoorOutdoor}},@"field_sports_pitch":@{@"und":@{@"value":SportType}},@"field_tennis_courts_indoor_outdo":@{@"und":@{@"value":TennisCourtIndoorOutdoor}},@"field_tennis_courts_single_multi":@{@"und":@{@"value":TennisCourtSingleMultiple}},@"field_tennis_courts_size":@{@"und":@{@"value":TennisCourtSize}},@"field_tennis_surface":@{@"und":@{@"value":TennisSurface}},@"field_track":@{@"und":@{@"value":Track}},@"field_track_surface":@{@"und":@{@"value":TrackSurface}},@"field_warm_up_space":@{@"und":@{@"value":WrmUpSpace}},@"title":title,@"type":@"facilities"},@"field_field_maintenance_tools":@{@"und":@{@"value":SportMaintinance}},@"field_sport_related_stuff_":@{@"und":@{@"value":SportStuff}},@"file":@{@"file":imageBase64,@"filename":fileName,@"filesize":imagesize,@"uid":UserID},@"user":@{@"name":@"admin",@"pass":@"admin"}};
//
//
//
//
//    [self.requestSerializer setValue:xcrfToken forHTTPHeaderField:@"X-CSRF-Token"];
//    [self.requestSerializer setValue:sID_Name forHTTPHeaderField:@"session"];
//    [self.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
//    self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    [self POST:AddVenueURLString parameters:facilityJson success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//
//
//
//        BOOL status = [responseObject[@"status"]boolValue ];
//        if (status ) {
//            [self showAlertWithMessage:@"Facility added successfully." andTitle:@"Facility"];
//
//        }else {
//
//            [self showAlertWithMessage:@"Facility not added successfully." andTitle:@"Facility"];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//            [self.delegate weatherHTTPClient:self didFailWithError:error];
//        }     }];
//
//
//}
//#pragma mark - SingUp
//
//-(void)signUpWithFirstName:(NSString *)firstName withLastName:(NSString *)lastName withUsername:(NSString *)userName withEmail:(NSString *)email withAccountType:(NSString *)accountType withPassword:(NSString *)password image:(UIImage *)userImage imageName:(NSString *)imageName WithCityName:(NSString *)cityName WithStateName:(NSString *)stateName WithNewsUpdate:(NSString *)newUpdate WithPrivacyPolicy:(NSString *)privacyPolicy{
//
//      compressimage = [UIImage compressImage:userImage compressRatio:0.1f maxCompressRatio:0.1f];
//      imageData = UIImagePNGRepresentation(compressimage);
//      imageBase64 = [imageData base64EncodedStringWithOptions:0];
//      imagesize = [NSString stringWithFormat:@"%f", userImage.size.width];
//    NSDictionary *myJson =@{@"user":@{@"name":userName,@"pass":password,@"mail":email,@"conf_mail":email,@"field_account_type":@{@"und":@{accountType:accountType}},@"field_city":@{@"und":@[@{@"value":cityName}]},@"field_state":@{@"und":@[@{@"value":stateName}]},@"field_news_and_updates":@{@"und":@{newUpdate:newUpdate}},@"field_privacy_policy":@{@"und":@{privacyPolicy:privacyPolicy}},@"field_first_name":@{@"und":@[@{@"value":firstName}]},@"field_last_name":@{@"und":@[@{@"value":lastName}]}}, @"file": @{@"file":imageBase64,@"filename":imageName,@"filesize":imagesize,@"uid":@"0"}};
//
//
//    [self.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
//    self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    [self POST:SingUp parameters:myJson success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//
//
//        BOOL status = [responseObject[@"status"]boolValue ];
//        if (status ) {
//            [self showAlertWithMessage:@"User added successfully." andTitle:@"SingUp"];
//
//        }else {
//
//            [self showAlertWithMessage:@"User not added successfully." andTitle:@"SingUp"];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//            [self.delegate weatherHTTPClient:self didFailWithError:error];
//        }     }];
//
//
//
//}

#pragma mark - Movies Data function

//-(void)MovieResponse {
////       NSDictionary *gameEventData = @{@"user" : @{@"name" : @"admin",@"pass" : @"admin"}};
//       [self.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
//       self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//       [self GET:movieimagesUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//           if ([responseObject isKindOfClass:[NSDictionary class]]) {
//               // [SVProgressHUD show];
//               NSDictionary *responseDictionary = (NSDictionary *)responseObject;
//            //  NSArray *moviearrya = [responseDictionary objectForKey:@"bestOptionsList"];
//               [self GetmoviesArray:responseDictionary];
//             //  [[Utility sharedManager] setVenueArray:moviearrya];
//               BOOL status = [responseDictionary[@"status"] boolValue];
//               if (status) {
//                  // NSArray *venue = [Venue setData:responseDictionary[@"bestOptionsList"]];
//                  // NSArray *facility = [Venue setData:resutlDictionary[@"facility"]];
//
//                  //[[Utility sharedManager] setFacilityArray:facility];
//                  // [SVProgressHUD showSuccessWithStatus:@"Downloading Complete"];
//               }
//           }else {
//
//          // [SVProgressHUD showErrorWithStatus:@"Error"];
//           }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//            [self.delegate weatherHTTPClient:self didFailWithError:error];
//        }     }];
//}
//




//
//#pragma mark - Save New Game/Events
//
//-(void)savenewgameEvent:(NSString *)gameName :(NSString *)selectMyTeam :(NSString *)selectMyOpenent :(NSString *)selectMySport :(NSString *)selectMyFacility :(NSString *)selectMyVenue :(NSString *)selectMyEndTime :(NSString *)selectMyShowTime :(NSString *)selectMyStartTime :(NSString *)selectMyGameDate {
//
//    NSUserDefaults *sessidname =[NSUserDefaults standardUserDefaults];
//    NSString *xcrfToken =[sessidname objectForKey:@"csrfToken"];
//    NSString *sID_Name = [sessidname objectForKey:@"sID_Name"];
//    NSString *UserID =[sessidname objectForKey:@"UserID"];
//
//    NSDictionary *gameJson =  @{@"node":@{@"title":gameName,@"type":@"post",@"field_select_your_sport_game":@{@"und":@{selectMySport:selectMySport}},@"field_venues":@{@"und":@{@"target_id":selectMyVenue}},@"field_facilitys":@{@"und":@{@"target_id":selectMyFacility}},@"field_my_team":@{@"und":@[@{@"target_id":selectMyTeam}]},@"field_opponent":@{@"und":@[@{@"target_id":selectMyOpenent}]}},@"user":@{@"name":@"admin",@"pass":@"admin"}};
//
//        [self.requestSerializer setValue:xcrfToken forHTTPHeaderField:@"X-CSRF-Token"];
//        [self.requestSerializer setValue:sID_Name forHTTPHeaderField:@"session"];
//        [self.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
//        self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    [self POST:addNewGameURL parameters:gameJson success:^(NSURLSessionDataTask *task, id responseObject) {
//            NSLog(@"%@",responseObject);
//
//
//            BOOL status = [responseObject[@"status"]boolValue ];
//            if (status ) {
//                [self showAlertWithMessage:@"NewGame added successfully." andTitle:@"Game Schedual/Events"];
//
//            }else {
//
//            [self showAlertWithMessage:@"NewGame not added successfully." andTitle:@"Game Schedual/Events"];
//            }
//
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//            if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//                [self.delegate weatherHTTPClient:self didFailWithError:error];
//            }     }];
//    }
//- (void)showAlertWithMessage:(NSString*)message andTitle:(NSString *)title {
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
//}
//
//#pragma mark - Save New Team
//
//-(void)SavenewTeamWithImageFileName:(NSString *)fileName WithTeamTitle:(NSString *)titleName WithselectSport:(NSString *)selectSport WithSelectTeam:(NSString *)selectTeam WithSelectAge:(NSString *)selectAge WithSelectGender:(NSString *)selectGender WithSelectCity:(NSString *)selectCity WithSelectCountry:(NSString *)selectCountry WithSelectState:(NSString *)selectState WithSelectZip:(NSString *)selectZip WithSelectdescription:(NSString *)selectDescription image:(UIImage *)UserImage {
//
//    compressimage = [UIImage compressImage:UserImage compressRatio:0.1f maxCompressRatio:0.1f];
//    imageData = UIImagePNGRepresentation(compressimage);
//    imageBase64 = [imageData base64EncodedStringWithOptions:0];
//    imagesize =[NSString stringWithFormat:@"%f", compressimage.size.width];
//    NSUserDefaults *sessidname =[NSUserDefaults standardUserDefaults];
//    NSString *xcrfToken =[sessidname objectForKey:@"csrfToken"];
//    NSString *sID_Name = [sessidname objectForKey:@"sID_Name"];
//    NSString *UserID = [sessidname objectForKey:@"UserID"];
//
//    NSDictionary *teamJson =
//
//      @{@"node":@{@"title":titleName,@"type":@"group",@"field_city_state_zip_code":@{@"und":@[@{@"administrative_area":selectState,@"locality":selectCity,@"postal_code":selectZip,@"country":selectCountry}]},@"field_select_your_sport":@{@"und":@{@"value":selectSport}},@"field_age_local_league":@{@"und":@{@"value":selectAge}},@"field_team_type":@{@"und":@{@"value":selectTeam}},@"body":@{@"und":@[@{@"value":selectDescription}]},@"field_age_school_team ":@{@"und":@{@"value":selectAge}},@"field_age_other ":@{@"und":@{@"value":selectAge}},@"field_age_travel ":@{@"und":@{@"value":selectAge}},@"field_gender":@{@"und":@{@"value":selectGender}}},@"user":@{@"name":@"rehman",@"pass":@"rehman123",@"uid":UserID},@"file":@{@"file":imageBase64,@"filename":fileName,@"filesize":imagesize}};
//
//    [self.requestSerializer setValue:xcrfToken forHTTPHeaderField:@"X-CSRF-Token"];
//    [self.requestSerializer setValue:sID_Name forHTTPHeaderField:@"session"];
//    [self.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
//    self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    [self POST:addnewTeamURL parameters:teamJson success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",responseObject);
//
//
//        BOOL status = [responseObject[@"status"]boolValue ];
//        if (status ) {
//            [self showAlertWithMessage:@"NewTeam added successfully." andTitle:@"Team"];
//
//        }else {
//
//            [self showAlertWithMessage:@"NewTeam not added successfully." andTitle:@"Team"];
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
//            [self.delegate weatherHTTPClient:self didFailWithError:error];
//        }     }];
//
//

//}




@end
