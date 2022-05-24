@EndUserText.label: 'Log Po creations'
@AccessControl.authorizationCheck: #CHECK
define view entity /DF5/C_POCONF_LOG
  as projection on /DF5/I_POCONF_LOG
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
      _header : redirected to parent /DF5/C_POCONF_ID
}
