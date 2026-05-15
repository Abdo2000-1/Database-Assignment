using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace MediaProductionManagementSystem
{
    public partial class Form1 : Form
    {
        private DatabaseHelper dbHelper;
        private string currentTable = "";

        public Form1()
        {
            InitializeComponent();
            dbHelper = new DatabaseHelper();
            InitializeApplicationDefaults();
        }

        private void InitializeApplicationDefaults()
        {
            // Populate Tables
            string[] tables = { "EQUIPMENT", "PROFESSIONAL", "PROJECT", "SESSION", "SESSION_EQUIP", "SKILLS", "STUDIO", "WORK_ON" };
            cboTables.Items.AddRange(tables);

            // Populate Join Queries
            cboJoins.Items.Add("1. Show Professionals with their Skills");
            cboJoins.Items.Add("2. Show Sessions with Project and Studio");
            cboJoins.Items.Add("3. Show Equipment used in Sessions");
            cboJoins.Items.Add("4. Show Professionals working on Sessions");
            cboJoins.Items.Add("5. Show Full Session Details with all related tables");

            if (cboTables.Items.Count > 0)
                cboTables.SelectedIndex = 0;

            if (cboJoins.Items.Count > 0)
                cboJoins.SelectedIndex = 0;
        }

        private void cboTables_SelectedIndexChanged(object sender, EventArgs e)
        {
            currentTable = cboTables.SelectedItem.ToString();
            SetupUIForTable(currentTable);
            LoadData();
        }

        private void SetupUIForTable(string table)
        {
            // Hide all by default
            lblCol1.Visible = txtCol1.Visible = false;
            lblCol2.Visible = txtCol2.Visible = false;
            lblCol3.Visible = txtCol3.Visible = false;
            lblCol4.Visible = txtCol4.Visible = false;
            lblCol5.Visible = txtCol5.Visible = false;

            ClearFields();

            switch (table)
            {
                case "EQUIPMENT":
                    SetField(1, "EquipmentID"); SetField(2, "Name"); SetField(3, "Type"); SetField(4, "Status");
                    break;
                case "PROFESSIONAL":
                    SetField(1, "ProfessionalID"); SetField(2, "Name"); SetField(3, "Role"); SetField(4, "Email");
                    break;
                case "PROJECT":
                    SetField(1, "ProjectID"); SetField(2, "Title"); SetField(3, "Budget"); SetField(4, "ClientName");
                    break;
                case "SESSION":
                    SetField(1, "SessionID"); SetField(2, "ProjectID"); SetField(3, "StudioID"); SetField(4, "SessionDate"); SetField(5, "Duration");
                    break;
                case "SESSION_EQUIP":
                    SetField(1, "SessionID"); SetField(2, "EquipmentID"); SetField(3, "Quantity");
                    break;
                case "SKILLS":
                    SetField(1, "SkillID"); SetField(2, "ProfessionalID"); SetField(3, "SkillName"); SetField(4, "Proficiency");
                    break;
                case "STUDIO":
                    SetField(1, "StudioID"); SetField(2, "Name"); SetField(3, "Location"); SetField(4, "Availability");
                    break;
                case "WORK_ON":
                    SetField(1, "SessionID"); SetField(2, "ProfessionalID"); SetField(3, "HoursWorked"); SetField(4, "TaskDescription");
                    break;
            }
        }

        private void SetField(int index, string labelText)
        {
            if (index == 1) { lblCol1.Text = labelText; lblCol1.Visible = txtCol1.Visible = true; }
            else if (index == 2) { lblCol2.Text = labelText; lblCol2.Visible = txtCol2.Visible = true; }
            else if (index == 3) { lblCol3.Text = labelText; lblCol3.Visible = txtCol3.Visible = true; }
            else if (index == 4) { lblCol4.Text = labelText; lblCol4.Visible = txtCol4.Visible = true; }
            else if (index == 5) { lblCol5.Text = labelText; lblCol5.Visible = txtCol5.Visible = true; }
        }

        private void btnClear_Click(object sender, EventArgs e)
        {
            ClearFields();
        }

        private void ClearFields()
        {
            txtCol1.Clear(); txtCol2.Clear(); txtCol3.Clear(); txtCol4.Clear(); txtCol5.Clear(); txtSearch.Clear();
        }

        private void btnLoadTable_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        private void LoadData()
        {
            try
            {
                if (string.IsNullOrEmpty(currentTable)) return;
                string query = $"SELECT * FROM {currentTable}";
                dgvData.DataSource = dbHelper.ExecuteQuery(query);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error loading data: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void dgvData_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                DataGridViewRow row = dgvData.Rows[e.RowIndex];
                if (txtCol1.Visible && row.Cells.Count > 0) txtCol1.Text = row.Cells[0].Value.ToString();
                if (txtCol2.Visible && row.Cells.Count > 1) txtCol2.Text = row.Cells[1].Value.ToString();
                if (txtCol3.Visible && row.Cells.Count > 2) txtCol3.Text = row.Cells[2].Value.ToString();
                if (txtCol4.Visible && row.Cells.Count > 3) txtCol4.Text = row.Cells[3].Value.ToString();
                if (txtCol5.Visible && row.Cells.Count > 4) txtCol5.Text = row.Cells[4].Value.ToString();
            }
        }

        private void btnInsert_Click(object sender, EventArgs e)
        {
            if (!ValidateInputs()) return;

            string query = "";
            SqlParameter[] parameters = GetCurrentParameters();

            switch (currentTable)
            {
                case "EQUIPMENT":
                    query = "INSERT INTO EQUIPMENT (EquipmentID, Name, Type, Status) VALUES (@p1, @p2, @p3, @p4)";
                    break;
                case "PROFESSIONAL":
                    query = "INSERT INTO PROFESSIONAL (ProfessionalID, Name, Role, Email) VALUES (@p1, @p2, @p3, @p4)";
                    break;
                case "PROJECT":
                    query = "INSERT INTO PROJECT (ProjectID, Title, Budget, ClientName) VALUES (@p1, @p2, @p3, @p4)";
                    break;
                case "SESSION":
                    query = "INSERT INTO SESSION (SessionID, ProjectID, StudioID, SessionDate, Duration) VALUES (@p1, @p2, @p3, @p4, @p5)";
                    break;
                case "SESSION_EQUIP":
                    query = "INSERT INTO SESSION_EQUIP (SessionID, EquipmentID, Quantity) VALUES (@p1, @p2, @p3)";
                    break;
                case "SKILLS":
                    query = "INSERT INTO SKILLS (SkillID, ProfessionalID, SkillName, Proficiency) VALUES (@p1, @p2, @p3, @p4)";
                    break;
                case "STUDIO":
                    query = "INSERT INTO STUDIO (StudioID, Name, Location, Availability) VALUES (@p1, @p2, @p3, @p4)";
                    break;
                case "WORK_ON":
                    query = "INSERT INTO WORK_ON (SessionID, ProfessionalID, HoursWorked, TaskDescription) VALUES (@p1, @p2, @p3, @p4)";
                    break;
            }

            ExecuteNonQuery(query, parameters, "Data inserted successfully!");
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!ValidateInputs()) return;

            string query = "";
            SqlParameter[] parameters = GetCurrentParameters();

            switch (currentTable)
            {
                case "EQUIPMENT":
                    query = "UPDATE EQUIPMENT SET Name=@p2, Type=@p3, Status=@p4 WHERE EquipmentID=@p1";
                    break;
                case "PROFESSIONAL":
                    query = "UPDATE PROFESSIONAL SET Name=@p2, Role=@p3, Email=@p4 WHERE ProfessionalID=@p1";
                    break;
                case "PROJECT":
                    query = "UPDATE PROJECT SET Title=@p2, Budget=@p3, ClientName=@p4 WHERE ProjectID=@p1";
                    break;
                case "SESSION":
                    query = "UPDATE SESSION SET ProjectID=@p2, StudioID=@p3, SessionDate=@p4, Duration=@p5 WHERE SessionID=@p1";
                    break;
                case "SESSION_EQUIP":
                    query = "UPDATE SESSION_EQUIP SET Quantity=@p3 WHERE SessionID=@p1 AND EquipmentID=@p2";
                    break;
                case "SKILLS":
                    query = "UPDATE SKILLS SET ProfessionalID=@p2, SkillName=@p3, Proficiency=@p4 WHERE SkillID=@p1";
                    break;
                case "STUDIO":
                    query = "UPDATE STUDIO SET Name=@p2, Location=@p3, Availability=@p4 WHERE StudioID=@p1";
                    break;
                case "WORK_ON":
                    query = "UPDATE WORK_ON SET HoursWorked=@p3, TaskDescription=@p4 WHERE SessionID=@p1 AND ProfessionalID=@p2";
                    break;
            }

            ExecuteNonQuery(query, parameters, "Data updated successfully!");
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtCol1.Text))
            {
                MessageBox.Show("Please select a record or provide the ID to delete.", "Validation Error", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            DialogResult dialogResult = MessageBox.Show("Are you sure you want to delete this record?", "Confirm Deletion", MessageBoxButtons.YesNo, MessageBoxIcon.Warning);
            if (dialogResult != DialogResult.Yes) return;

            string query = "";
            SqlParameter[] parameters = new SqlParameter[]
            {
                new SqlParameter("@p1", txtCol1.Text),
                new SqlParameter("@p2", txtCol2.Text) // Used for composite keys
            };

            switch (currentTable)
            {
                case "EQUIPMENT": query = "DELETE FROM EQUIPMENT WHERE EquipmentID=@p1"; break;
                case "PROFESSIONAL": query = "DELETE FROM PROFESSIONAL WHERE ProfessionalID=@p1"; break;
                case "PROJECT": query = "DELETE FROM PROJECT WHERE ProjectID=@p1"; break;
                case "SESSION": query = "DELETE FROM SESSION WHERE SessionID=@p1"; break;
                case "SESSION_EQUIP": query = "DELETE FROM SESSION_EQUIP WHERE SessionID=@p1 AND EquipmentID=@p2"; break;
                case "SKILLS": query = "DELETE FROM SKILLS WHERE SkillID=@p1"; break;
                case "STUDIO": query = "DELETE FROM STUDIO WHERE StudioID=@p1"; break;
                case "WORK_ON": query = "DELETE FROM WORK_ON WHERE SessionID=@p1 AND ProfessionalID=@p2"; break;
            }

            ExecuteNonQuery(query, parameters, "Data deleted successfully!");
            ClearFields();
        }

        private void ExecuteNonQuery(string query, SqlParameter[] parameters, string successMessage)
        {
            try
            {
                int rows = dbHelper.ExecuteNonQuery(query, parameters);
                if (rows > 0)
                {
                    MessageBox.Show(successMessage, "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    LoadData();
                }
                else
                {
                    MessageBox.Show("No rows affected. Please verify the IDs.", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (SqlException sqlEx)
            {
                if (sqlEx.Number == 547) // Foreign Key Violation
                {
                    MessageBox.Show("Operation failed due to a related record in another table (Foreign Key Constraint).", "Database Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else if (sqlEx.Number == 2627) // Primary Key Violation
                {
                    MessageBox.Show("Operation failed. An entry with this ID already exists (Primary Key Violation).", "Database Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                {
                    MessageBox.Show("SQL Error: " + sqlEx.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private bool ValidateInputs()
        {
            if (txtCol1.Visible && string.IsNullOrWhiteSpace(txtCol1.Text)) { MessageBox.Show($"{lblCol1.Text} is required.", "Validation Error", MessageBoxButtons.OK, MessageBoxIcon.Warning); return false; }
            if (txtCol2.Visible && string.IsNullOrWhiteSpace(txtCol2.Text)) { MessageBox.Show($"{lblCol2.Text} is required.", "Validation Error", MessageBoxButtons.OK, MessageBoxIcon.Warning); return false; }
            if (txtCol3.Visible && string.IsNullOrWhiteSpace(txtCol3.Text)) { MessageBox.Show($"{lblCol3.Text} is required.", "Validation Error", MessageBoxButtons.OK, MessageBoxIcon.Warning); return false; }
            if (txtCol4.Visible && string.IsNullOrWhiteSpace(txtCol4.Text)) { MessageBox.Show($"{lblCol4.Text} is required.", "Validation Error", MessageBoxButtons.OK, MessageBoxIcon.Warning); return false; }
            if (txtCol5.Visible && string.IsNullOrWhiteSpace(txtCol5.Text)) { MessageBox.Show($"{lblCol5.Text} is required.", "Validation Error", MessageBoxButtons.OK, MessageBoxIcon.Warning); return false; }
            return true;
        }

        private SqlParameter[] GetCurrentParameters()
        {
            return new SqlParameter[]
            {
                new SqlParameter("@p1", txtCol1.Text),
                new SqlParameter("@p2", txtCol2.Text),
                new SqlParameter("@p3", txtCol3.Text),
                new SqlParameter("@p4", txtCol4.Text),
                new SqlParameter("@p5", txtCol5.Text)
            };
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                string searchVal = txtSearch.Text.Trim();
                if (string.IsNullOrEmpty(searchVal) || string.IsNullOrEmpty(currentTable))
                {
                    LoadData();
                    return;
                }

                // Generically searching across string column 2 for demo purposes (usually Name/Title)
                string query = $"SELECT * FROM {currentTable} WHERE {lblCol2.Text} LIKE @search OR {lblCol1.Text} LIKE @search";
                SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@search", "%" + searchVal + "%") };

                dgvData.DataSource = dbHelper.ExecuteQuery(query, parameters);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Search Error: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void btnRunJoin_Click(object sender, EventArgs e)
        {
            try
            {
                string query = "";
                int selIndex = cboJoins.SelectedIndex;

                switch (selIndex)
                {
                    case 0:
                        query = @"SELECT P.Name AS ProfessionalName, P.Role, S.SkillName, S.Proficiency 
                                  FROM PROFESSIONAL P INNER JOIN SKILLS S ON P.ProfessionalID = S.ProfessionalID";
                        break;
                    case 1:
                        query = @"SELECT SE.SessionID, SE.SessionDate, PR.Title AS ProjectTitle, ST.Name AS StudioName 
                                  FROM SESSION SE INNER JOIN PROJECT PR ON SE.ProjectID = PR.ProjectID 
                                  INNER JOIN STUDIO ST ON SE.StudioID = ST.StudioID";
                        break;
                    case 2:
                        query = @"SELECT SE.SessionID, E.Name AS EquipmentName, E.Type, SEQ.Quantity 
                                  FROM SESSION_EQUIP SEQ INNER JOIN EQUIPMENT E ON SEQ.EquipmentID = E.EquipmentID 
                                  INNER JOIN SESSION SE ON SEQ.SessionID = SE.SessionID";
                        break;
                    case 3:
                        query = @"SELECT SE.SessionID, P.Name AS ProfessionalName, P.Role, W.HoursWorked 
                                  FROM WORK_ON W INNER JOIN PROFESSIONAL P ON W.ProfessionalID = P.ProfessionalID 
                                  INNER JOIN SESSION SE ON W.SessionID = SE.SessionID";
                        break;
                    case 4:
                        query = @"SELECT SE.SessionID, PR.Title AS Project, ST.Name AS Studio, P.Name AS Professional, W.TaskDescription 
                                  FROM SESSION SE LEFT JOIN PROJECT PR ON SE.ProjectID = PR.ProjectID 
                                  LEFT JOIN STUDIO ST ON SE.StudioID = ST.StudioID 
                                  LEFT JOIN WORK_ON W ON SE.SessionID = W.SessionID 
                                  LEFT JOIN PROFESSIONAL P ON W.ProfessionalID = P.ProfessionalID";
                        break;
                }

                dgvData.DataSource = dbHelper.ExecuteQuery(query);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error running JOIN query: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
    }
}
