import '../input_validation.dart';
import '../local_server.dart';
import '../model/order_record.dart';
import '../model/payment_method_record.dart';
import '../model/service_record.dart';
import '../slot_schedule.dart';
import 'resolver_context.dart';

// Root field resolvers. They return the GraphQL shape as maps - this is the
// only place in the project maps exist, and contract tests prove they fit the
// generated client types.

final Map<String, FieldResolver> queryResolvers = <String, FieldResolver>{
  'services': (ResolverContext context) async => <Object?>[
    for (final ServiceRecord service in context.server.services)
      service.toResponse(),
  ],
  'availableSlots': (ResolverContext context) async {
    final int days = parseDays(context.arguments['days']);
    return <Object?>[
      for (final (SlotWindow window, bool available) in context.server.slots(
        days,
      ))
        window.toResponse(available: available),
    ];
  },
  'paymentMethods': (ResolverContext context) async {
    final String userId = context.requireUser();
    return <Object?>[
      for (final PaymentMethodRecord card in context.server.paymentMethodsFor(
        userId,
      ))
        card.toResponse(),
    ];
  },
  'order': (ResolverContext context) async {
    final String userId = context.requireUser();
    final String orderId = parseId(context.arguments['id'], argument: 'id');
    final OrderRecord? order = await context.server.findOrder(
      userId: userId,
      orderId: orderId,
    );
    return order?.toResponse();
  },
};

final Map<String, FieldResolver> mutationResolvers = <String, FieldResolver>{
  'createOrder': (ResolverContext context) async {
    final String userId = context.requireUser();
    final CreateOrderResult result = await context.server.createOrder(
      userId: userId,
      input: parseCreateOrderInput(context.arguments['input']),
    );
    return <String, Object?>{
      '__typename': 'CreateOrderPayload',
      'order': result.order.toResponse(),
      'replayed': result.replayed,
    };
  },
};

final Map<String, SubscriptionResolver> subscriptionResolvers =
    <String, SubscriptionResolver>{
      'orderUpdated': (ResolverContext context) {
        final String userId = context.requireUser();
        final String orderId = parseId(context.arguments['id'], argument: 'id');
        return context.server
            .watchOrder(userId: userId, orderId: orderId)
            .map((OrderRecord order) => order.toResponse());
      },
    };
