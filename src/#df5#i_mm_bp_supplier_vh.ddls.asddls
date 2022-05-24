@AbapCatalog.sqlViewName: '/DF5/IBPSUPPLVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Business Partner Supplier Value help'
@ObjectModel.dataCategory: #VALUE_HELP
@Search.searchable: true
@ObjectModel.semanticKey: ['Supplier', 'CompanyCode']
@ObjectModel.representativeKey: 'Supplier'
@ClientHandling.algorithm: #SESSION_VARIABLE
define view /DF5/I_MM_BP_SUPPLIER_VH
  as select from I_Supplier as Supplier
  association [0..*] to /DF5/I_MM_BUSPART_SUPPL_CO    as _BusinessPartnerSuplrCo      on $projection.Supplier = _BusinessPartnerSuplrCo.Supplier
  association [1..1] to I_Supplier_to_BusinessPartner as _Supplier_to_BusinessPartner on $projection.Supplier = _Supplier_to_BusinessPartner.Supplier
  association [0..*] to I_CountryText                 as _CountryText                 on $projection.Country = _CountryText.Country
{

      @ObjectModel.text.element:  [ 'SupplierName' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 1.0 }
  key Supplier.Supplier                                                 as Supplier,

      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.8 }
  key _BusinessPartnerSuplrCo.CompanyCode                               as CompanyCode,

      @Semantics.text: true
      Supplier.SupplierName                                             as SupplierName,

      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
      @Semantics.address.country: true
      // commented since re-generation of gateway project is necessary
      //         @ObjectModel.text.association: '_CountryText'
      @UI.textArrangement: #TEXT_ONLY
      Supplier._StandardAddress.Country                                 as Country,

      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
      Supplier._StandardAddress.CityName                                as CityName,

      Supplier._StandardAddress.PostalCode                              as PostalCode,

      Supplier._StandardAddress.Region                                  as Region,

      @UI.hidden: true
      @Search: { defaultSearchElement: true, ranking: #LOW, fuzzinessThreshold: 0.8 }
      Supplier.SortField                                                as SortField,

      @UI.hidden: true
      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
      _Supplier_to_BusinessPartner._BusinessPartner.FirstName           as FirstName,

      @UI.hidden: true
      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
      _Supplier_to_BusinessPartner._BusinessPartner.LastName            as LastName,

      @UI.hidden: true
      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
      _Supplier_to_BusinessPartner._BusinessPartner.OrganizationBPName1 as OrganizationBPName1,

      @UI.hidden: true
      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
      _Supplier_to_BusinessPartner._BusinessPartner.OrganizationBPName2 as OrganizationBPName2,

      @UI.hidden: true
      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
      _Supplier_to_BusinessPartner._BusinessPartner.OrganizationBPName3 as OrganizationBPName3,

      @UI.hidden: true
      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.8 }
      _Supplier_to_BusinessPartner._BusinessPartner.OrganizationBPName4 as OrganizationBPName4,

      //for DCL
      @UI.hidden: true
      Supplier.AuthorizationGroup,
      @UI.hidden: true
      Supplier.SupplierAccountGroup,
      @UI.hidden: true
      @Consumption.filter.hidden: true
      @Consumption.hidden: true
      Supplier.IsBusinessPurposeCompleted,

      @ObjectModel.foreignKey.association: '_BusinessPartnerSuplrCo'
      _BusinessPartnerSuplrCo,
      _CountryText
}
