/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2022 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: AP Trial Balance
-- Description: Application: Payables
Source: Accounts Payable Trial Balance
Short Name: APTBRPT
DB package: XLA_TB_AP_REPORT_PVT
-- Excel Examle Output: https://www.enginatics.com/example/ap-trial-balance/
-- Library Link: https://www.enginatics.com/reports/ap-trial-balance/
-- Run Report: https://demo.enginatics.com/

with xtb as 
(select 
   xtbg.*
  from 
   ( &P_TEMPLATE_SQL_STATEMENT
     &P_SQL_STATEMENT
   ) xtbg
),
aptb_trx as (select 
   'Transaction' record_type,
   xtb.ledger_id,
   xtb.ledger_name,
   xtb.ledger_short_name,
   xtb.ledger_currency_code currency,
   xtb.account account,
   xtb.code_combination_id,
   to_number(null) gl_balance,
   to_number(null) other_sources_amount,
   to_number(null) subledger_manuals_amount,
   to_number(null) difference,
   xtb.third_party_name,
   xtb.third_party_number,
   xtb.source_entity_id transaction_id,
   xtb.source_trx_type transaction_type,
   xtb.source_trx_number transaction_number,
   to_date(xtb.source_trx_gl_date,'YYYY-MM-DD') gl_date,
   xtb.user_trx_identifier_value_7 payment_status,
   xtb.user_trx_identifier_value_9 cancelled_date,
   xtb.src_acctd_rounded_orig_amt transaction_original_amount,
   xtb.src_acctd_rounded_rem_amt transaction_remaining_amount
  from 
   xtb),
aptb_acc as (select 
   'GL Account' record_type,
   xtb.ledger_id,
   xtb.ledger_name,
   xtb.ledger_short_name,
   xtb.ledger_currency_code currency,
   xtb.account,
   xtb.code_combination_id,
   xtb.gl_balance,
   xtb.non_ap_amount other_sources_amount,
   xtb.manual_sla_amount subledger_manuals_amount,
   nvl(xtb.gl_balance,0) - ( nvl(xtb.non_ap_amount,0) + nvl(xtb.manual_sla_amount,0) + nvl(sum(xtb.src_acctd_rounded_rem_amt),0) ) difference,
   null third_party_name,
   null third_party_number,
   null transaction_id,
   null transaction_type,
   null transaction_number,
   to_date(null) gl_date,
   null payment_status,
   null cancelled_date,
   to_number(null) transaction_original_amount,
   to_number(null) transaction_remaining_amount
  from 
   xtb
  group by 
   xtb.ledger_id,
   xtb.ledger_name,
   xtb.ledger_short_name,
   xtb.ledger_currency_code,
   xtb.account,
   xtb.gl_balance,
   xtb.non_ap_amount,
   xtb.manual_sla_amount,
   xtb.code_combination_id)
--
-- Main Query Starts Here
--
select 
 aptb.record_type
,aptb.ledger_name
,aptb.account
,aptb.third_party_name
,aptb.third_party_number
,aptb.currency
,aptb.gl_balance
,aptb.other_sources_amount
,aptb.subledger_manuals_amount
,aptb.transaction_remaining_amount
,aptb.difference 
,aptb.transaction_type
,aptb.transaction_number
,aptb.transaction_original_amount
,aptb.gl_date
,aptb.payment_status
,aptb.cancelled_date
&gcc_segment_columns
from 
 (select 
   aptb_trx.*
  from 
   aptb_trx
  union all 
  select 
   aptb_acc.*
  from 
   aptb_acc) aptb,
 gl_code_combinations_kfv gcck
where
 gcck.code_combination_id (+) = aptb.code_combination_id 
order by 
 aptb.ledger_name,
 aptb.account nulls last,
 aptb.third_party_name nulls last,
 aptb.third_party_number nulls last,
 aptb.transaction_id nulls last,
 aptb.gl_date nulls last