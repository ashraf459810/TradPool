

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/Core/navigate_service.dart';
import 'package:tradpool/Core/network/network_info.dart';
import 'package:tradpool/Core/remote_data_function/http_methods.dart';
import 'package:tradpool/Core/use_case/use_case.dart';
import 'package:tradpool/features/Register/presentation/bloc/register_bloc.dart';
import 'package:tradpool/features/add_auction/data/datasources/add_item_remote_data.dart';
import 'package:tradpool/features/add_auction/data/datasources/get_tags_remote_data.dart';
import 'package:tradpool/features/add_auction/data/repositories/add_item_repositroyimp.dart';
import 'package:tradpool/features/add_auction/data/repositories/get_tags_repository_imp.dart';
import 'package:tradpool/features/add_auction/domain/repositories/add_item_repositroy.dart';
import 'package:tradpool/features/add_auction/domain/repositories/get_tags_repository.dart';
import 'package:tradpool/features/add_auction/domain/usecases/add_auction_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/calculate_auction_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_brands_for_sub_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_main_category_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_sub_categories_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/get_tags_use_case.dart';
import 'package:tradpool/features/add_auction/domain/usecases/upload_file_use_case.dart';
import 'package:tradpool/features/add_auction/presentation/bloc/add_item_bloc.dart';
import 'package:tradpool/features/auction_details/data/data_source/add_bid_remote_data.dart';
import 'package:tradpool/features/auction_details/data/data_source/add_rate_feedback_remote_data.dart';
import 'package:tradpool/features/auction_details/data/data_source/buy_now_remote_data.dart';
import 'package:tradpool/features/auction_details/data/data_source/enable_auto_bid_remote.dart';
import 'package:tradpool/features/auction_details/data/data_source/get_auction_details_remote_data.dart';
import 'package:tradpool/features/auction_details/data/data_source/get_step_remote_data.dart';
import 'package:tradpool/features/auction_details/data/data_source/send_message_remote.dart';
import 'package:tradpool/features/auction_details/data/repository/add_bid_repository_imp.dart';
import 'package:tradpool/features/auction_details/data/repository/auto_bid_repository_imp.dart';
import 'package:tradpool/features/auction_details/data/repository/buy_now_repository_imp.dart';
import 'package:tradpool/features/auction_details/data/repository/get_step_repository_imp.dart';
import 'package:tradpool/features/auction_details/data/repository/message_repository_imp.dart';
import 'package:tradpool/features/auction_details/data/repository/rate_feedback_repository_imp.dart';
import 'package:tradpool/features/auction_details/domain/repository/add_bid_repositroy.dart';
import 'package:tradpool/features/auction_details/domain/repository/add_rate_and_feedback_repository.dart';
import 'package:tradpool/features/auction_details/domain/repository/auto_bid_repository.dart';
import 'package:tradpool/features/auction_details/domain/repository/buy_now_repository.dart';
import 'package:tradpool/features/auction_details/domain/repository/get_auctions_repository.dart';
import 'package:tradpool/features/auction_details/domain/repository/get_step_repository.dart';
import 'package:tradpool/features/auction_details/domain/repository/messages_repository.dart';
import 'package:tradpool/features/auction_details/domain/use_case/add_bid_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/auction_details_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/auto_bid_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/buy_now_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/get_step_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/rate_and_feedback_use_case.dart';
import 'package:tradpool/features/auction_details/domain/use_case/send_message_use_case.dart';
import 'package:tradpool/features/auction_details/presentation/bloc/auction_details_bloc.dart';
import 'package:tradpool/features/buy/data/datasources/paid_action_remote_data.dart';
import 'package:tradpool/features/buy/data/repositories/paid_auction_repository.dart';
import 'package:tradpool/features/buy/domain/repositories/paid_auctions_repository.dart';
import 'package:tradpool/features/buy/domain/usecases/paid_auctions_use_case.dart';
import 'package:tradpool/features/buy/presentation/bloc/buy_bloc.dart';
import 'package:tradpool/features/home/data/remote_data_source/create_support_request.dart';
import 'package:tradpool/features/home/data/remote_data_source/get_faq_remote_data.dart';
import 'package:tradpool/features/home/data/remote_data_source/get_support_type_remote_data.dart';
import 'package:tradpool/features/home/data/remote_data_source/home_page_remote_data.dart';
import 'package:tradpool/features/home/data/remote_data_source/remote_data_source.dart';
import 'package:tradpool/features/auction_details/data/data_source/user_withdraw.dart';
import 'package:tradpool/features/home/data/repository/all_auctions_repository.dart';
import 'package:tradpool/features/home/data/repository/create_support_repository_imp.dart';
import 'package:tradpool/features/home/data/repository/faq_repository_imp.dart';
import 'package:tradpool/features/home/data/repository/home_page_repository.dart';
import 'package:tradpool/features/auction_details/domain/repository/withdraw_repository.dart';
import 'package:tradpool/features/auction_details/domain/use_case/withdraw_use_case.dart';
import 'package:tradpool/features/home/data/repository/support_repository_imp.dart';
import 'package:tradpool/features/home/domain/repository/create_support_request_repository.dart';
import 'package:tradpool/features/home/domain/repository/faq_repository.dart';
import 'package:tradpool/features/home/domain/repository/support_repositroy.dart';
import 'package:tradpool/features/home/domain/use_case/create_support_request_use_case.dart';
import 'package:tradpool/features/home/domain/use_case/get_faq_use_case.dart';
import 'package:tradpool/features/home/domain/use_case/support_type_use_case.dart';
import 'package:tradpool/features/like/data/remote_data_source/add_to_favourite.dart';
import 'package:tradpool/features/like/data/remote_data_source/get_user_favourites.dart';
import 'package:tradpool/features/like/data/repository/add_to_favourite_repo.dart';
import 'package:tradpool/features/like/domain/repository/add_to_favourite_repository.dart';
import 'package:tradpool/features/home/domain/repository/all_auctions_repository.dart';
import 'package:tradpool/features/home/domain/repository/home_page_repostiroy.dart';
import 'package:tradpool/features/home/domain/use_case/all_auctions_use_case.dart';
import 'package:tradpool/features/home/domain/use_case/home_page_use_case.dart';
import 'package:tradpool/features/home/presentation/bloc/home_bloc.dart';
import 'package:tradpool/features/like/domain/repository/fetch_user_favourite_repository.dart';
import 'package:tradpool/features/like/domain/use_case/add_to_favourite_use_case.dart';
import 'package:tradpool/features/like/domain/use_case/fetch_user_favourite_use_case.dart';
import 'package:tradpool/features/like/presentation/bloc/like_bloc.dart';

