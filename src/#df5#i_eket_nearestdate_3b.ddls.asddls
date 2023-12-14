@AbapCatalog.sqlViewName: '/DF5/IEKETNSDA3B'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Nearest date for EKET Level 3B'
define view /DF5/I_EKET_NEARESTDATE_3B
  as select from /DF5/I_EKET
{
  key Ebeln,
  key Ebelp,
      min(Eindt) as Eindt
}
where
  Eindt >= $session.system_date
group by
  Ebeln,
  Ebelp
