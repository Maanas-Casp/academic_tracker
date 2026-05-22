# Academic Tracker

A comprehensive, role-based academic management system built with PHP, MySQL, and Bootstrap 5. Academic Tracker simplifies the administrative workload of schools and universities by streamlining attendance, grading, and activity tracking for students, teachers, parents, and administrators.

## Features

- **Role-Based Access Control:** Distinct interfaces and permissions for Admin, Teacher, Student, and Parent.
- **Attendance Management:** Teachers can mark daily attendance; admins can view history, and students/parents can monitor individual attendance logs.
- **Grade Management:** Easy entry of test scores by teachers with automated max score calculations, alongside comprehensive grade reporting.
- **Activity Log Tracking:** Real-time visibility of student performance and recent actions across the system.
- **Class & Subject Organization:** Admins can structure the academic year with sections, grade levels, and customized subjects.
- **Modern UI:** Responsive, clean, and intuitive interface powered by Bootstrap 5 and FontAwesome.

## Tech Stack

- **Backend:** PHP (Vanilla)
- **Database:** MySQL
- **Frontend:** HTML5, CSS3, JavaScript, Bootstrap 5
- **Icons:** FontAwesome, Bootstrap Icons

## Setup Instructions

### Prerequisites
- A web server (like Apache or Nginx) with PHP 7.4 or higher installed.
- MySQL server.

### Local Installation

1. **Clone the repository:**
   ```bash
   git clone <your-repository-url>
   cd academic_tracker
   ```

2. **Database Setup:**
   - Create a MySQL database (e.g., `academic_tracker`).
   - Import the provided `database.sql` file into your MySQL database to create the required tables and initial seed data:
     ```bash
     mysql -u root -p academic_tracker < database.sql
     ```

3. **Configure the application:**
   - Open `config.php`.
   - Update the database credentials to match your local setup:
     ```php
     define('DB_HOST', 'localhost');
     define('DB_USER', 'your_database_user'); // e.g., 'root'
     define('DB_PASS', 'your_database_password');
     define('DB_NAME', 'academic_tracker');
     ```

4. **Run the Application:**
   - If you're using XAMPP/MAMP/WAMP, move the project folder to the `htdocs` or `www` directory and navigate to `http://localhost/academic_tracker` in your browser.
   - Alternatively, use PHP's built-in web server:
     ```bash
     php -S localhost:8000
     ```
     Then, open `http://localhost:8000` in your web browser.

### Default Credentials
Upon importing the database script, a default admin user is generated:
- **Username:** `admin`
- **Password:** `password`

*Note: Please change the admin password immediately upon your first login.*

## CI/CD Pipeline

This project uses **GitHub Actions** for Continuous Integration and Continuous Deployment.

The pipeline is defined in `.github/workflows/ci-cd.yml` and consists of two main jobs:

1. **Lint (CI):** 
   Runs automatically on pushes to the `main` branch. It checks all `.php` files for syntax errors using `php -l`. This ensures no syntactically broken code is deployed.
2. **Deploy (CD):** 
   If the Lint job succeeds, the pipeline establishes an SSH connection to an AWS EC2 instance (using `appleboy/ssh-action`) and pulls the latest changes from the `main` branch, restarting the web service automatically.

To configure the deployment, set the following secrets in your GitHub repository:
- `EC2_HOST`
- `EC2_USERNAME`
- `EC2_SSH_KEY`