import 'package:tradpool/features/login/data/datasources/login_remote_data.dart';
import 'package:tradpool/features/login/data/repositories/login_repositroy_imp.dart';
import 'package:tradpool/features/login/domain/repositories/login_repository.dart';
import 'package:tradpool/features/login/domain/usecases/login_use_case.dart';
import 'package:tradpool/features/login/presentation/bloc/log_in_bloc.dart';
import 'package:tradpool/features/notifications/data/remote_data_source/get_notificarions_remote_data.dart';
import 'package:tradpool/features/notifications/domain/repository/fetchnotification.dart';
import 'package:tradpool/features/notifications/domain/use_case/fetch_notificatinos.dart';
import 'package:tradpool/features/notifications/domain/use_case/mark_notification_seen_use_case.dart';

import 'package:tradpool/features/register/data/datasources/register_remote_data.dart';
import 'package:tradpool/features/register/data/repositories/register_repositoryimp.dart';
import 'package:tradpool/features/register/domain/repositories/register_repository.dart';
import 'package:tradpool/features/register/domain/usecases/register_use_case.dart';
import 'package:tradpool/features/search/data/datasources/search_remote_data.dart';
import 'package:tradpool/features/search/data/repositories/search_repository_imp.dart';
import 'package:tradpool/features/search/domain/repositories/search_repository.dart';
import 'package:tradpool/features/search/domain/usecases/search_use_case.dart';
import 'package:tradpool/features/search/presentation/bloc/search_bloc.dart';

