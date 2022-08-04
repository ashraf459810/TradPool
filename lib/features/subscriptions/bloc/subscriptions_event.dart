part of 'subscriptions_bloc.dart';

abstract class SubscriptionsEvent extends Equatable {
  const SubscriptionsEvent();

  @override
  List<Object> get props => [];
}


class GetSubcriptionsEvent extends SubscriptionsEvent{
  
}
class RequestSubciptionsEvent extends SubscriptionsEvent{
  final RequestSubscriptionBody requestSubscriptionBody;

 const RequestSubciptionsEvent(this.requestSubscriptionBody);
}




class GetMySubscriptionEvent extends SubscriptionsEvent{

}


class GetSubscriptionsPaymentsEvent extends SubscriptionsEvent{
  final String subcriptionId;
  final String fromDate;
  final String toDate;
    final String status;

  const GetSubscriptionsPaymentsEvent(this.subcriptionId, this.fromDate, this.toDate, this.status);
}