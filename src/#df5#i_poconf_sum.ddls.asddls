@AbapCatalog.sqlViewName: '/DF5/IPOCONFSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'IF calculating the sum of quantities'
define view /DF5/I_POCONF_SUM
  as select from /DF5/I_POCONF_HEAD
{

  key Ebeln                                as PurchaseOrder,
  key PurchaseOrderItem,
  sum( ekes_menge ) as TotalConfirmed
}
group by
  Ebeln,
  PurchaseOrderItem
//    SupplierConfirmation
