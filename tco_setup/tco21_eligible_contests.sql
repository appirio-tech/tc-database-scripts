-- This script needs to run on the oltp01 database server. Login as informix and add it under /home/informix/cron_scripts/tco/ and
-- update the crontab to run the script every 5 minutes. (crontab -e)

set lock mode to wait 5;

-- DEVELOPMENT

-- Stage 1
insert into contest_project_xref
SELECT 723, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-07-01 00:00:00.000' and pp.actual_start_time <  '2020-10-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi13 ON p.project_id = pi13.project_id and pi13.project_info_type_id = 13 and (pi13.value = 'Yes' or p.project_category_id = 39) -- Code challenges are included even if not rated
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1
WHERE p.project_status_id = 1
   and p.project_category_id in (7,14,39) -- exclude UI Prototype track as well
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (723, 722)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407) -- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
-- and p.project_id not in (30070720, 30070724, 30070725, 30070727) -- IBM Hackathon Challenges to be excluded
-- and mod(p.project_id, 2) = 0

   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and not exists (SELECT 1 FROM comp_technology 
               --    WHERE comp_vers_id = pi1.value AND technology_type_id = 78) -- exclude QA Challenges from Dev
                    WHERE comp_vers_id = pi1.value AND technology_type_id in (78,481,482,483,27621212)) -- exclude QA/QA - Regression/QA - Hunt/QA - Test Case Writing/Data Science Challenges from Dev
   and 1 = 1; 

-- Stage 2
insert into contest_project_xref
SELECT 724, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-10-01 00:00:00.000' and pp.actual_start_time <  '2021-01-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi13 ON p.project_id = pi13.project_id and pi13.project_info_type_id = 13 and (pi13.value = 'Yes' or p.project_category_id = 39) -- Code challenges are included even if not rated
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1
WHERE p.project_status_id = 1
   and p.project_category_id in (7,14,39) -- exclude UI Prototype track as well
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (724, 722)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407) -- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and not exists (SELECT 1 FROM comp_technology 
               --     WHERE comp_vers_id = pi1.value AND technology_type_id = 78) -- exclude QA Challenges from Dev
                WHERE comp_vers_id = pi1.value AND technology_type_id in (78,481,482,483,27621212)) -- exclude QA/QA - Regression/QA - Hunt/QA - Test Case Writing/Data Science Challenges from Dev
   and 1 = 1; 


-- Stage 3
insert into contest_project_xref
SELECT 725, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-01-01 00:00:00.000' and pp.actual_start_time <  '2021-04-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi13 ON p.project_id = pi13.project_id and pi13.project_info_type_id = 13 and (pi13.value = 'Yes' or p.project_category_id = 39) -- Code challenges are included even if not rated
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82  
LEFT OUTER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1
WHERE p.project_status_id = 1
   and p.project_category_id in (7,14,39) -- exclude UI Prototype track as well
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (725, 722)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407) -- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
--   and p.project_id not in (30128882) --excluding practice contest
   and not exists (SELECT 1 FROM comp_technology 
                 --   WHERE comp_vers_id = pi1.value AND technology_type_id = 78) -- exclude QA Challenges from Dev
                  WHERE comp_vers_id = pi1.value AND technology_type_id in (78,481,482,483,27621212)) -- exclude QA/QA - Regression/QA - Hunt/QA - Test Case Writing/Data Science Challenges from Dev
   and 1 = 1;

