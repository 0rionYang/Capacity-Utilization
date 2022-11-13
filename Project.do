********************************************************
****This code is to analyze the relationship        ****
****between govn-business relationship and firms'   ****
****excess capacity.                                ****
********************************************************      

clear all
set more off
cd /Users/runjiayang/Desktop/

log using Survey, replace
use china, clear  
count 
drop if a4b>=38 // 删除服务业，仅保留制造业；

********************************
****Part 1: data management ****
********************************

 **// Y;

rename f1 capacity 
sum capacity 
replace capacity=. if capacity<=0 
**hist capacity 

rename f2 capacity2 
sum capacity2 
replace capacity2=. if capacity2<=0 
replace capacity2=capacity2/40 

 **// X1 （核心自变量）;

tab b2c 
gen gov_share=b2c  
gen court=h7a  
replace court=. if court<0  
gen regulation=j2 
replace regulation=. if regulation<0 
gen gov_contract=1 if j6a==1
replace gov_contract=0 if gov_contract==. 
gen gift2=j7a 
replace gift2=0 if gift2<0 | gift2==.
gen tax1=j30a
replace tax1=. if tax1<0
gen tax2=j30b
replace tax2=. if tax2<0 
**hist b2c
**hist tax1
**hist regulation
 **// x2 (企业特征) 

gen birth_year=b6b 
replace birth_year=. if b6b<0 
tab birth_year 
gen age=2012-birth_year+1 
tab age 
**hist age 
gen capital=n6a 
replace capital=. if capital<0 
sum capital 
gen capi=log(1+capital) // 固定资产对数值； 
gen labor=log(l1) if l1>0
gen export=1 if d3b>0 | d3c>0 
replace export=0 if export==. 
**hist export
 **// x3 (其他模块) 

 //劳动市场
gen labor_regu=l30a 
replace labor_regu=0 if labor_regu<0  
gen high_school_ratio=l9b
replace high_school_ratio=0 if high_school_ratio<0  
**hist labor_regu
 //innovation 
gen new_product=1 if CNo1==1
replace new_product=0 if new_product==.  
gen RD=1 if CNo3==1
replace RD=0 if RD==.  
 
 //competition  
tab e11
gen informal=1 if e11==1
replace informal=0 if informal==.  // 代表企业是否面临不正规企业的竞争； 
tab e30 
gen competition=e30 
replace competition=0 if competition<0 // 对应于问卷15页e30； 
sum competition 
hist competition
 //finance 
gen loan_ratio=k3bc  
replace loan_ratio=0 if loan_ratio<0  
gen if_loan=1 if k8==1
replace if_loan=0 if if_loan==.  
gen obs_finance=k30 
replace obs_finance=. if obs_finance<0  
 
 **//Basic results 

 //Table 1 
xi: reg capacity i.a3a i.a4b age labor export gov_share, vce(robust)  //(1)    

xi: reg capacity i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation, vce(robust)  //(2)  

xi: reg capacity i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation labor_regu high_school_ratio, vce(robust)  //(3)   
 
xi: reg capacity i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation new_product RD, vce(robust)  //(4)   

xi: reg capacity i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation informal competition, vce(robust)  //(5)   

xi: reg capacity i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation loan_ratio if_loan obs_finance, vce(robust)  //(6)   
 
xi: reg capacity i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation labor_regu high_school_ratio new_product RD informal competition loan_ratio if_loan obs_finance, vce(robust)  //(7)  
 
 //Table 2  
xi: reg capacity2 i.a3a i.a4b age labor export gov_share, vce(robust)  //(1)    

xi: reg capacity2 i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation, vce(robust)  //(2)  

xi: reg capacity2 i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation labor_regu high_school_ratio, vce(robust)  //(3)   
 
xi: reg capacity2 i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation new_product RD, vce(robust)  //(4)   

xi: reg capacity2 i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation informal competition, vce(robust)  //(5)   

xi: reg capacity2 i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation loan_ratio if_loan obs_finance, vce(robust)  //(6)   
 
xi: reg capacity2 i.a3a i.a4b age labor export gov_share gov_contract tax1 court regulation labor_regu high_school_ratio new_product RD informal competition loan_ratio if_loan obs_finance, vce(robust)  //(7)  


























     










































































clear all 
log close 


// It is done!!! Oh Yeah! 



