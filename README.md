# Monster Shop

## Background and Description

"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will automatically set the order status to "shipped". Each user role will have access to some or all CRUD functionality for application models.


### Implementation Instructions
To set up locally:
 * Clone down the repository.
 * Run `bundle install`.
 * Run `rails db:{create,migrate,seed}` to setup the database.
 * Run `rails s` and navigate your browser to `localhost:3000` to use the development database.

### Functionality By User Type

#### Visitor
A **visitor** to this website is classifed as anyone who is not currently logged in.

A visitor can:
 * visit the index of merchants,
 * visit the index of items,
 * add items to a cart,
 * view the cart,
 * both increase and decrease item quantity in cart, and;
 * can access both login and register routes.

#### User
A **user** of this website has an account created with the site

Before one can access user functionality, they must have registered with the site.  Registration requires name, full address, unique email, and matching password fields in order to complete successfully.

A user can do all of the things a visitor can do, plus:
 * user has a profile page which displays all user information (except password),
 * profile page has edit profile and change password option, and;
 * if user has any open orders, they will have a "My Orders" link to view their orders.
 
A user's order index displays the following:
 * order ID,
 * number of items within the order,
 * status of the current order,
 * total cost of the order, and;
 * created and updated dates.

If a user clicks on their order ID, the order show page displays the following:
 * includes all of the above order information, plus;
 * breakdown by item, including name, image, price, quantity, description, and subtotal, and;
 * if order has not been shipped, there is an option to cancel the order.

If a user would like to proceed with their finalized order, they have the ability to:
* go to their cart, and;
* have a checkout option that, once clicked, will empty their cart.


#### Merchant Employee
A **merchant employee** of this website includes all of the same access as a **user**, plus:

Merchant Dashboard:
 * Upon login, merchanty employee is directed to merchant dashboard instead of user profile.
 * Displays information on the merchant that the employee works for.
 * Displays open orders for items the merchant has:
    * each order displays an ID, total items for that merchant, total cost for that merchant, and the date the order was placed.
 * Also, the dashboard has links to view item index for the merchant in question.

Item Index: 
 * Displays breakdown of items for the merchant in question.
 * Able to both activate and deactivate individual items.
 * Option to delete items that have never been ordered.
 * Can create a new item, and to do so:
    * item requires a name, a price above $0, description, and an inventory greater than or equal to 0.
    * item image is optional, and a placeholder image is inserted if employee declines to add an image.
 * By going to an individual item, an employee can edit and item with the same requirements as a new item applied.

Order Show Page:
 * Displays information for order such as name, ID, shipping address, and status.
 * Provides breakdown of items this merchant has within the order.
 * Option to fulfill if there is enough inventory in stock.


#### Administrator
An **administrator** of this website has all of the same permissions as users except access to the cart.

Admin Dashboard
 * Upon login, an admin is directed to the admin dashboard instead of user profile.
 * This dashboard displays a breakdown of all orders which are sorted by packaged, pending, shipped, and cancelled.
 * Each order has a link to the user who made the order, it's ID, when it was made, current status, and a link to ship the order if fully packaged.

User Index
 *  Displays list of all user names link to their indivdual profile, their roles, and when they were created.

Merchant Index
 * To access, one must access the /admin/merchants path in their URL bar.
 * Displays merchant name with a link to their individual profile, their location, and an option to both enable or disable a merchant.
    * Enabling and disabling will activate or deactivate those merchant's items, respectively.

#### Logging Out
All types of users have access to logging out.  When any type of user logs out, they are redirected to the home page.  If there are any items in the cart, they are removed.

### Schema Design 
Below is a snapshot of this project's schema:
<img width="703" alt="Screen Shot 2020-02-27 at 3 24 06 PM" src="https://user-images.githubusercontent.com/56602822/75492749-a3a88f00-5975-11ea-9e27-a6b544800e02.png">




### Production Link
 * https://monster-shop-1911.herokuapp.com/


### Contributors
 * **Cassie Achzenick** - https://github.com/caachz
 * **Ryan Allen** - https://github.com/rcallen89
 * **Jenny Klich** - https://github.com/jklich151
 * **Jordan Sewell** - https://github.com/jrsewell400

Final project has a well written README with pictures, 
schema design - DONE (except for picture) 
code snippets - IN PROGRESS 
contributors names linked to their github profile - DONE
heroku link - DONE 
and implementation instructions - DONE
