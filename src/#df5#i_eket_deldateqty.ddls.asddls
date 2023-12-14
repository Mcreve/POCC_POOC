@AbapCatalog.sqlViewName: '/DF5/IEKETDELQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transpose to one eket line closest date'
define view /DF5/I_EKET_DELDATEQTY
  as select from /DF5/I_EKET         as _eket
    inner join   /DF5/I_EKET_DELDATE as _eket_deldate on  _eket.Ebeln    = _eket_deldate.PurchaseOrder
                                                      and _eket.Ebelp    = _eket_deldate.PurchaseOrderLine
                                                      and _eket.Eindt    = _eket_deldate.DelDate
                                                      and _eket.Uniqueid = _eket_deldate.UniqueID
{
  Ebeln                                     as PurchaseOrder,
  Ebelp                                     as PurchaseOrderLine,
  Eindt                                     as DelDate,
  Menge                                     as Quantity,
  cast( Menge - Wemng as abap.quan(13, 3) ) as QuantityToBeDelivered
}
