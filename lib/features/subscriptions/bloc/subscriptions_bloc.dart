import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradpool/Core/use_case/use_case.dart';
import 'package:tradpool/features/subscriptions/model/my_subscription_model.dart';
import 'package:tradpool/features/subscriptions/model/request_subscription_body.dart';
import 'package:tradpool/features/subscriptions/model/subscription_payent_response_model.dart';
import 'package:tradpool/features/subscriptions/model/subscriptions_model.dart';

import '../../../Core/consts.dart';
import '../../../injection_container.dart';

part 'subscriptions_event.dart';
part 'subscriptions_state.dart';

class SubscriptionsBloc extends Bloc<SubscriptionsEvent, SubscriptionsState> {
  final UseCasee getSubscreptions;
  final UseCasee requestSubscreptions;
  final UseCasee getMySubscription;
  final UseCasee paymentSubscription;
  SubscriptionsBloc(this.getSubscreptions, this.requestSubscreptions,
      this.getMySubscription, this.paymentSubscription)
      : super(SubscriptionsInitial()) {
    on<SubscriptionsEvent>((event, emit) async {
      if (event is GetSubcriptionsEvent) {
        emit(LoadingSubscriptions());
        var response = await getSubscreptions.getUsecase(
            "/tradepool/client/get-subscriptions?page=0&size=1000",
            ([response]) => subscriptionsResponseModelFromJson(response));
        response.fold((l) => emit(Error(l.message)),
            (r) => emit(GetSubscriptionsState(r)));
      }
      if (event is RequestSubciptionsEvent) {
       
      
        emit(LoadingSubscriptions());
       
        var response = await requestSubscreptions.postUsecase(
            "/tradepool/client/add-subscription-request?user=${sl<SharedPreferences>().getString(Con.token)}",
            ([response]) => {},
            requestSubscriptionBodyToJson(event.requestSubscriptionBody));
        response.fold((l) => emit(Error(l.message)),
            (r) => emit(RequestSubciptionsState()));
      }
      if (event is GetMySubscriptionEvent) {
        // emit (LoadingSubscriptions());

        var response = await getMySubscription.getUsecase(
            "/tradepool/client/get-subscription-requests?user=${sl<SharedPreferences>().getString(Con.token)}",
            ([response]) => mySubscriptionResponseModelFromJson(response));
        response.fold(
            (l) => emit(Error(l.message)), (r) => emit(MySubscriptionState(r)));
      }
      if (event is GetSubscriptionsPaymentsEvent) {
        // emit (LoadingSubscriptions());

        var response = await paymentSubscription.putUsecase(
            "/tradepool/client/get-subscription-requests?user=${sl<SharedPreferences>().getString(Con.token)}",
            ([response]) => mySubscriptionResponseModelFromJson(response),
            jsonEncode({
              "subscriptionActivationId": event.subcriptionId,
              "fromDate": event.fromDate,
              "toDate": event.toDate,
              "status": event.status
            }));
        response.fold((l) => emit(Error(l.message)),
            (r) => emit(GetSubscriptionsPaymentsState(r)));
      }
    });
  }
}
