# Monster Shop

# Monster Shop Extensions - Bulk Discount


## Instructions

* Fork this repository or use your existing project.
* Clone your fork if you have forked.
* When you are finished, push your code to your fork. (if you have forked)

## Bulk Discount

#### General Goals

Merchants add bulk discount rates for all of their inventory. These apply automatically in the shopping cart, and adjust the order_items price upon checkout.

#### Completion Criteria

1. Merchants need full CRUD functionality on bulk discounts, and will be accessed a link on the merchant's dashboard.
1. You will implement a percentage based discount: 
   - 5% discount on 20 or more items
1. A merchant can have multiple bulk discounts in the system.
1. When a user adds enough value or quantity of a single item to their cart, the bulk discount will automatically show up on the cart page.
1. A bulk discount from one merchant will only affect items from that merchant in the cart.
1. A bulk discount will only apply to items which exceed the minimum quantity specified in the bulk discount. (eg, a 5% off 5 items or more does not activate if a user is buying 1 quantity of 5 different items; if they raise the quantity of one item to 5, then the bulk discount is only applied to that one item, not all of the others as well)
1. When there is a conflict between two discounts, the greater of the two will be applied. 

#### Mod 2 Learning Goals reflected:
- Database relationships and migrations
- Advanced ActiveRecord
- Software Testing



---

# Additional Extensions

##  Users have multiple addresses

#### General Goal

Users will have more than one address associated with their profile. Each address will have a nickname like "home" or "work". Users will choose an address when checking out.

#### Completion Criteria

1. When a user registers they will still provide an address, this will become their first address entry in the database and nicknamed "home".
1. Users need full CRUD ability for addresses from their Profile page.
1. An address cannot be deleted or changed if it's been used in a "shipped" order.
1. When a user checks out on the cart show page, they will have the ability to choose one of their addresses where they'd like the order shipped.
1. If a user deletes all of their addresses, they cannot check out and see an error telling them they need to add an address first. This should link to a page where they add an address.
1. If an order is still pending, the user can change to which address they want their items shipped.

#### Implementation Guidelines

1. Existing tests should still pass. Since you will need to make major changes to your database schema, you will probably break **many** tests. It's recommended that you focus on the completion criteria described above before going back and refactoring your code so that your existing tests still work.
1. Every order show page should display the chosen shipping address.
1. Statistics related to city/state should still work as before.

---

## Merchant To-Do List

#### General Goals

Merchant dashboards will display a to-do list of tasks that need their attention.

#### Completion Criteria

1. Merchants should be shown a list of items which are using a placeholder image and encouraged to find an appropriate image instead; each item is a link to that item's edit form.
1. Merchants should see a statistic about unfulfilled items and the revenue impact. eg, "You have 5 unfulfilled orders worth $752.86"
1. Next to each order on their dashboard, Merchants should see a warning if an item quantity on that order exceeds their current inventory count.
1. If several orders exist for an item, and their summed quantity exceeds the Merchant's inventory for that item, a warning message is shown.

#### Implementation Guidelines

1. Make sure you are testing for all happy path and sad path scenarios.

#### Mod 2 Learning Goals reflected:

- MVC and Rails development
- Database relationships and migrations
- ActiveRecord
- Software Testing

# Rubric

| | **Feature Completeness**                                                                                                   | **Rails** | **ActiveRecord** | **Testing and Debugging**                                                                                                                                                                                               | 
| --- | ---------------------------------------------------------------------------------------------------------------------------| --- | --- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **4: Exceptional**  | One or more additional extension features complete.                                                                        | Students implement strategies not discussed in class to effectively organize code and adhere to MVC. | Highly effective and efficient use of ActiveRecord beyond what we've taught in class. Even `.each` calls will not cause additional database lookups. | Very clear Test Driven Development. Test files are extremely well organized and nested. Students utilize `before :each` blocks. 100% coverage for features and models                                                   | 
| **3: Passing** | Bulk discount feature 100% complete, including most sad paths and edge cases                                               | Students use the principles of MVC to effectively organize code. Students can defend any of their design decisions. | ActiveRecord is used in a clear and effective way to read/write data using no Ruby to process data. | 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. All preexisting tests still pass. TDD Process is clear throughout commits. Sad paths and edge cases are covered in testing. |
| **2: Passing with Concerns** | One of the completion criteria for Coupon Codes feature is not complete or fails to handle a big sad path or edge case     | Students utilize MVC to organize code, but cannot defend some of their design decisions. Or some functionality is not limited to the appropriately authorized users. | Ruby is used to process data that could use ActiveRecord instead. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective. Missing sad path or edge case testing.                                | 
| **1: Failing** | More than one of the completion criteria for Coupon Code feature is not complete or fails to handle a sad path or edge case| Students do not effectively organize code using MVC. Or students do not authorize users. | Ruby is used to process data more often than ActiveRecord | Below 90% coverage for either features or models. TDD was not used.                                                                                                                                                     | 








## Background and Description

"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will automatically set the order status to "shipped". Each user role will have access to some or all CRUD functionality for application models.


### Implementation Instructions
To set up locally:
 * Clone down the repository.
 * Run `bundle install`.
 * Run `rails db:{create,migrate,seed}` to setup the database.
 * Run `rails s` and navigate your browser to `localhost:3000` to use the development database.

