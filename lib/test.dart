enum OrderStatus {
  open(10),
  confirmed(20),
  completed(30),
  cancelled(40);

  final int progress;
  const OrderStatus(this.progress);

  bool operator <(OrderStatus status) => progress < status.progress;
  bool operator >(OrderStatus status) => progress > status.progress;
}

void main() {
  var status = OrderStatus.open;
  if (status < OrderStatus.completed) {
    print('The order has not completed');
  }
}