-- Stage 4
insert into contest_project_xref
SELECT 726, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-04-01 00:00:00.000' and pp.actual_start_time <  '2021-07-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi13 ON p.project_id = pi13.project_id and pi13.project_info_type_id = 13 and (pi13.value = 'Yes' or p.project_category_id = 39) -- Code challenges are included even if not rated
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82  
LEFT OUTER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1
WHERE p.project_status_id = 1
   and p.project_category_id in (7,14,39) -- exclude UI Prototype track as well
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (726, 722)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407) -- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
--   and p.project_id not in (30128882) --excluding practice contest
   and not exists (SELECT 1 FROM comp_technology 
                 --   WHERE comp_vers_id = pi1.value AND technology_type_id = 78) -- exclude QA Challenges from Dev
                  WHERE comp_vers_id = pi1.value AND technology_type_id in (78,481,482,483,27621212)) -- exclude QA/QA - Regression/QA - Hunt/QA - Test Case Writing/Data Science Challenges from Dev
   and 1 = 1;   

   
   
-- QA Track Challenges

-- Stage 1
insert into contest_project_xref
SELECT 718, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-07-01 00:00:00.000' and pp.actual_start_time <  '2020-10-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
-- INNER JOIN project_info pi13 ON p.project_id = pi13.project_id and pi13.project_info_type_id = 13 and pi13.value = 'Yes' --This seems No for Bug Hunts
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82

WHERE p.project_status_id = 1
   and 
   ( 
    p.project_category_id in (9,13) -- include Bug Hunt and Test Suites always
     OR 
     exists (SELECT 1 FROM comp_technology 
                    WHERE comp_vers_id = pi1.value AND technology_type_id in (78,481,482,483)) -- if the challlenge is tagged as QA/QA - Regression/QA - Hunt/QA - Test Case Writing
   )  
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (718, 717)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
--   and p.project_id not in (30108180) --excluding practice contest
   and 1 = 1; 


-- Stage 2
insert into contest_project_xref
SELECT 719, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-10-01 00:00:00.000' and pp.actual_start_time <  '2021-01-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
-- INNER JOIN project_info pi13 ON p.project_id = pi13.project_id and pi13.project_info_type_id = 13 and pi13.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
INNER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
WHERE p.project_status_id = 1
   and 
   ( 
     p.project_category_id in (9,13) -- include Bug Hunt and Test Suites always
     OR 
     exists (SELECT 1 FROM comp_technology 
                    WHERE comp_vers_id = pi1.value  
                    AND technology_type_id in (78,481,482,483)) -- if the challlenge is tagged as QA/QA - Regression/QA - Hunt/QA - Test Case Writing
   )   
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (719, 717)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1; 

-- Stage 3
insert into contest_project_xref
SELECT 720, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-01-01 00:00:00.000' and pp.actual_start_time <  '2021-04-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
--INNER JOIN project_info pi13 ON p.project_id = pi13.project_id and pi13.project_info_type_id = 13 and pi13.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
INNER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1

LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
WHERE p.project_status_id = 1
    and 
   ( 
     p.project_category_id in (9,13) -- include Bug Hunt and Test Suites always
     OR 
     exists (SELECT 1 FROM comp_technology 
                    WHERE comp_vers_id = pi1.value 
                    AND technology_type_id in (78,481,482,483)) -- if the challlenge is tagged as QA/QA - Regression/QA - Hunt/QA - Test Case Writing
   )   
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (720, 717)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1;

-- Stage 4
insert into contest_project_xref
SELECT 721, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-04-01 00:00:00.000' and pp.actual_start_time <  '2021-07-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
--INNER JOIN project_info pi13 ON p.project_id = pi13.project_id and pi13.project_info_type_id = 13 and pi13.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
INNER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1

LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
WHERE p.project_status_id = 1
    and 
   ( 
     p.project_category_id in (9,13) -- include Bug Hunt and Test Suites always
     OR 
     exists (SELECT 1 FROM comp_technology 
                    WHERE comp_vers_id = pi1.value 
                    AND technology_type_id = in (78,481,482,483)) -- if the challlenge is tagged as QA/QA - Regression/QA - Hunt/QA - Test Case Writing
   )   
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (721, 717)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1;   



-- DESIGN