### Functionality By User Type

### Visitor
A **visitor** to this website is classifed as anyone who is not currently logged in.

**Visitors** can:
 * visit the index of merchants,
 * visit the index of items,
 * add items to a cart,
 * view the cart,
 * both increase and decrease item quantity in cart, and;
 * can access both login and register routes.

### User
A **user** of this website has an account created with the site

Before one can access user functionality, they must have registered with the site.  Registration requires name, full address, unique email, and matching password fields in order to complete successfully.
<img width="782" alt="Screen Shot 2020-02-27 at 6 47 12 PM" src="https://user-images.githubusercontent.com/54481094/75502984-9bf6e380-5991-11ea-8559-4780cead0682.png">

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


### Merchant Employee
A **merchant employee** of this website includes all of the same access as a **user**, plus:

**Merchant Dashboard**
<img width="940" alt="Screen Shot 2020-02-27 at 6 52 55 PM" src="https://user-images.githubusercontent.com/54481094/75503299-8d5cfc00-5992-11ea-9d1c-4c1376b68257.png">
 * Upon login, merchanty employee is directed to merchant dashboard instead of user profile.
 * Displays information on the merchant that the employee works for.
 * Displays open orders for items the merchant has:
    * each order displays an ID, total items for that merchant, total cost for that merchant, and the date the order was placed.
 * Also, the dashboard has links to view item index for the merchant in question.

**Item Index** 
<img width="938" alt="Screen Shot 2020-02-27 at 6 58 19 PM" src="https://user-images.githubusercontent.com/54481094/75503573-31df3e00-5993-11ea-90fb-ad53818e5259.png">
 * Displays breakdown of items for the merchant in question.
 * Able to both activate and deactivate individual items.
 * Option to delete items that have never been ordered.
 * Can create a new item, and to do so:
    * item requires a name, a price above $0, description, and an inventory greater than or equal to 0.
    * item image is optional, and a placeholder image is inserted if employee declines to add an image.
 * By going to an individual item, an employee can edit and item with the same requirements as a new item applied.


**Order Show Page**

<img width="549" alt="Screen Shot 2020-02-27 at 7 02 27 PM" src="https://user-images.githubusercontent.com/54481094/75503796-eed19a80-5993-11ea-9fb8-a52d33310b6a.png"><img width="555" alt="Screen Shot 2020-02-27 at 7 03 55 PM" src="https://user-images.githubusercontent.com/54481094/75503809-f8f39900-5993-11ea-986a-51392df33173.png">

 * Displays information for order such as name, ID, shipping address, and status.
 * Provides breakdown of items this merchant has within the order.
 * Option to fulfill if there is enough inventory in stock.


### Administrator
An **administrator** of this website has all of the same permissions as users except access to the cart.

**Admin Dashboard**
<img width="1337" alt="Screen Shot 2020-02-27 at 6 38 08 PM" src="https://user-images.githubusercontent.com/54481094/75502776-0fe4bc00-5991-11ea-94b8-f568858ceaaa.png">
 * Upon login, an admin is directed to the admin dashboard instead of user profile.
 * This dashboard displays a breakdown of all orders which are sorted by packaged, pending, shipped, and cancelled.
 * Each order has a link to the user who made the order, it's ID, when it was made, current status, and a link to ship the order if fully packaged.


**User Index**
<img width="1003" alt="Screen Shot 2020-02-27 at 6 49 04 PM" src="https://user-images.githubusercontent.com/54481094/75504786-ad8eba00-5996-11ea-98e4-aebdb3505cde.png">
 *  Displays list of all user names link to their indivdual profile, their roles, and when they were created.


**Merchant Index**
<img width="994" alt="Screen Shot 2020-02-27 at 6 50 26 PM" src="https://user-images.githubusercontent.com/54481094/75503194-36efbd80-5992-11ea-897e-cc763570b115.png">
 * To access, one must enter the /admin/merchants path in their URL bar.
 * Displays merchant name with a link to their individual profile, their location, and an option to both enable or disable a merchant.
    * Enabling and disabling will activate or deactivate those merchant's items, respectively.


### Logging Out
All types of users have access to logging out.  When any type of user logs out, they are redirected to the home page.  If there are any items in the cart, they are removed.


### Schema Design 
Below is a diagram of this project's schema as well as the corresponding code:
![schema](https://user-images.githubusercontent.com/54481094/75502868-51756700-5991-11ea-9e60-99618154b7ea.png)


<img width="545" alt="Screen Shot 2020-02-27 at 7 11 22 PM" src="https://user-images.githubusercontent.com/54481094/75504343-6d7b0780-5995-11ea-8b28-49b2b40a4406.png"><img width="545" alt="Screen Shot 2020-02-27 at 7 12 41 PM" src="https://user-images.githubusercontent.com/54481094/75504362-7c61ba00-5995-11ea-955c-857dcc8f6f31.png">



### Production Link
 * https://monster-shop-1911.herokuapp.com/


### Contributors
 * **Cassie Achzenick** - https://github.com/caachz
 * **Ryan Allen** - https://github.com/rcallen89
 * **Jenny Klich** - https://github.com/jklich151
 * **Jordan Sewell** - https://github.com/jrsewell400