import 'package:tradpool/features/sell/data/datasources/get_auctions_remote_data.dart';
import 'package:tradpool/features/sell/data/repositories/user_auction_repository_imp.dart';
import 'package:tradpool/features/sell/domain/repositories/user_auctions_repositroy.dart';
import 'package:tradpool/features/sell/domain/usecases/user_auctions_use_case.dart';
import 'package:tradpool/features/sell/presentation/bloc/sell_bloc.dart';
import 'package:tradpool/features/settings/data/remote_data/fetch_user_preferences_remote_data.dart';
import 'package:tradpool/features/settings/data/remote_data/fill_user_preferences.dart';
import 'package:tradpool/features/settings/data/remote_data/get_user_support_request.dart';
import 'package:tradpool/features/settings/data/remote_data/get_winned_auctions.dart';
import 'package:tradpool/features/settings/data/remote_data/support_request_details.dart';
import 'package:tradpool/features/settings/data/remote_data/user_history_remote_data.dart';
import 'package:tradpool/features/settings/data/repository/winned_auctions_repository_imp.dart';
import 'package:tradpool/features/settings/data/repository/fetch_user_preferences_repository_imp.dart';
import 'package:tradpool/features/settings/data/repository/support_request_repository_imp.dart';
import 'package:tradpool/features/settings/data/repository/user_history_repository_imp.dart';
import 'package:tradpool/features/settings/domain/repository/fetch_user_preferences_repository.dart';
import 'package:tradpool/features/settings/domain/repository/fill_user_preferences_repostory.dart';
import 'package:tradpool/features/settings/domain/repository/support_request_details_repository.dart';
import 'package:tradpool/features/settings/domain/repository/user_history_repository.dart';
import 'package:tradpool/features/settings/domain/repository/winned_auctions_repository.dart';
import 'package:tradpool/features/settings/domain/usecase/fetch_user_preferences_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/fill_user_preferences_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/get_user_info_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/support_request_details_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/update_user_profile_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/user_history_use_case.dart';
import 'package:tradpool/features/settings/domain/usecase/winned_auctions_use_case.dart';
import 'package:tradpool/features/splash/data/data_source/save_token_remote_data.dart';
import 'package:tradpool/features/splash/data/repository/repository_imp.dart';
import 'package:tradpool/features/splash/domain/repositories/save_token_repository.dart';
import 'package:tradpool/features/splash/domain/usecases/save_token_use_case.dart';
import 'package:tradpool/features/subscriptions/bloc/subscriptions_bloc.dart';
import 'package:tradpool/features/verfication/data/datasources/verfication_local_data.dart';
import 'package:tradpool/features/verfication/data/datasources/verfication_remote_data.dart';
import 'package:tradpool/features/verfication/data/repositories/verfication_repository_impl.dart';
import 'package:tradpool/features/verfication/domain/repositories/verfication_repository.dart';
import 'package:tradpool/features/verfication/domain/usecases/user_info_use_case.dart';
import 'package:tradpool/features/verfication/domain/usecases/verfication_use_case.dart';
import 'package:tradpool/features/verfication/presentation/bloc/verfication_bloc.dart';

