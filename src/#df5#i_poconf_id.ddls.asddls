@AbapCatalog.sqlViewName: '/DF5/IPOCONFID'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for PO Confirmation actions'
define view /DF5/I_POCONF_ID
  as select from /df5/db_pcid
  association to parent /DF5/I_ACTIONID    as _Action on _Action.actionid = $projection.actionid
  composition [0..*] of /DF5/I_POCONF_LIST as _Lines
  composition [0..*] of /DF5/I_POCONF_LOG  as _Log
{
  key purchaseorder,
  key actionid,
      created_by,
      created_on,
      _Lines,
      _Log,
      _Action
}
