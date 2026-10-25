import 'model/service_record.dart';

/// The catalogue the server starts with. Prices are ZAR cents.
const List<ServiceRecord> seedServices = <ServiceRecord>[
  ServiceRecord(
    id: 'svc-regular-clean',
    name: 'Regular clean',
    description: 'Kitchen, bathrooms, floors and surfaces.',
    priceCents: 45000,
    durationMinutes: 180,
  ),
  ServiceRecord(
    id: 'svc-deep-clean',
    name: 'Deep clean',
    description: 'Every room top to bottom, inside cupboards and appliances.',
    priceCents: 125000,
    durationMinutes: 240,
  ),
  ServiceRecord(
    id: 'svc-laundry',
    name: 'Laundry and ironing',
    description: 'Washed, dried, ironed and folded in your home.',
    priceCents: 35000,
    durationMinutes: 120,
  ),
  ServiceRecord(
    id: 'svc-windows',
    name: 'Window cleaning',
    description: 'Inside and out, frames and sills included.',
    priceCents: 40000,
    durationMinutes: 120,
  ),
  ServiceRecord(
    id: 'svc-garden',
    name: 'Garden tidy-up',
    description: 'Lawn, edges and beds, with green waste taken away.',
    priceCents: 55000,
    durationMinutes: 180,
  ),
  ServiceRecord(
    id: 'svc-carpets',
    name: 'Carpets and upholstery',
    description: 'Steam clean for carpets, rugs and couches.',
    priceCents: 90000,
    durationMinutes: 180,
  ),
];
