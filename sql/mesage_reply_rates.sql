select country_code, role, vertical
  ,thread_creation_date, week_start_date, current_date_sameday, runDate, runWeek
  ,thread_type, thread_type_definition
  ,count(distinct case when members_in_thread > 1 then message_thread_id end) as threads_with_reply
  ,count(distinct case when members_in_thread = 1 then message_thread_id end) as threads_wo_reply
  ,count(distinct message_thread_id) as thread_count
from (
  select msg.country_code, m.role
  ,date(msg.date_created) as thread_creation_date
  ,ddd.week_start_date
  ,dc.current_date_sameday
  ,current_date() as runDate
  ,ddd2.week_start_date as runWeek
  ,case 
    when m.vertical = 'homeCare' then 'Housekeeping' 
    when m.role is not null and (m.vertical IS NULL or m.vertical = '') then 'Childcare' 
    else initcap(lower(m.vertical))
  end as vertical
  ,msg.message_thread_id, msg.owner_id, msg.other_member_id, msg.system_message_id as thread_type
  ,case
    when msg.system_message_id = 1 then '(1) Bookmark'
    when msg.system_message_id = 2 then '(2) Job Application'
    when msg.system_message_id = 3 then '(3) No response'
    when msg.system_message_id = 4 then '(4) Yes response'
    when msg.system_message_id = 5 then '(5) Rating'
    when msg.system_message_id = 6 then '(6) Say Hello'
    when msg.system_message_id = 7 then '(7) Undetermined'
    when msg.system_message_id = 8 then '(8) Custom text'
    when msg.system_message_id = 9 then '(9) Question'
    when msg.system_message_id = 10 then '(10) Quote Accepted'
    when msg.system_message_id = 11 then '(11) Quote Rejected'
    when msg.system_message_id is null then '(0) Manual'
    else 'Unknown'
  end as thread_type_definition
  ,count(distinct fr.owner_id) as members_in_thread
  --,case when re.id is null then 0 else 1 end as reply_received
  from intl.message msg
    --Only include message threads that have at least 1 received message (confirmation that the first message was received)
    join intl.message fr on fr.message_thread_id = msg.message_thread_id and fr.country_code = msg.country_code and fr.sent_received = 'RECEIVED' and fr.pending is not true and fr.status in ('ACTIVE','INACTIVE')
    --Role/vertical of the thread owner (initial sender)
    join intl.hive_member m on m.memberid = msg.owner_id and m.countrycode = msg.country_code and m.isinternalaccount is not true and m.closedforfraud is not true
      --exclude welome emails
      and m.memberid not in (8549466,8549532,8549506,8549677,8396072,8549511,8550318,8549692,8549537,8549512,8549472,8549516,8549611,8549760,8549761,8549508)
    --Dates
    join reporting.dw_d_date ddd on ddd.date = date(msg.date_created) and ddd.date < current_date() and ddd.year >= 2020
    join reporting.dw_d_date ddd2 on ddd2.date = current_date()
    join analytics.dw_d_date_current dc on dc.date = date(msg.date_created)
  --Starting point: The intial message in thread
  where date(msg.date_created) >= '2020-01-01' and msg.first_message is true
  group by 1,2,3,4,5,6,7,8,9,10,11,12,13
) t group by 1,2,3,4,5,6,7,8,9,10