import 'Core/network/http_implement.dart';
import 'Core/network/http_interface.dart';
import 'Core/repository/repository.dart';
import 'Core/repository/repository_imp.dart';
import 'features/auction_details/data/repository/auction_details_repository_imp.dart';
import 'features/auction_details/data/repository/withdraw_repo_imp.dart';
import 'features/like/data/repository/fetch_user_favourite_repository_imp.dart';
import 'features/notifications/data/repository/notifications_repository.dart';
import 'features/notifications/presentation/bloc/notifications_bloc.dart';
import 'features/settings/data/repository/fill_user_preferences_repository_imp.dart';
import 'features/settings/data/repository/support_request_details_repository_imp.dart';
import 'features/settings/domain/repository/support_requests_repository.dart';
import 'features/settings/domain/usecase/support_request_use_case.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(
    () => RegisterBloc(
      sl(),
    ),
  );

  sl.registerFactory(
    () => SubscriptionsBloc(
      sl(),
      sl(),
      sl(),
      sl()
    ),
  );
    sl.registerFactory(
    () => SettingsBloc(sl(),sl(),sl(),sl(),sl(),sl(),sl(),
      sl(),
      sl(),
    ),
  );
    sl.registerFactory(
    () => LikeBloc(
      sl(),
      sl(),
      sl ()
    ),
  );
    sl.registerFactory(
    () => SearchBloc(
      sl(),sl(),sl(),sl()
    ),
  );
