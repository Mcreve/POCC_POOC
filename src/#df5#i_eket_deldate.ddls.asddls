@AbapCatalog.sqlViewName: '/DF5/IEKETDELDAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transpose to one eket line closest date'
define view /DF5/I_EKET_DELDATE
  as select from /DF5/I_EKET             as _eket
    inner join   /DF5/I_EKET_NEARESTDATE as _NearestDate on  _eket.Ebeln = _NearestDate.PurchaseOrder
                                                         and _eket.Ebelp = _NearestDate.PurchaseOrderline
                                                         and _eket.Eindt = _NearestDate.ItemDeliveryDate
{
  Ebeln         as PurchaseOrder,
  Ebelp         as PurchaseOrderLine,
  Eindt         as DelDate,
  max(Uniqueid) as UniqueID
}
group by
  Ebeln,
  Ebelp,
  Eindt
