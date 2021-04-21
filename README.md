
![Unable to load image](https://github.com/rishabh-soni/Library_Management_System/blob/master/static/images/logohorizontal.png?raw=true)
## HoneyComb Library Management System
This is an interactive web application to manage an offline Library.

## Project Requirements (for local hosting)
* Python 3.8
* MySQL server and MySQL Workbench (recommended 8.0 and above)
* Git

### To run the project on local server,
* Clone the remote reopsitory on your system.
* Install all the dependencies by running the command **pip install -r requirements.txt**
* Create a new connection in MySQL Workbench and import the database from database.sql file in the **/sqldump** directory.
* Run the command **python manage.py makemigrations**
* Run the command **python manage.py migrate**
* Run the command **python manage.py runserver** and browse the corresponding URL provided.
* Create a user in MySQL Workbench with the name **dbadmin** and leave the password field blank.
* Granting all permissions to the user.
