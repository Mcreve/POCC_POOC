@AbapCatalog.sqlViewName: '/DF5/IEKETNRSDAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Nearest date for EKET'
define view /DF5/I_EKET_NEARESTDATE
  as select from /DF5/I_EKET
{
  key Ebeln      as PurchaseOrder,
  key Ebelp      as PurchaseOrderline,
  min(Eindt) as ItemDeliveryDate
}
where
  Eindt >= $session.system_date
group by
  Ebeln,
  Ebelp
union select from /DF5/I_EKET_NEARESTDATE_2
{
  key PurchaseOrder,
  key PurchaseOrderLine,
  max(ItemDeliveryDate) as ItemDeliveryDate
}
group by
  PurchaseOrder,
  PurchaseOrderLine