-- Stage 1
insert into contest_project_xref
SELECT 713, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-07-01 00:00:00.000' and pp.actual_start_time <  '2020-10-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
WHERE p.project_status_id = 1
   and p.project_category_id in (16, 17, 20, 21, 30, 32, 34)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (713, 712)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1; 

-- Stage 2
insert into contest_project_xref
SELECT 714, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-10-01 00:00:00.000' and pp.actual_start_time <  '2021-01-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
WHERE p.project_status_id = 1
   and p.project_category_id in (16, 17, 20, 21, 30, 32, 34)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (714, 712)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1; 

-- Stage 3
insert into contest_project_xref
SELECT 715, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-01-01 00:00:00.000' and pp.actual_start_time <  '2021-04-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
WHERE p.project_status_id = 1
   and p.project_category_id in (16, 17, 20, 21, 30, 32, 34)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (715, 712)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
 --  and p.project_id not in (30129083) --excluding practice contest
   and 1 = 1; 

-- Stage 4

insert into contest_project_xref
SELECT 716, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-04-01 00:00:00.000' and pp.actual_start_time <  '2021-07-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
WHERE p.project_status_id = 1
   and p.project_category_id in (16, 17, 20, 21, 30, 32, 34)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (716, 712)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
 --  and p.project_id not in (30129083) --excluding practice contest
   and 1 = 1; 

   
-- F2F

-- Stage 1
insert into contest_project_xref
SELECT 708, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-07-01 00:00:00.000' and pp.actual_start_time <  '2020-10-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1

WHERE p.project_status_id = 1
   and p.project_category_id in (38,40)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (708, 707)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
--   and mod(p.project_id, 2) = 0
   and not exists (SELECT 1 FROM comp_technology 
               --  WHERE comp_vers_id = pi1.value AND technology_type_id = 78) -- exclude QA Challenges from F2F
                   WHERE comp_vers_id = pi1.value AND technology_type_id in (78,27621212)) -- exclude QA/Data Science Challenges from F2F 
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1;

-- Stage 2
insert into contest_project_xref
SELECT 709, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-10-01 00:00:00.000' and pp.actual_start_time <  '2021-01-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1

WHERE p.project_status_id = 1
   and p.project_category_id in (38,40)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (709, 707)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks 
   and p.tc_direct_project_id not in (16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and not exists (SELECT 1 FROM comp_technology 
                --    WHERE comp_vers_id = pi1.value AND technology_type_id = 78) -- exclude QA Challenges from F2F
                    WHERE comp_vers_id = pi1.value AND technology_type_id in (78,27621212)) -- exclude QA/Data Science Challenges from F2F 
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1=1;

-- Stage 3
insert into contest_project_xref
SELECT 710, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-01-01 00:00:00.000' and pp.actual_start_time <  '2021-04-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1
WHERE p.project_status_id = 1
   and p.project_category_id in (38,40)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (710, 707)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and not exists (SELECT 1 FROM comp_technology 
                  --  WHERE comp_vers_id = pi1.value AND technology_type_id = 78) -- exclude QA Challenges from F2F
                    WHERE comp_vers_id = pi1.value AND technology_type_id in (78,27621212)) -- exclude QA/Data Science Challenges from F2F 
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1;
   
-- Stage 4

insert into contest_project_xref
SELECT 711, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-04-01 00:00:00.000' and pp.actual_start_time <  '2021-07-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1  ON pi1.project_id  = p.project_id and pi1.project_info_type_id = 1
WHERE p.project_status_id = 1
   and p.project_category_id in (38,40)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (711, 707)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
-- and mod(p.project_id, 2) = 0
   and not exists (SELECT 1 FROM comp_technology 
                  --  WHERE comp_vers_id = pi1.value AND technology_type_id = 78) -- exclude QA Challenges from F2F
                    WHERE comp_vers_id = pi1.value AND technology_type_id in (78,27621212)) -- exclude QA/Data Science Challenges from F2F 
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1;


