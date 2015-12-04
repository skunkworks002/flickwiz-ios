//
//  WeatherHTTPClient.h
//  Weather
//
//  Created by App-Order on 1/17/14.
//  Copyright (c) 2014 Scott Sherwood. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol WeatherHTTPClientDelegate;


@interface WeatherHTTPClient : AFHTTPSessionManager <UIAlertViewDelegate>

@property (nonatomic, weak) id<WeatherHTTPClientDelegate>delegate;
- (void)gameshareWithDitcr:(NSArray *)dataArray ;

+ (WeatherHTTPClient *)sharedWeatherHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
//- (void)loginWithUsername:(NSString *)userName password:(NSString *)password;
//
//-(void)logout ;
//-(void)saveVenueWithImageFileName:(NSString *)fileName WithUserAdress:(NSString *)userAddress WithTitle:(NSString *)title WithDescription:(NSString *)decription image:(UIImage *)UserImage;
//
//-(void)saveFacilityWithFileName:(NSString *)fileName WithTitle:(NSString *)title WithDecription:(NSString *)decription WithFacilityType:(NSString *)faciliyType WithLongited:(NSString *)myLongited WithLatited:(NSString *)myLatited WithSportType:(NSString *)SportType WithAmenityType:(NSString *)AmenityType WithSportStuff:(NSString *)SportStuff WithSportMaintinance:(NSString *)SportMaintinance WithBaseBallDiamond:(NSString *)BaseBallDiamond WithWrmUpSpace:(NSString *)WrmUpSpace WithPlayingSurface:(NSString *)PlayingSurafce WithFench:(NSString *)Fench WithBench:(NSString *)Bench WithTrackingSurface :(NSString *)TrackSurface WithGoalPosts:(NSString *)goalPosts WithIceRinkIndoorOutdoor:(NSString *)IceRinkIndoorOutdoor WithSingleMultipleRinks:(NSString *)SingleMultipleRinks1 WithSingleMultipleRinksString:(NSString *)singleMultipleRinksString2 WithSocerIndoorOutdoor:(NSString *)SocerIndoorOutdoor WithSoccerField65110:(NSString *)SoccerField65110 WithSoccerField5080:(NSString *)SoccerField5080 WithSoccerField4070:(NSString *)SoccerField4070 WithtennisCourtSize:(NSString *)TennisCourtSize WithTennisCourtIndoorOutdoor:(NSString *)TennisCourtIndoorOutdoor WithtennisCourtSingleMultiple:(NSString *)TennisCourtSingleMultiple WithtennisSurface:(NSString *)TennisSurface Withtrack:(NSString *)Track WithBasketballCourtIndorOutdor:(NSString *)BasketBallCourtIndorOutdor WithbasketbalCourtSingleMultiple:(NSString *)BasketbalCourtSingleMultiple WithAdjustableHeightHoops:(NSString *)AdjustableHeightHoops WithBasketBallSurface:(NSString *)BasketBallSurface WithIndoorTrainingFacility:(NSString *)IndoorTrainingFacility WithPoolIndoorOutdoor:(NSString *)PoolIndoorOutdoor WithPoolOlympic:(NSString *)PoolOlympic WithlockerRooms:(NSString *)LockerRooms WithPayAccess:(NSString *)PayAccess WithFanSeating:(NSString *)FanSeating WithConcessionStand:(NSString *)ConcessionStand WithRestroom:(NSString *)Restroom WithParkinglot:(NSString *)Parkinglot userImage:(UIImage *)image ;
//
//- (void)signUpWithFirstName:(NSString *)firstName withLastName:(NSString *)lastName withUsername:(NSString *)userName withEmail:(NSString *)email withAccountType:(NSString *)accountType withPassword:(NSString *)password  image:(UIImage *)userImage imageName:(NSString *)imageName WithCityName:(NSString *)cityName WithStateName:(NSString *)stateName WithNewsUpdate:(NSString *)newUpdate WithPrivacyPolicy:(NSString *)privacyPolicy;

- (void)MovieResponse;

//-(void)savenewgameEvent:(NSString *)gameName :(NSString *)selectMyTeam :(NSString *)selectMyOpenent :(NSString *)selectMySport :(NSString *)selectMyFacility:(NSString *)selectMyVenue:(NSString *)selectMyEndTime:(NSString *)selectMyShowTime:(NSString *)selectMyStartTime:(NSString *)selectMyGameDate ;
//
//-(void)SavenewTeamWithImageFileName :(NSString *)fileName   WithTeamTitle:(NSString *)titleName WithselectSport:(NSString *)selectSport WithSelectTeam:(NSString *)selectTeam WithSelectAge:(NSString *)selectAge WithSelectGender:(NSString *)selectGender WithSelectCity:(NSString *)selectCity WithSelectCountry:(NSString *)selectCountry WithSelectState:(NSString *)selectState WithSelectZip:(NSString *)selectZip WithSelectdescription:(NSString *)selectDescription image:(UIImage *)UserImage;
//
//
//- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(NSUInteger)number;

@end

@protocol WeatherHTTPClientDelegate <NSObject>
@optional
-(void)weatherHTTPClient:(WeatherHTTPClient *)client didUpdateWithWeather:(id)weather;
-(void)weatherHTTPClient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error;


@end