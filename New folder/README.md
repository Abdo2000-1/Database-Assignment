# The Creative Media Production & Equipment Hub

## 🎥 Project Overview
This project is a comprehensive management system designed for a digital media agency. It coordinates large-scale video production projects by tracking creative professionals, specialized studios, high-end equipment, and production sessions.

The system was developed as a team project for the Database Systems course, focusing on database design, normalization, and raw SQL implementation using C#.

## 🚀 Key Features
* **Professional Management:** Registering directors, cinematographers, and editors with their technical skills.
* **Studio Tracking:** Managing specialized rooms (green-screen, sound-recording) and their availability.
* **Project Coordination:** Tracking production budgets, titles, and delivery deadlines.
* **Session Scheduling:** Coordinating production dates, studio assignments, and professional teams.
* **Equipment Hub:** Tracking high-end gear (cameras, lighting) by serial number and monitoring return conditions.

## 🛠️ Tech Stack
* **Language:** C#
* **Framework:** .NET / WPF
* **Database:** Microsoft SQL Server 2017+
* **Design Tools:** Sybase PowerDesigner (CDM/PDM)
* **API:** ADO.NET (No ORM used, as per project requirements)

## 📂 Project Structure
* `crebas.sql`: Database definition and population script (DDL/DML).
* `6Inquiry.sql`: Complex SQL inquiries for business analysis.
* `DatabaseHelper.cs`: Core database connection and command execution logic.
* `MainWindow.xaml.cs`: Application GUI and logic.
* `ConceptualDataModel.cdm` & `PhysicalDataModel.pdm`: Database design models.

## ⚙️ Setup & Installation
1. **Database Setup:**
   * Open SQL Server Management Studio (SSMS).
   * Create a new database named `MediaProduction`.
   * Open and execute the `crebas.sql` file to create tables and insert sample data.
2. **Application Configuration:**
   * Open the solution in Visual Studio.
   * Navigate to `DatabaseHelper.cs`.
   * Update the `connectionString` with your local SQL Server instance details:
     ```csharp
     private readonly string connectionString = @"Data Source=YOUR_SERVER_NAME;Initial Catalog=MediaProduction;Integrated Security=True";
     ```
3. **Run:**
   * Build and run the project (F5).

## 📊 SQL Inquiries Included
The system provides answers to specific business questions, including:
1. Identifying the most in-demand technical skills.
2. Tracking projects with no sessions in the last month.
3. Identifying top professionals managing the widest variety of equipment.
4. Monitoring studio utilization and idle time.
5. Tracking specific equipment usage per project.

## 👥 Contributors
* **Team Members:** Zyad Reda & Team
* **Lab TA:** Lamiaa Atef
