@AbapCatalog.sqlViewName: '/DF5/IEKETDELDAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transpose to one eket line closest date'
define view /DF5/I_EKET_DELDATE
  as select from eket
    inner join   /DF5/P_EKET_TF as _NearestDate on  _NearestDate.PurchaseOrder     = eket.ebeln
                                                and _NearestDate.PurchaseOrderLine = eket.ebelp
                                                and _NearestDate.Date              = eket.eindt
{
  ebeln         as PurchaseOrder,
  ebelp         as PurchaseOrderLine,
  eindt         as DelDate,
  max(uniqueid) as UniqueID
}
group by
  ebeln,
  ebelp,
  eindt
