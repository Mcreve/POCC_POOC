@AbapCatalog.sqlViewName: '/DF5/I_LINESTAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Line Status'
define view /DF5/I_LINESTATUS
  as select from /df5/db_linestat
  association [0..*] to /DF5/I_LINESTATUSTXT as _Text on $projection.LineStatus = _Text.LineStatus
{
      @ObjectModel.text.association: '_Text'
  key line_status as LineStatus,
      _Text
}
