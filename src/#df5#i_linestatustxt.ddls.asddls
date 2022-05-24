@AbapCatalog.sqlViewName: '/DF5/I_LINESTATX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Line Status Text'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'ActionType'
@ClientHandling.algorithm: #SESSION_VARIABLE
define view /DF5/I_LINESTATUSTXT
  as select from /df5/db_linesttx
{
  key line_status     as LineStatus,
      @Semantics.language: true
  key language        as Language,
      @Semantics.text: true
      line_status_txt as LineStatusTxt
}