-- MM
--As per community team, Challenges tagged with Data Science are removed from Marathon Match tag. 
--They will  be counted for data science leaderboards for tco21

-- Stage 1
insert into contest_project_xref
SELECT 728, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-07-01 00:00:00.000' and pp.actual_start_time <  '2020-10-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1 ON pi1.project_id = p.project_id and pi1.project_info_type_id = 1 
WHERE p.project_status_id = 1
   and 
   --(
       p.project_category_id in (37) -- include marathon matches always
   --    OR
   --    exists (SELECT 1 FROM comp_technology
   --                WHERE comp_vers_id = pi1.value AND technology_type_id = 27621212) -- if the challlenge is tagged as Data Science
   --)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (728,727)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
   and p.tc_direct_project_id not in ( 26910 ) --USBR Streamflow Forecasting challenges to be excluded 
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and p.project_id not in ( 30138384 ) --excluding as per support ticket 67942
   and p.project_id not in ( 30137832 ) --excluding as per support Ticket 68709
   and p.project_id not in ( 30143561 ) --excluding as per support ticket 69965
   and 1 = 1; 

-- Stage 2
insert into contest_project_xref
SELECT 729, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-10-01 00:00:00.000' and pp.actual_start_time <  '2021-01-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1 ON pi1.project_id = p.project_id and pi1.project_info_type_id = 1 
WHERE p.project_status_id = 1
   and 
   --(
       p.project_category_id in (37) -- include marathon matches always
   --    OR
   --    exists (SELECT 1 FROM comp_technology
   --                WHERE comp_vers_id = pi1.value AND technology_type_id = 27621212) -- if the challlenge is tagged as Data Science
   --)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (729,727)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
   and p.tc_direct_project_id not in ( 26910 ) --USBR Streamflow Forecasting challenges to be excluded
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and p.project_id not in (30145483) --excluding as per support ticket 71633
   and p.project_id not in (30153848) --excluding as per support ticket 75389
   --comment
--  and p.project_id not in ( 30114809, 30116975, 30116520 ) --excluding specific challenge
   and 1 = 1; 

-- Stage 3
insert into contest_project_xref
SELECT 730, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-01-01 00:00:00.000' and pp.actual_start_time <  '2021-04-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1 ON pi1.project_id = p.project_id and pi1.project_info_type_id = 1 
WHERE p.project_status_id = 1
   and
   --(
       p.project_category_id in (37) -- include marathon matches always
   --    OR
   --    exists (SELECT 1 FROM comp_technology
   --                WHERE comp_vers_id = pi1.value AND technology_type_id = 27621212) -- if the challlenge is tagged as Data Science
   --) 
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (730,727)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
   and p.tc_direct_project_id not in ( 26910 ) --USBR Streamflow Forecasting challenges to be excluded
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
--   and p.project_id not in (30129332) --excluding practice contest
   and 1 = 1; 
   
-- Stage 4
insert into contest_project_xref
SELECT 731, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-04-01 00:00:00.000' and pp.actual_start_time <  '2021-07-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1 ON pi1.project_id = p.project_id and pi1.project_info_type_id = 1 
WHERE p.project_status_id = 1
   and
   --(
       p.project_category_id in (37) -- include marathon matches always
   --    OR
   --    exists (SELECT 1 FROM comp_technology
   --                WHERE comp_vers_id = pi1.value AND technology_type_id = 27621212) -- if the challlenge is tagged as Data Science
   --) 
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (731,727)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
   and p.tc_direct_project_id not in ( 26910 ) --USBR Streamflow Forecasting challenges to be excluded
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
--   and p.project_id not in (30129332) --excluding practice contest
   and 1 = 1; 


-- Data Science
--As per community team, Challenges with category code and tagged with Data Science 
--are only counted in Data Science leaderboard

--Stage 1

