@AbapCatalog.sqlViewName: '/DF5/IEKETDELQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transpose to one eket line closest date'
define view /DF5/I_EKET_DELDATEQTY
  as select from eket
    inner join   /DF5/I_EKET_DELDATE on  /DF5/I_EKET_DELDATE.PurchaseOrder     = eket.ebeln
                                     and /DF5/I_EKET_DELDATE.PurchaseOrderLine = eket.ebelp
                                     and /DF5/I_EKET_DELDATE.DelDate           = eket.eindt
                                     and /DF5/I_EKET_DELDATE.UniqueID          = eket.uniqueid
{
  ebeln as PurchaseOrder,
  ebelp as PurchaseOrderLine,
  eindt as DelDate,
  menge as Quantity
}
