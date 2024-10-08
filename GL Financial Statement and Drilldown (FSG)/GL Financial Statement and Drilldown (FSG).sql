/*************************************************************************/
/*                                                                       */
/*                       (c) 2010-2024 Enginatics GmbH                   */
/*                              www.enginatics.com                       */
/*                                                                       */
/*************************************************************************/
-- Report Name: GL Financial Statement and Drilldown (FSG)
-- Description: GL Financial Statement and Drilldown report offers the capability to generate reports on balances and delve into specific details. It allows for the linking of Excel cells to Oracle data through provided functions, enabling users to refresh the data as needed for the latest provided information. Furthermore, users can execute drilldown actions to access information at the balance, journal, and subledger levels.

Do not delete the sheet ""Financial Statement Generator" and do not modify the Advanced Custom Properties of the excel output.
-- Excel Examle Output: https://www.enginatics.com/example/gl-financial-statement-and-drilldown-fsg/
-- Library Link: https://www.enginatics.com/reports/gl-financial-statement-and-drilldown-fsg/
-- Run Report: https://demo.enginatics.com/

select
:period_name period_name,
:balance_type balance_type,
:average_balance_type average_balance_type,
:template_name,
:actual_flag actual_flag,
:ledger ledger_name,
:budget_name budget_name,
:currency_code currency_code,
:currency_type,
:conversion_type,
:amount_type,
:encumbrance_type encumbrance_type,
:account_type account_type,
:movement movement,
:translated_flag translated_flag,
:gl_segments gl_segments,
:gl_segments_cb gl_segments_cb,
:get_balance_function get_balance_function,
:balance_drilldown_function balance_drilldown_function,
:expand_segment_function expand_segment_function,
:period_offset_function period_offset_function,
:hierarchy_name,
:custom_properties,
:default_hierarchy,
:gl_segment,
:gl_segment_value,
:next_segment_value,
:discover_period_name,
:daily_rates,
:period_year,
:period_num,
:journal_source,
:journal_category,
:gl_segment1 gl_segment1,
:gl_segment2 gl_segment2,
:gl_segment3 gl_segment3,
:gl_segment4 gl_segment4,
:gl_segment5 gl_segment5,
:gl_segment6 gl_segment6,
:gl_segment7 gl_segment7,
:gl_segment8 gl_segment8,
:gl_segment9 gl_segment9,
:gl_segment10 gl_segment10,
:gl_segment11,
:gl_segment12,
:gl_segment13,
:gl_segment14,
:gl_segment15,
:gl_segment16,
:gl_segment17,
:gl_segment18,
:gl_segment19,
:gl_segment20,
:create_lov create_lov,
:responsibility_name responsibility_name,
:responsibility_key,
:gl_journal_drilldown,
:gl_subledger_details,
:gl_full_journal_drilldown,
:gl_journal_attachment_dd,
:drilldown_resp
from
dual
where
1=1