insert into contest_project_xref
SELECT 733, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-07-01 00:00:00.000' and pp.actual_start_time <  '2020-10-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1 ON pi1.project_id = p.project_id and pi1.project_info_type_id = 1 
WHERE p.project_status_id = 1
   and 
   --(
       p.project_category_id in (39) -- include code matches always
	   and
       exists (SELECT 1 FROM comp_technology
                   WHERE comp_vers_id = pi1.value AND technology_type_id = 27621212) -- to check if the challlenge is tagged as Data Science
   --)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (733,732)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
   and p.tc_direct_project_id not in ( 26910 ) --USBR Streamflow Forecasting challenges to be excluded 
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1; 


   --Stage 2

   insert into contest_project_xref
SELECT 734, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2020-10-01 00:00:00.000' and pp.actual_start_time <  '2021-01-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1 ON pi1.project_id = p.project_id and pi1.project_info_type_id = 1 
WHERE p.project_status_id = 1
   and 
   --(
       p.project_category_id in (39) -- include code matches always
	   and
       exists (SELECT 1 FROM comp_technology
                   WHERE comp_vers_id = pi1.value AND technology_type_id = 27621212) -- to check if the challlenge is tagged as Data Science
   --)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (734,732)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
   and p.tc_direct_project_id not in ( 26910 ) --USBR Streamflow Forecasting challenges to be excluded 
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1; 


   --Stage 3

   insert into contest_project_xref
SELECT 735, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-01-01 00:00:00.000' and pp.actual_start_time <  '2021-04-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1 ON pi1.project_id = p.project_id and pi1.project_info_type_id = 1 
WHERE p.project_status_id = 1
   and 
   --(
       p.project_category_id in (39) -- include code matches always
	   and
       exists (SELECT 1 FROM comp_technology
                   WHERE comp_vers_id = pi1.value AND technology_type_id = 27621212) -- to check if the challlenge is tagged as Data Science
   --)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (735,732)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
   and p.tc_direct_project_id not in ( 26910 ) --USBR Streamflow Forecasting challenges to be excluded 
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1; 


--Stage 4

insert into contest_project_xref
SELECT 736, p.project_id, current
FROM project p
INNER JOIN project_phase pp ON p.project_id = pp.project_id and pp.phase_type_id = 1 and
                               pp.actual_start_time >= '2021-04-01 00:00:00.000' and pp.actual_start_time <  '2021-07-01 00:00:00.000'
INNER JOIN project_info pi12 ON p.project_id = pi12.project_id and pi12.project_info_type_id = 12 and pi12.value = 'Yes'
INNER JOIN project_info pi14 ON p.project_id = pi14.project_id and pi14.project_info_type_id = 14 and pi14.value = 'Open'
LEFT OUTER JOIN project_info pi82 ON pi82.project_id = p.project_id and pi82.project_info_type_id = 82
LEFT OUTER JOIN project_info pi1 ON pi1.project_id = p.project_id and pi1.project_info_type_id = 1 
WHERE p.project_status_id = 1
   and 
   --(
       p.project_category_id in (39) -- include code matches always
	   and
       exists (SELECT 1 FROM comp_technology
                   WHERE comp_vers_id = pi1.value AND technology_type_id = 27621212) -- to check if the challlenge is tagged as Data Science
   --)
   and p.project_id not in (select project_id from contest_project_xref where contest_id in (736,732)) -- make sure we exclude from tco
   and NVL(pi82.value, 0) = 0 -- No TCO if these are tasks
   and p.tc_direct_project_id not in (8943, 16411, 16412, 16413, 16406, 16399, 16407)-- exclude projects for fun and university challenges
   and p.tc_direct_project_id not in ( 22249 ) --Rodeo Challenges to be excluded
   and p.tc_direct_project_id not in ( 26910 ) --USBR Streamflow Forecasting challenges to be excluded 
-- and mod(p.project_id, 2) = 0
   and p.project_id not in (select ce.contest_id from contest_eligibility ce) --excluding private challenges
   and 1 = 1; 
   