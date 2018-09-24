/*******************************************************************************************************
1. Write a query to display the name, product line, and buy price of all products. The output columns 
should display as “Name”, “Product Line”, and “Buy Price”. The output should display the most expensive 
items first.
********************************************************************************************************/

select productName as "Name",
productLine as "Product Line",
buyPrice as "Buy Price"
from products
order by buyPrice desc;                               /*order price by decending to show highest buy price first*/



/*******************************************************************************************************
2. Write a query to display the first name, last name, and city for all customers from Germany. Columns 
should display as “First Name”, “Last Name”, and “City”. The output should be sorted by the customer’s 
last name (ascending).
********************************************************************************************************/

select contactFirstName as 'First Name',
contactLastName as 'Last Name',
city as 'City'
from customers
where country='Germany'                                   /* list only name and city who lives in Germany*/
order by contactLastName;                                 /* Sort by  customer last name by ascending */



/*******************************************************************************************************
3. Write a query to display each of the unique values of the status field in the orders table. The 
output should be sorted alphabetically increasing. Hint: the output should show exactly 6 rows.
********************************************************************************************************/

select distinct Status                                  /* distinct gives unique values of status column*/
from orders
order by status;                                        /* sort by alaphabetically increasing */



/*******************************************************************************************************
4. Select all fields from the payments table for payments made on or after January 1, 2005. Output 
should be sorted by increasing payment date.
********************************************************************************************************/

select * from payments 
where 
date_format(paymentDate,"%Y-%m-%d") >= "2005-01-01"     /*covert date to YYYY-mm-dd format
													     for comparing paymentDate with the given date */
order by date_format(paymentDate,"%Y-%m-%d");           /* sort by increasing payment date */




/*******************************************************************************************************
5. Write a query to display all Last Name, First Name, Email and Job Title of all employees working 
out of the San Francisco office. Output should be sorted by last name.
********************************************************************************************************/

select e.lastName as 'Last Name',
e.firstName as 'First Name',
e.email as 'Email',
e.jobTitle as 'Job Title',o.city
from employees e join offices o                     /* equi-join */
on e.officeCode=o.officeCode                        /* join predicate for checking equal values between tables*/
where o.city!='San Francisco'                       /* office not in city San Francisco */
order by e.lastName;                                /* sort by last name */




/*******************************************************************************************************
6. Write a query to display the Name, Product Line, Scale, and Vendor of all of the car products – 
both classical and vintage. The output should display all vintage cars first (sorted alphabetically 
by name), and all classical cars last (also sorted alphabetically by name).
********************************************************************************************************/

select productName as 'Name',
productLine as 'Product Line',
productScale as 'Scale',
productVendor as 'Vendor'
from products
where productLine like '%cars'                        /*display all car products only*/
order by field(productLine,
'Vintage Cars',
'Classic Cars'),                                      /*sort by vintage cars first and then by classic cars*/
substring(productName,5,length(productName));         /* take year out and sort by alpabetically by name*/

