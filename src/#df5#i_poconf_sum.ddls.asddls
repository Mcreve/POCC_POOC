@AbapCatalog.sqlViewName: '/DF5/IPOCONFSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'IF calculating the sum of quantities'
define view /DF5/I_POCONF_SUM
  as select from /DF5/I_POCONF_HEAD
{

  key ebeln             as PurchaseOrder,
  key PurchaseOrderItem,
      //key SupplierConfirmation,
      sum( ekes_menge ) as TotalConfirmed
}
group by
  ebeln,
  PurchaseOrderItem
//    SupplierConfirmation
