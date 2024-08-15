--create a join table
select * from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r on
a.Reason_for_absence = r.Number;

--find the healthiest employees for the bonus
select * from Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0
and Body_mass_index < 25 and 
Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)


--compensation rate increase for non-smokers / budget is $983,221 so $0.68 increase per hour or $1414.40 per year
select count(*) as nonsmokers from Absenteeism_at_work
where Social_smoker = 0

--optimize this query
select a.ID,
r.Reason,
Body_mass_index,
CASE WHEN Body_mass_index < 18.5 then 'Underweight'
	 WHEN Body_mass_index between 18.5 and 25 then 'Healthy Weight'
	 WHEN Body_mass_index between 25 and 30 then 'Overweight'
	 WHEN Body_mass_index > 30 then 'Obese'
	 ELSE 'Unknown' END as BMI_Category,
Month_of_absence,
CASE WHEN Month_of_absence IN (12,1,2) Then 'Winter'
     WHEN Month_of_absence IN (3,4,5) Then 'Spring'
	 WHEN Month_of_absence IN (6,7,8) Then 'Summer'
	 WHEN Month_of_absence IN (9,10,11) Then 'Fall'
	 ELSE 'Unknown' END as Season_Names,
Month_of_absence,
CASE WHEN Month_of_absence = 1 Then 'January'
     WHEN Month_of_absence = 2 Then 'February'
	 WHEN Month_of_absence = 3 Then 'March'
	 WHEN Month_of_absence = 4 Then 'April'
	 WHEN Month_of_absence = 5 Then 'May'
	 WHEN Month_of_absence = 6 Then 'June'
	 WHEN Month_of_absence = 7 Then 'July'
	 WHEN Month_of_absence = 8 Then 'August'
	 WHEN Month_of_absence = 9 Then 'September'
	 WHEN Month_of_absence = 10 Then 'October'
	 WHEN Month_of_absence = 11 Then 'November'
	 WHEN Month_of_absence = 12 Then 'December'
	 ELSE 'Unknown' END as Month_Names,
Day_of_the_week,
Transportation_expense,
Education,
Son,
Social_drinker,
Social_smoker,
CASE WHEN Social_smoker = 1 Then 'Smoker'
	 WHEN Social_smoker = 0 Then 'Non-smoker'
	 ELSE 'Unknown' END as Smoking_Status,
Pet,
Disciplinary_failure,
Age,
Work_load_Average_day,
Absenteeism_time_in_hours
from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r on
a.Reason_for_absence = r.Number;

--comparing smokers to reasons just for fun
select * from Absenteeism_at_work
where Social_smoker = 1