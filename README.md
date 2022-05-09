# Overview
As a large multi-national company with hundreds of thousands of employees it is imperative that Pewlett-Hackard (PH) has a good understanding of their employee base and where those employees are at in their career. Without this understanding the company could be caught off guard if a large portion of their workforce, say the baby boomer generation, all decide to retire around the same time, leaving them with a potentially huge gap to fill.

We worked with Bobby to pull data from various PH employee databases to run an analysis on who is potentially coming due for retirement, based on their age and the nationally recognized retirement age of around 65 years old. 

## Results
To run our analysis we took informatoin from various databases and created tables using PostGres and manipulated those tables in pgAdmin by running various SQL queries to get the information we needed. Below are the results of our analysis. 


1. Of the 300k employees at PH, there are 72,459 emplopyees who are coming into retirement age (based on birth date between 1952 and 1955, representing close to a quarter of the entire company workforce (24%). PH has some work to do on the hiring front in order to ensure a continuity of service.
2. Of the 72k employees entering retirement age, 57% of them (n = 41,380) have been working for PH since at least 1988, meaning that not only is PH potentially about to lose a large portion of their workforce, but they are also looking at a loss of about 14% of their most seasoned employees. This could potentially leave a significant knowledge gap in certain departments. 
3. The concern noted above is further proven out when looking at a breakdown of the titles of the potential retirees. Seventy percent of those coming into retirement age have "Senior" in their title (Senior Staff, Senior Engineer). It will be important for PH to start to level-up their junior staff. 
4. To fill that gap we also ran an analysis of who may be eligible to become mentors to the junior staff by pulling out current staff members born in 1965. This gave us 1,549 employees we could potentially tap for this program. 


## Sumary
Below are the two big questions PH will need to answer in the near future and some analysis we ran to help try and answer them.

### How many roles will need to be filled as the "silver tsunami" begins to make an impact?
PH will need to fill approximately 72,459 roles over the coming years, but we also wanted to look into which departments would be most impacted by the "silver tsunami" so we created a table of retiring employees and got a count of how many in each department. The top three departments slated to have the most retirees are Development, Production and Sales - accounting for 63% of all retirees. Development alone is looking to lose 25% of their workforce when this group retires. (See retirees_by_dept.csv)

### Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?
If the intention is for there to be a 1:1 relationship of mentor to mentee then there are not nearly enough mentors for this program. With 1,549 potential mentors and 72,459 potential job openings that is only 2% coverage. PH will need to try and tap as many of their potential retirees to also be mentors as they get closer to retiring. 

We dug a little deeper to find those employees on our Mentorship Eligibility table and isolated only those born in 1965 who have Senior in their title, as these folks may be best suited to level-up the junior staff. This analysis gave us 1,098 senior staff who could potentially act as mentors to our junior staff (see senior_staff_mentors.csv for this list). While these folks may be better mentors, it further winnows our pool of mentors when we really need more, not less. 



