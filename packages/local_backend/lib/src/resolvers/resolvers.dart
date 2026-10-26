import '../input_validation.dart';
import '../local_server.dart';
import '../model/order_record.dart';
import '../model/payment_method_record.dart';
import '../model/service_record.dart';
import '../slot_schedule.dart';
import 'resolver_context.dart';

// Root field resolvers. They return the GraphQL shape as maps - the only place
// in the project maps exist. Contract tests prove they fit the generated types.

final Map<String, FieldResolver> queryResolvers = <String, FieldResolver>{
  'services': (ResolverContext context) async => <Object?>[
    for (final ServiceRecord service in context.server.services)
      service.toResponse(),
  ],
  'availableSlots': (ResolverContext context) async => <Object?>[
    for (final SlotWindow slot in context.server.slots(
      parseDays(context.arguments['days']),
    ))
      slot.toResponse(),
  ],
  'paymentMethods': (ResolverContext context) async {
    context.requireUser();
    return <Object?>[
      for (final PaymentMethodRecord card in context.server.paymentMethods)
        card.toResponse(),
    ];
  },
  'order': (ResolverContext context) async {
    context.requireUser();
    final OrderRecord? order = await context.server.findOrder(
      parseId(context.arguments['id'], argument: 'id'),
    );
    return order?.toResponse();
  },
};

final Map<String, FieldResolver> mutationResolvers = <String, FieldResolver>{
  'createOrder': (ResolverContext context) async {
    final CreateOrderResult result = await context.server.createOrder(
      userId: context.requireUser(),
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
        context.requireUser();
        return context.server
            .watchOrder(parseId(context.arguments['id'], argument: 'id'))
            .map((OrderRecord order) => order.toResponse());
      },
    };
