--test lab test cases retrieval
 select count(tc.tc_test_id)
 from cycl_fold s, cycle c, testcycl tc
 where
 s.cf_father_id = 216 and
c.cy_cycle_id = tc.tc_cycle_id and
s.cf_item_id = c.cy_folder_id

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

--query to retrieve manual testcases in automation test suite
 select count(*)
 from cycl_fold s, cycle c, testcycl tc, test t
 where
s.cf_father_id = 216 and
c.cy_cycle_id = tc.tc_cycle_id and
s.cf_item_id = c.cy_folder_id   and
t.ts_test_id = tc.tc_test_id and t.ts_user_21 <> 'Automated'

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


------
SELECT     *
FROM cycl_fold
where    cf_item_name = 'AutomationScript_By_BusinessStrategy'




SELECT T.TS_TEST_ID,T.TS_NAME,T.TS_USER_02,T.TS_USER_03,T.TS_USER_04,T.TS_STATUS FROM TEST T, TESTCYCL TC,CYCLE C
WHERE 
C.cY_FOLDER_ID = FolderId and
TC.TC_CYCLE_ID = C.CY_CYCLE_ID and
T.TS_TEST_ID = Tc.TC.TC_TEST_ID


SELECT T.TS_TEST_ID,T.TS_NAME,DS.DS_STEP_NAME,DS.DS_DESCRIPTION,DS.DS_EXPECTED FROM TEST T, DESSTEPS DS WHERE T.TS_SUBJECT  = 59947 AND  DS.DS_TEST_ID = T.TS_TEST_ID   

compliance
SELECT CY_CYCLE,CY_CYCLE_ID,CY_VTS
FROM CYCLE WHERE NOT(
(REGEXP_LIKE(CY_CYCLE,'_NF_') AND CY_USER_06 = 'New Functionality')
OR
(REGEXP_LIKE(CY_CYCLE,'_RT_') AND CY_USER_06 = 'Regression' )) AND CY_VTS>='2011-07-01 00:00:00' ORDER BY CY_VTS DESC
