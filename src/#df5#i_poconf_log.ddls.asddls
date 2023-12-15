@AbapCatalog.sqlViewName: '/DF5/IPOCONFLOG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Log handle messages'
define view /DF5/I_POCONF_LOG
  as select from /df5/db_poco

  association to parent /DF5/I_POCONF_ID as _header on  _header.actionid      = $projection.zactionid
                                                    and _header.purchaseorder = $projection.purchaseorder
{
  key zactionid,
  key purchaseorder,
  key zlogid,
      ztype,
      znumber,
      zmessage,
      zlog_no,
      zlog_msg_no,
      zmessage_v1,
      zmessage_v2,
      zmessage_v3,
      zmessage_v4,
      zparameter,
      zrow,
      zfield,
      zsystem,
      
      /* Associations */
      _header
}
