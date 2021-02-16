select a.al_description as "FolderName",t.ts_name as "Test Name",t.ts_test_id as "Test Id"
from step s, run r, test t,all_lists a
where
r.rn_execution_date >= to_date('2011-03-10','yyyy-mm-dd')  and
s.st_run_id = r.rn_run_id and
t.ts_test_id = r.rn_test_id and
s.st_actual like '%Test Data Issue%'
and t.ts_name like 'IRIS%'
and t.ts_test_id = r.rn_test_id
and a.al_item_id = t.ts_subject
=====================================
select t.ts_name,r.*
from step s, run r, test t
where
r.rn_execution_date = to_date('2011-03-10','yyyy-mm-dd')  and
s.st_run_id = r.rn_run_id and
t.ts_test_id = r.rn_test_id and
s.st_actual like '%Test Data Issue%'
=====================================
select t.ts_name,r.*
from step s, run r, test t
where
r.rn_execution_date = to_date('2011-03-10','yyyy-mm-dd')  and
s.st_run_id = r.rn_run_id and
t.ts_test_id = r.rn_test_id and
s.st_actual like '%Test Data Issue%'
=====================================
select a.al_description as "FolderName",t.ts_name as "Test Name",t.ts_test_id as "Test Id"
from step s, run r, test t,all_lists a
where
r.rn_execution_date >= to_date('2011-03-10','yyyy-mm-dd')  and
s.st_run_id = r.rn_run_id and
t.ts_test_id = r.rn_test_id and
s.st_actual like '%Test Data Issue%'
and t.ts_name like 'IRIS%'
and t.ts_test_id = r.rn_test_id
and a.al_item_id = t.ts_subject
=====================================
Application.ScreenUpdating = False
qcServer = "https://qcprodweb.osd.dev.capitalone.com/qcbin/"
qcUserName = "icv122"
qcPassword = "mickeyjames12"
qcDomain = "Card"
qcProject = "Cust_Relations"
Set Sh = ActiveWorkbook.Sheets(1)

Set tdc = CreateObject("TDApiOle80.TDConnection")
tdc.InitConnection qcServer
tdc.ConnectProjectEx qcDomain, qcProject, qcUserName, qcPassword
Query = "Update cycle set cy_cycle ='ST_46126_PHT_RT_tbd' where cy_cycle = 'tbd' "
Set com = tdc.Command
com.CommandText = Query
Set RecSet = com.Execute
Set RecSet = Nothing
Set tdc = Nothing
==========================================
select
all_lists.al_description as "FolderName",
test.ts_name as "TEST CASE NAME",
test.ts_user_03 as "TEST CATEGORY",
test.ts_user_04 as "PRIORITY',
test.ts_user_21 as "TEST TYPE",
from test
where ts_subject in (
select al_item_id from all_lists where al_father_id in (
select al_item_id from all_lists where al_father_id = 3977))
==========================================
select
al.al_description,
t.ts_name,
t.ts_user_03,
ts_user_04,
ts_user_21
from test t,  all_lists al
where t.ts_subject = al. al_item_id and
al.al_father_id in  (
select al_item_id from all_lists where al_father_id = 3977)
==========================================
--test lab test cases retrieval
 select count(tc.tc_test_id)
 from cycl_fold s, cycle c, testcycl tc
 where
 s.cf_father_id = 216 and
c.cy_cycle_id = tc.tc_cycle_id and
s.cf_item_id = c.cy_folder_id
==========================================
--query to retrieve missing test cases in test lab
select count(t.ts_test_id)
 from all_lists f, test t, all_lists s
 where
f.al_father_id = 3977 and
s.al_father_id =  f.al_item_id and
t.ts_subject = s. al_item_id and
t.ts_user_21 = 'Automated' and
t.ts_user_03='Regression'  and
t.ts_test_id not in
(
 select tc.tc_test_id
 from cycl_fold s, cycle c, testcycl tc
 where
 s.cf_father_id = 216 and
c.cy_cycle_id = tc.tc_cycle_id and
s.cf_item_id = c.cy_folder_id
)
==========================================
--query to retrieve manual testcases in automation test suite
 select count(*)
 from cycl_fold s, cycle c, testcycl tc, test t
 where
s.cf_father_id = 216 and
c.cy_cycle_id = tc.tc_cycle_id and
s.cf_item_id = c.cy_folder_id   and
t.ts_test_id = tc.tc_test_id and t.ts_user_21 <> 'Automated'
==========================================
--query to retrieve duplicates
select * from test where ts_name in (
 select t.ts_name
 from all_lists f, test t, all_lists s
 where
f.al_father_id = 3977 and
s.al_father_id =  f.al_item_id and
t.ts_subject = s. al_item_id
-- and t.ts_user_21 = 'Automated' and
--t.ts_user_03='Regression'
group by t.ts_name having count(*)>1
)
==========================================
--level

select count(t.ts_test_id)
 from all_lists f, test t, all_lists s1, all_lists s2
 where
f.al_father_id = 3977 and
s1.al_father_id =  f.al_item_id and
s2.al_father_id =  s1.al_item_id and
t.ts_subject = s2. al_item_id and
t.ts_user_21 = 'Automated' and
t.ts_user_03='Regression'  and
==========================================
--Level1
select t.ts_test_id,'abc'
 from all_lists f, test t, all_lists s
 where
f.al_father_id = 3977 and
s.al_father_id =  f.al_item_id and
t.ts_subject = s. al_item_id and
t.ts_user_21 = 'Automated' and
t.ts_user_03='Regression'
union       all
  --Level2
select t.ts_test_id ,'efg'
 from all_lists f, test t, all_lists s1, all_lists s2
 where
f.al_father_id = 3977 and
s1.al_father_id =  f.al_item_id and
s2.al_father_id =  s1.al_item_id and
t.ts_subject = s2. al_item_id and
t.ts_user_21 = 'Automated' and
t.ts_user_03='Regression'
           union all
select t.ts_test_id ,'hij'
 from all_lists f, test t, all_lists s1, all_lists s2, all_lists s3
 where
f.al_father_id = 3977 and
s1.al_father_id =  f.al_item_id and
s2.al_father_id =  s1.al_item_id and
s3.al_father_id =  s2.al_item_id and
t.ts_subject = s3. al_item_id and
t.ts_user_21 = 'Automated' and
t.ts_user_03='Regression'
==========================================
SELECT     *
FROM cycl_fold
where    cf_item_name = 'AutomationScript_By_BusinessStrategy'
==========================================
Set tdc = CreateObject("TDApiOle80.TDConnection")
tdc.InitConnection qcServer
tdc.ConnectProjectEx qcDomain, qcProject, qcUserName, qcPassword
'Query = "Select ln_link_id from link where ln_bug_id = 3600"

For i = 2 To 8
lnkid = Sh.Cells(i, 1)
Query = "Update link set ln_bug_id = 3655 where ln_link_id = " & lnkid
Set com = tdc.Command
com.CommandText = Query
Set RecSet = com.Execute
Next
'For k = 1 To RecSet.RecordCount
'Sh.Cells(i, j) = RecSet(0)
'i = i + 1
'RecSet.Next
'Next
Set RecSet = Nothing
Set tdc = Nothing
