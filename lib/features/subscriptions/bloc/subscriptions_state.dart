part of 'subscriptions_bloc.dart';

abstract class SubscriptionsState extends Equatable {
  const SubscriptionsState();
  
  @override
  List<Object> get props => [];
}

class SubscriptionsInitial extends SubscriptionsState {}


class GetSubscriptionsState extends SubscriptionsState{
  final SubscriptionsResponseModel subscriptionsResponseModel;

 const GetSubscriptionsState(this.subscriptionsResponseModel);
}


class Error extends SubscriptionsState {
  final String error;

  const Error(this.error);
}
class LoadingSubscriptions extends SubscriptionsState{}


class RequestSubciptionsState extends SubscriptionsState{}



class MySubscriptionState extends SubscriptionsState{
  final MySubscriptionResponseModel mySubscriptionResponseModel;

 const MySubscriptionState(this.mySubscriptionResponseModel);
}

class LoadingMySubscriptionState extends SubscriptionsState{}


class GetSubscriptionsPaymentsState extends SubscriptionsState{

final SubscriptionPaymentResponseModel subscriptionPaymentResponseModel;

  const GetSubscriptionsPaymentsState(this.subscriptionPaymentResponseModel);


}

class LoadingSubscriptionsPaymentsState extends SubscriptionsState{}