sl.registerFactory(
    () => BuyBloc(
      sl(),
      sl()
    ),
  );
  sl.registerFactory(
    () => NotificationsBloc(
      sl(),
      sl(),
    ),
  );

  sl.registerFactory(
    () => SellBloc(
      sl(),
    ),
  );

  sl.registerFactory(
    () => LogInBloc(
      sl(),
    ),
  );
  sl.registerFactory(

    () => HomeBloc(sl(),sl(),sl(),sl(),sl(),sl(),
      sl(),
    ),
  );

  sl.registerFactory(
    () => SplashBloc(
      sl(),
    ),
  );

  sl.registerFactory(
    () => VerficationBloc(sl(), sl(), sl(), sl()),
  );
  

  sl.registerFactory(
    () => AddItemBloc(sl(), sl(), sl(), sl(), sl(),sl(),sl()),
  );

  sl.registerFactory(() => AuctionDetailsBloc(sl(),sl(), sl(), sl(), sl(), sl() , sl(),sl(),sl()));

  // Use cases
  sl.registerLazySingleton<GetStepUseCase>(
    () => GetStepUseCaseImp(
      sl(),
    ),
  );
    sl.registerLazySingleton<CaluculateAuctionUseCase>(
    () => CaluculateAuctionUseCaseImp(
      sl(),
    ),
  );
 sl.registerLazySingleton<SendMessageUseCase>(
    () => SendMessageUseCaseImp(
      sl(),
    ),
  );
    sl.registerLazySingleton<FAQUseCase>(
    () => FAQUseCaseImp(
      sl(),
    ),
  );


    sl.registerLazySingleton<GetTagsUseCase>(
    () => GetTagsUseCaseImp(
      sl(),
    ),
  );

    sl.registerLazySingleton<FetchUserPreferencesUseCase>(
    () => FetchUserPreferencesUseCaseImp(
      sl(),
    ),
  );


    sl.registerLazySingleton<UserHistoryUseCase>(
    () => UserHistoryUseCaseImp(
      sl(),
    ),
  );
   sl.registerLazySingleton<SupportRequestDetailsUseCase>(
    () => SupportRequestDetailsUseCaseImp(
      sl(),
    ),
  );

    sl.registerLazySingleton<SupportRequestUseCase>(
    () => SupportRequestUseCaseImp(
      sl(),
    ),
  );

    sl.registerLazySingleton<WinnedAuctionsUseCase>(
    () => WinnedAuctionsUseCaseImp(
      sl(),
    ),
  );
    sl.registerLazySingleton<CreateSupportRequestUseCase>(
    () => CreateSupportRequestUseCaseImp(
      sl(),
    ),
  );
    sl.registerLazySingleton<RateAndFeedBackUseCase>(
    () => RateAndFeedBackUseCaseImp(
      sl(),
    ),
  );

   sl.registerLazySingleton<SupportTypeUseCase>(
    () => SupportTypeUseCaseImp(
      sl(),
    ),
  );

    sl.registerLazySingleton<FillUserPreferencesUseCase>(
    () => FillUserPreferencesUseCaseImp(
      sl(),
    ),
  );

     sl.registerLazySingleton<BuyNowUseCase>(
    () => BuyNowUseCaseImp(
      sl(),
    ),
  );


    sl.registerLazySingleton<WithdrawUseCase>(
    () => WithdrawUseCaseImp(
      sl(),
    ),
  );

  sl.registerLazySingleton<AddToFavouriteUseCase>(
    () => AddtoFavouriteUseCaseImp(
      sl(),
    ),
  );

    sl.registerLazySingleton<FetchUserFavouriteUseCase>(
    () => FetchUserFavouriteUseCaseImp(
      sl(),
    ),
  );
   sl.registerLazySingleton<SearchUseCase>(
    () => SearchUseCaseImp(
      sl(),
    ),
  );
   sl.registerLazySingleton<PaidAuctionUseCase>(
    () => PaidAuctionUseCaseImp(
      sl(),
    ),
  );
    sl.registerLazySingleton<HomePageUseCase>(
    () => HomePageUseCaseImp(
      sl(),
      sl()
    ),
  );
  sl.registerLazySingleton<AutoBidUseCase>(
    () => AutoBidUseCaseImp(
      sl(),
    ),
  );

  sl.registerLazySingleton<FetchUserNotificationsUseCase>(
    () => FetchUserNotificationsImp(
      sl(),
    ),
  );

  sl.registerLazySingleton<MarkNotificationSeenUseCase>(
    () => MarkNotificationSeenUseCaseImp(
      sl(),
    ),
  );

  sl.registerLazySingleton<AuctionDetailsUseCase>(
    () => AuctionDetailsUseCaseImp(
      sl(),
    ),
  );
  sl.registerLazySingleton<AddBidUseCase>(
    () => AddBidUseCaseImp(
      sl(),
    ),
  );
  sl.registerLazySingleton<SaveTpkenUseCase>(
    () => SaveTokenUseCaseImp(
      sl(),
    ),
  );

    sl.registerLazySingleton<GetUserInfoUseCase>(
    () => GetUserInfoUseCaseImp(
      sl(),
    ),
  );

      sl.registerLazySingleton<UpdateUserInfoUseCase>(
    () => UpdateInfoUseCaseImp(
      sl(),
    ),
  );

  sl.registerLazySingleton(() => AllAuctionsUseCase(sl()));
  sl.registerLazySingleton(() => SaveToken(sl()));
  sl.registerLazySingleton(() => GetToken(sl()));
  sl.registerLazySingleton(() => SetIsVerify(sl()));
  sl.registerLazySingleton(() => GetIsVerify(sl()));
  sl.registerLazySingleton(() => UserAuctionsUseCase(sl()));
  sl.registerLazySingleton(() => UploadFileUseCase(sl()));
  sl.registerLazySingleton(() => GetMainCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => BrandsForSubCategoryUseCase(sl()));
  sl.registerLazySingleton(() => GetSubCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => AddAuctionUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerLazySingleton(() => VerficationUseCase(sl()));

  // Repository

  sl.registerLazySingleton<GetStepRepository>(
    () => GetStepRepositoryImp(
      sl(),
      sl(),
    ),
  ); 

    sl.registerLazySingleton<MessagesRepository>(
    () => MessagesRepostiryImp(
      sl(),
      sl(),
    ),
  ); 
    sl.registerLazySingleton<FAQRepository>(
    () => FAQRepositoryImp(
      sl(),
      sl(),
    ),
  ); 

    sl.registerLazySingleton<GetTagsRepository>(
    () => GetTagsRepositoryImp(
      sl(),
      sl(),
    ),
  ); 
    sl.registerLazySingleton<FetchUserpreferencesRepository>(
    () => FetchUserPreferencesRepositoryImp(
      sl(),
      sl(),
    ),
  ); 

    sl.registerLazySingleton<UserHistoryRepository>(
    () => UserHistoryRepositoryImp(
      sl(),
      sl(),
    ),
  ); 

    sl.registerLazySingleton<SupportRequestDetailsRepository>(
    () => SupportRequestDetailsRepostiryImp(
      sl(),
      sl(),
    ),
  ); 
   sl.registerLazySingleton<SupportRequestRepository>(
    () => SupportRequestRepositoryImp(
      sl(),
      sl(),
    ),
  );

    sl.registerLazySingleton<WinnedAuctionsRepository>(
    () => WinnedAuctionsRepositoryImp(
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<CreateSupportRepository>(
    () => CreateSupportRepositoryImp(
      sl(),
      sl(),
    ),
  );

    sl.registerLazySingleton<RateAndFeedBackRepository>(
    () => RateAndFeedBackRepositoryImp(
      sl(),
      sl(),
    ),
  );

    sl.registerLazySingleton<SupportTypeRespository>(
    () => SupportTypeRepositoryImp(
      sl(),
      sl(),
    ),
  );
    sl.registerLazySingleton<FillUserPreferencesRepositroy>(
    () => FillUserPreferencesRepositroyImp(
      sl(),
      sl(),
    ),
  );

   sl.registerLazySingleton<BuyNowRepository>(
    () => BuyNowRepositoryImp(
      sl(),
      sl(),
    ),
  );
    sl.registerLazySingleton<WithDrawRepository>(
    () => WithdrawRepositoryImp(
      sl(),
      sl(),
    ),
  );
   sl.registerLazySingleton<AddToFavouriteRepository>(
    () => AddToFavouriteRepositoryImp(
      sl(),
      sl(),
    ),
  );
    sl.registerLazySingleton<FetchUserFavouriteRepository>(
    () => FetchUserFavouriteRepositoryImp(
      sl(),
      sl(),
    ),
  );

   sl.registerLazySingleton<SearchRepository>(
    () => SearchRepostoryImp(
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<PaidAuctionsRepository>(
    () => PaidAuctionRepositryImp(
      sl(),
      sl(),
    ),
  );
    sl.registerLazySingleton<HomePageRepository>(
    () => HomePageRepositoryImp(
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<AutoBidRepositorry>(
    () => AutoBidRepositoryImp(
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton<FetchUserNotificationRepository>(
    () => FetchUserNotificationImp(
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton<SaveTokenRepository>(
    () => SaveTokenRepositoryImp(
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton<GetAuctionDetailsRspository>(
    () => AuctionDetailsImp(
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton<AddBidRepository>(
    () => AddBidRespositoryImp(
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton<AddItemRepository>(
    () => AddItemRepositoryImp(
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<AllAuctionsRepository>(
    () => AllAuctionsRespositoryImp(
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton<UserAuctionsRepository>(
    () => UserAuctionsRepositoryImp(
      sl(),
      sl(),
    ),
  );

  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(
      sl(),
      sl(),
    ),
  );
  sl.registerLazySingleton<VerficationRepository>(
    () => VerficationRepositoryImp(sl(), sl(), sl()),
  );

  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImp(
      sl(),
      sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AutoBidRemoteData>(
    () => AutoBidRemoteDataImp(sl(), sl()),
  );

    sl.registerLazySingleton<SendMessageRemoteData>(
    () => SendMessageRemoteDataImp(sl(), sl()),
  );
    sl.registerLazySingleton<GetFAQRemoteData>(
    () => GetFAQRemoteDataImp(sl(), sl()),
  );

    sl.registerLazySingleton<GetTagsRemoteData>(
    () => GetTagsRmoteDataImp(sl(), sl()),
  );

    sl.registerLazySingleton<FetchUserPreferencesRemoeData>(
    () => FetchUserPreferencesRemoteDataImp(sl(), sl()),
  );


    sl.registerLazySingleton<UserHistoryRemoteData>(
    () => UserHistoryRemoteDataImp(sl(), sl()),
  );
  sl.registerLazySingleton<SupportRequestDetailsRemoteDate>(
    () => SupportRequestDetailsRemoteDateImp(sl(), sl()),
  );
    sl.registerLazySingleton<UserSupportRequestRemoteData>(
    () => UserSupportRequestRemoteDateImp(sl(), sl()),
  );

    sl.registerLazySingleton<WinnedAuctionsRemoteData>(
    () => WinnedAuctionsRemoteDataImp(sl(), sl()),
  );


    sl.registerLazySingleton<CreateSupportRequestRemoteData>(
    () => CreateSupportRequestRemoteDataImp(sl(), sl()),
  );

   sl.registerLazySingleton<RateAndFeedBackRemoteData>(
    () => RateAndFeedBackRemoteDataImp(sl(), sl()),
  );

    sl.registerLazySingleton<SupportTypeRemoteData>(
    () => SupportTypeRemoteDataImp(sl(), sl()),
  );

    sl.registerLazySingleton<FillUserPreferencesRemoteData>(
    () => FillUserPreferencesRemoteDataImp(sl(), sl()),
  );

   sl.registerLazySingleton<BuyNowRemoteData>(
    () => BuyNowRemoteDataImp(sl(), sl()),
  );
sl.registerLazySingleton<FetchUserFavouriteRemoteData>(
    () => FetchUserFavouriteRemoteDataImp(sl(), sl()),
  );
  sl.registerLazySingleton<UserWithdrawRemoteData>(
    () => UserWithdrawRemoteDataImp(sl(), sl()),
  );


  sl.registerLazySingleton<AddToFavouriteRemoteData>(
    () => AddToFavouriteRemoteDataImp(sl(), sl()),
  );


    sl.registerLazySingleton<SearchRemoteDate>(
    () => SearchRemoteDateImp(sl(), sl()),
  );

   sl.registerLazySingleton<PaidAuctionsRemoteData>(
    () => PaidAuctionsRemoteDataImp(sl(), sl()),
  );

    sl.registerLazySingleton<HomePageRemoteData>(
    () => HomePageRemoteDataImp( sl(),sl()),
  );
  sl.registerLazySingleton<GetStepRemoteData>(
    () => GetStepRemoteDataImpl(sl(), sl()),
  );
  sl.registerLazySingleton<FetchUserNotificationRemoteData>(
    () => FetchUserNotificationRemoteDataImp(sl(), sl()),
  );

  sl.registerLazySingleton<SaveFireBaseTokenRemoteDate>(
    () => SaveFireBaseTokenRemoteDateImp(sl(), sl()),
  );

  sl.registerLazySingleton<GetAuctionDetailsRemoteData>(
    () => GetAuctionRemoteDataImp(sl(), sl()),
  );

  sl.registerLazySingleton<AddBidRemoteDate>(
    () => AddBidRemoteDataImp(sl(), sl()),
  );

  sl.registerLazySingleton<UserAuctionsRemoteData>(
    () => UserAuctionsRmoteDataImpl(sl(), sl()),
  );
  sl.registerLazySingleton<AllAuctionsRemoteData>(
    () => AllAuctionsRemoteDataImp(sl(), sl()),
  );
  sl.registerLazySingleton<AddItemRemoteData>(
    () => AddItemRemoteDataImp(sl()),
  );
  sl.registerLazySingleton<RegisterRemoteData>(
    () => RegisterRemoteDateImpl(sl()),
  );
  sl.registerLazySingleton<VerficationLocatData>(
    () => VerficationLocalDataImpl(sl()),
  );
  sl.registerLazySingleton<VerficationRemoteDate>(
    () => VerficationRemoteDataImpl(
      sl(),
    ),
  );
  sl.registerLazySingleton<LoginRemoteDate>(
    () => LoginRemoteDateImp(sl()),
  );
  //! Core
  sl.registerLazySingleton<NetworkInf>(() => NetworkInfImpl(sl()));
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton<NetworkFunctions>(
    () => NetworkFunctionsImp(),
  );
  

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());



  sl.registerLazySingleton<HttpInterface>(() => HttpImplement(sl()));
  sl.registerLazySingleton<Repository>(() => RepositoryImp(sl()));
  sl.registerLazySingleton<UseCasee>(() => UseCaseImp(
        sl(),
      ));
}
