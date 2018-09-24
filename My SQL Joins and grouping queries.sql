
/**********************************************************************************************************
1. Write a query to display each customer’s name (as “Customer Name”) alongside the name of the employee
who is responsible for that customer’s orders. The employee name should be in a single “Sales Rep” column 
formatted as “lastName, firstName”. The output should be sorted alphabetically by customer name.
***********************************************************************************************************/

select c.customerName as 'Customer Name', 
Ifnull(concat(e.lastName,", ",e.firstName),'No Sales Rep') as "Sales Rep" /*concating last and first name of Sales Rep*/
from customers c join employees e                                       /* look for rows for which values are equal for both table*/
on c.salesRepEmployeeNumber=e.employeeNumber                            /* join predicate*/
order by c.customerName;                                                /*sort by customer name alphabetically*/
											                            /* added a row  at classroom									


/**********************************************************************************************************
2. Determine which products are most popular with our customers. For each product, list the 
total quantity ordered along with the total sale generated (total quantity ordered * buyPrice) 
for that product. The column headers should be “Product Name”, “Total # Ordered” and “Total Sale”. 
List the products by Total Sale descending.
***********************************************************************************************************/

select p.productName as "Product Name",
sum(od.quantityOrdered) as "Total # Ordered",
sum(od.quantityOrdered*p.buyPrice) as "Total Sales"
from products p left join                                          /* take all rows from products table*/ 
orderdetails od                                                    /*only matching rows from orderdetails table*/    
on p.productcode=od.productcode
group by  p.productName                                            /* group by each product name*/
order by sum(od.quantityOrdered*p.buyPrice) desc;                  /*sort by Total sales descending*/



/**********************************************************************************************************
3. Write a query which lists order status and the # of orders with that status.
Column headers should be “Order Status” and “# Orders”. Sort alphabetically by status.
***********************************************************************************************************/
select status as "Order Status",
count(orderNumber) as "# Orders"               /*count the number of orders*/
from orders
group by status                                /* group by status of order*/
order by status;                               /*sort by status alphabetically*/




/**********************************************************************************************************
4. Write a query to list, for each product line, the total # of products sold from that product line.
The first column should be “Product Line” and the second should be “# Sold”. Order by the second column descending.
***********************************************************************************************************/

select pl.productLine as "Product line",
sum(od.quantityOrdered) as "# Sold"
from productlines pl 
left join products p                                   /* takes all productline from productlines table*/
on(pl.productLine=p.productLine)                       /*matching rows from products table*/
left join orderdetails od                              /*all rows from resulting above 2 tables*/
on(p.productCode=od.productCode)                       /*matching rows from order details table*/
group by pl.productLine                                /*group by product line*/
order by sum(od.quantityOrdered) desc;                 /* sort by total number of products sold*/




/**********************************************************************************************************
5. For each employee who represents customers, output the total # of orders that employee’s customers have 
placed alongside the total sale amount of those orders. The employee name should be output as a single column 
named “Sales Rep” formatted as “lastName, firstName”. The second column should be titled “# Orders” and the 
third should be “Total Sales”. Sort the output by Total Sales descending. Only (and all) employees with the 
job title ‘Sales Rep’ should be included in the output, and if the employee made no sales the Total Sales 
should display as “0.00”.
***********************************************************************************************************/

select concat(e.lastName,", ",e.firstName)  
as "Sales Rep",                                                   /* concat last name and first name*/
count(Distinct(o.orderNumber)) as 
"# Orders",                                                       /* count total number of orders*/ 
FORMAT(ifnull(sum(od.quantityOrdered*od.priceEach), 0), 2)  
as "Total Sales"                                                  /*total sales and if no sales dispaly 0.00 */
from employees e 
left join customers c                                             /* takes all employees from employees table*/
on (e.employeeNumber=c.salesRepEmployeeNumber)                    /*matching customers from customers table*/
left join orders o                                                /*all rows from resulting above 2 tables*/
on(c.customerNumber=o.customerNumber)                             /*matching orders from orders table*/
left join orderdetails od                                         /*all rows from resulting above 3 tables*/
on(o.orderNumber=od.orderNumber)                                  /*matching rows from order details table*/
where e.jobTitle="Sales Rep"                                      /*check forjob title for Sales Rep*/
group by e.lastName,e.firstName                                   /* group by employees last and first name*/
order by sum(od.quantityOrdered*od.priceEach) desc;               /*sort by total sales descending*/





/**********************************************************************************************************
6. Your product team is requesting data to help them create a bar-chart of monthly sales since the 
company’s inception. Write a query to output the month (January, February, etc.), 4-digit year, and total 
sales for that month. The first column should be labeled ‘Month’, the second ‘Year’, and the third should 
be ‘Payments Received’. Values in the third column should be formatted as numbers with two decimals
– for example: 694,292.68.
***********************************************************************************************************/

select MonthName(p.paymentDate) as "Month",                  /*extracts only month in Name format*/
extract(year from p.paymentDate) as "Year",                  /*extacts year for payment date*/
format(sum(p.amount),2) as "Payments Received"               /*format the total sales with 2 decimal places*/
from payments as p
group by extract(year_month from p.paymentDate)              /*group by year and month together*/
order by  extract(year_month from p.paymentDate);            /*sort by year and month */

