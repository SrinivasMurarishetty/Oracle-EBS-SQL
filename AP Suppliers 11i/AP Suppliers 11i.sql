/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2021 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Suppliers 11i
-- Description: AP suppliers (po vendors) including supplier sites and contact information
-- Excel Examle Output: https://www.enginatics.com/example/ap-suppliers-11i/
-- Library Link: https://www.enginatics.com/reports/ap-suppliers-11i/
-- Run Report: https://demo.enginatics.com/

select
haouv.name operating_unit,
pv.vendor_name supplier,
pv.segment1 supplier_number,
xxen_util.meaning(pv.vendor_type_lookup_code,'VENDOR TYPE',201) type,
pv.type_1099 income_tax_type,
pv.num_1099 taxpayer_id,
pv.vat_registration_num tax_registration_number,
pv0.vendor_name parent_supplier_name,
pv0.segment1 parent_supplier_number,
pv.customer_num,
pv.vat_code,
decode(pv.small_business_flag,'Y','Y') small_business_flag,
decode(pv.hold_flag,'Y','Y') hold_flag,
pv.purchasing_hold_reason,
pv.min_order_amount,
pv.price_tolerance,
pvsa.vendor_site_code site_code,
pvsa.address_line1,
pvsa.address_line2,
pvsa.address_line3,
pvsa.address_line4,
pvsa.city,
pvsa.state,
pvsa.zip,
pvsa.county,
pvsa.province,
nvl(ftv.territory_short_name,pvsa.country) country,
pvsa.area_code,
pvsa.phone,
pvsa.fax_area_code,
pvsa.fax,
pvsa.supplier_notif_method,
pvsa.email_address,
nvl(pvsa.terms_date_basis,pv.terms_date_basis) terms_date_basis,
nvl(pvsa.pay_group_lookup_code,pv.pay_group_lookup_code) pay_group,
nvl(att1.name,att0.name) payment_terms,
xxen_util.meaning(nvl(pvsa.pay_date_basis_lookup_code,pv.pay_date_basis_lookup_code),'PAY DATE BASIS',201) pay_date_basis
&contacts_columns
from
hr_all_organization_units_vl haouv,
po_vendors pv,
po_vendor_sites_all pvsa,
fnd_territories_vl ftv,
(select pvc.* from po_vendor_contacts pvc where '&show_contacts'='Y' and nvl(pvc.inactive_date,sysdate)>=sysdate) pvc,
po_vendors pv0,
ap_terms_tl att0,
ap_terms_tl att1
where
1=1 and
pv.vendor_id=pvsa.vendor_id(+) and
pvsa.org_id=haouv.organization_id(+) and
pvsa.country=ftv.territory_code(+) and
pvsa.vendor_site_id=pvc.vendor_site_id(+) and
pv.parent_vendor_id=pv0.vendor_id(+) and
pv.terms_id=att0.term_id(+) and
pvsa.terms_id=att1.term_id(+) and
att0.language(+)=userenv('lang') and
att1.language(+)=userenv('lang')