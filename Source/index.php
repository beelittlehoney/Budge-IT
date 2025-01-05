<?php
// Database credentials
$host = "localhost";
$dbname = "u415861906_infosec2234";
$username = "u415861906_infosec2234";
$password = "3nE[W0=#vnXwbqx!";

// Create database connection
$dsn = "mysql:host=$host;dbname=$dbname;charset=utf8mb4";
$options = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
];

try {
    $pdo = new PDO($dsn, $username, $password, $options);
} catch (PDOException $e) {
    die("Database Connection Failed: " . $e->getMessage());
}

// Create table if not exists
try {
    $createTable = "CREATE TABLE IF NOT EXISTS transactions (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    description VARCHAR(255) NOT NULL,
                    amount DECIMAL(10, 2) NULL,
                    type ENUM('income', 'expense') NOT NULL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )";
    $pdo->exec($createTable);
} catch (PDOException $e) {
    die("Table Creation Failed: " . $e->getMessage());
}

// Add default transactions if the table is empty
function addDefaultTransactions($pdo) {
    $query = "SELECT COUNT(*) as count FROM transactions";
    $stmt = $pdo->query($query);
    $row = $stmt->fetch();
    if ($row['count'] == 0) {
        $defaultTransaction = ['description' => 'Start Saving!', 'amount' => null, 'type' => 'income'];
        $insertQuery = "INSERT INTO transactions (description, amount, type) VALUES (:description, :amount, :type)";
        $stmt = $pdo->prepare($insertQuery);
        $stmt->execute($defaultTransaction);
    }
}

// Handle requests
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $description = isset($_POST['description']) ? $_POST['description'] : '';
    $amount = isset($_POST['amount']) ? $_POST['amount'] : 0;
    $type = isset($_POST['type']) ? $_POST['type'] : 'expense';

    if (!empty($description) && is_numeric($amount) && in_array($type, ['income', 'expense'])) {
        // Remove default transactions if they exist
        $deleteDefaultQuery = "DELETE FROM transactions WHERE description = 'Start Saving!'";
        $pdo->exec($deleteDefaultQuery);

        // Insert user transaction
        $query = "INSERT INTO transactions (description, amount, type) VALUES (:description, :amount, :type)";
        $stmt = $pdo->prepare($query);
        $stmt->execute(['description' => $description, 'amount' => $amount, 'type' => $type]);

        echo json_encode(["success" => true, "message" => "Transaction added successfully."]);
    } else {
        echo json_encode(["success" => false, "message" => "Invalid input."]);
    }
    exit;
} elseif ($_SERVER['REQUEST_METHOD'] === 'GET') {
    if (isset($_GET['fetch']) && $_GET['fetch'] === 'true') {
        // Add default transactions if the table is empty
        addDefaultTransactions($pdo);

        $query = "SELECT * FROM transactions ORDER BY created_at DESC";
        $stmt = $pdo->query($query);

        $transactions = $stmt->fetchAll();

        header('Content-Type: application/json'); // Ensure JSON header
        echo json_encode($transactions);
        exit;
    }
}

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    parse_str(file_get_contents("php://input"), $data);
    $id = isset($data['id']) ? $data['id'] : null;

    if ($id) {
        $query = "DELETE FROM transactions WHERE id = :id";
        $stmt = $pdo->prepare($query);
        $stmt->execute(['id' => $id]);

        echo json_encode(["success" => true, "message" => "Transaction deleted successfully."]);
    } else {
        echo json_encode(["success" => false, "message" => "Invalid transaction ID."]);
    }
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'PUT') {
    parse_str(file_get_contents("php://input"), $data);
    $id = isset($data['id']) ? $data['id'] : null;
    $description = isset($data['description']) ? $data['description'] : '';
    $amount = isset($data['amount']) ? $data['amount'] : 0;
    $type = isset($data['type']) ? $data['type'] : 'expense';

    if ($id && !empty($description) && is_numeric($amount) && in_array($type, ['income', 'expense'])) {
        $query = "UPDATE transactions SET description = :description, amount = :amount, type = :type WHERE id = :id";
        $stmt = $pdo->prepare($query);
        $stmt->execute(['id' => $id, 'description' => $description, 'amount' => $amount, 'type' => $type]);

        echo json_encode(["success" => true, "message" => "Transaction updated successfully."]);
    } else {
        echo json_encode(["success" => false, "message" => "Invalid input."]);
    }
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Budge-IT</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #1E385F;
            color: white;
            padding: 10px 20px;
            text-align: center;
        }
        nav {
            margin: 20px 0;
            text-align: center;
        }
        nav a {
            margin: 0 15px;
            text-decoration: none;
            color: #1E385F;
            font-weight: bold;
        }
        nav a:hover {
            text-decoration: underline;
        }
        .container {
            padding: 20px;
            max-width: 800px;
            margin: auto;
            background: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        form {
            display: flex;
            flex-direction: column;
        }
        form input, form button, form select {
            margin: 10px 0;
            padding: 10px;
            font-size: 16px;
        }
        form button {
            background-color: #1E385F;
            color: white;
            border: none;
            cursor: pointer;
        }
        form button:hover {
            background-color: #163351;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
    </style>
</head>
<body>
    <header>
        <h1>Budge-IT: Personal Expense and Savings Optimizer</h1>
    </header>
    <nav>
        <a href="#add">Add Expense/Income</a>
        <a href="#goals">Set Savings Goals</a>
        <a href="#track">Track Spending</a>
        <a href="#reports">Financial Reports</a>
    </nav>
    <div class="container">
        <section id="add">
            <h2>Add Expense/Income</h2>
            <form id="addForm">
                <input type="text" id="description" placeholder="Description" required>
                <input type="number" id="amount" placeholder="Amount (e.g., PHP 1,234.56)" required>
                <select id="type" required>
                    <option value="expense">Expense</option>
                    <option value="income">Income</option>
                </select>
                <button type="submit">Add</button>
            </form>
        </section>

        <section id="track">
            <h2>Track Spending</h2>
            <table>
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Amount</th>
                        <th>Type</th>
                        <th>Date</th>
                        <th>Options</th>
                    </tr>
                </thead>
                <tbody id="transactions"></tbody>
            </table>
        </section>

        <section id="goals">
            <h2>Set Savings Goals</h2>
            <form id="goalForm">
                <input type="number" id="goalAmount" placeholder="Savings Goal (e.g., PHP 12,345.67)" required>
                <button type="submit">Set Goal</button>
            </form>
            <p id="goalStatus"></p>
        </section>

        <section id="reports">
            <h2>Financial Reports</h2>
            <p>Feature under development...</p>
        </section>
    </div>

    <script>
        const transactionsTable = document.getElementById('transactions');
        const addForm = document.getElementById('addForm');
        const goalForm = document.getElementById('goalForm');
        const goalStatus = document.getElementById('goalStatus');
        let savingsGoal = 0;

        async function fetchTransactions() {
            const response = await fetch(location.pathname + '?fetch=true');
            const transactions = await response.json();
            updateTransactionsTable(transactions);
        }
        async function handleDelete(id) {
            const confirmation = confirm('Are you sure you want to delete this transaction?');
            if (!confirmation) return;

            const response = await fetch(location.href, {
                method: 'DELETE',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ id }),
            });

            const result = await response.json();
            if (result.success) {
                fetchTransactions(); // Refresh the table
            } else {
                alert(result.message);
            }
        }

        function handleEdit(id) {
            const description = prompt('Enter the new description:');
            const amount = prompt('Enter the new amount:');
            const type = prompt('Enter the type (income/expense):');

            if (description && amount && type) {
                fetch(location.href, {
                    method: 'PUT',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: new URLSearchParams({ id, description, amount, type }),
                })
                    .then((response) => response.json())
                    .then((result) => {
                        if (result.success) {
                            fetchTransactions(); // Refresh the table
                        } else {
                            alert(result.message);
                        }
                    })
                    .catch((error) => console.error('Error updating transaction:', error));
            }
        }

        addForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const description = document.getElementById('description').value;
            const amount = document.getElementById('amount').value;
            const type = document.getElementById('type').value;

            const response = await fetch(location.href, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: new URLSearchParams({ description, amount, type })
            });

            const result = await response.json();
            if (result.success) {
                fetchTransactions(); // Refresh table to reflect changes
                document.getElementById('description').value = '';
                document.getElementById('amount').value = '';
                document.getElementById('type').value = 'expense';
            } else {
                alert(result.message);
            }
        });

        function updateTransactionsTable(transactions) {
            transactionsTable.innerHTML = ''; // Clear the table

            const tableHeaders = document.querySelector('table thead tr');

            if (!transactions || transactions.length === 0 || (transactions.length === 1 && transactions[0].description === 'Start Saving!' && transactions[0].amount === null)) {
                // Hide "Options" column if only the default transaction is active
                tableHeaders.innerHTML = `
                    <th>Description</th>
                    <th>Amount</th>
                    <th>Type</th>
                    <th>Date</th>
                `;

                // Add the default row
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>Start Saving!</td>
                    <td></td>
                    <td></td>
                    <td></td>
                `;
                transactionsTable.appendChild(row);
                return;
            }

            // Show "Options" column in the header
            tableHeaders.innerHTML = `
                <th>Description</th>
                <th>Amount</th>
                <th>Type</th>
                <th>Date</th>
                <th>Options</th>
            `;

            transactions.forEach((transaction) => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${transaction.description}</td>
                    <td>${transaction.amount !== null ? `PHP ${parseFloat(transaction.amount).toLocaleString('en-PH', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}` : ''}</td>
                    <td>${transaction.type}</td>
                    <td>${transaction.created_at ? new Date(transaction.created_at).toLocaleString() : ''}</td>
                    <td>
                        ${transaction.id ? `
                            <button class="edit-btn" data-id="${transaction.id}">Edit</button>
                            <button class="delete-btn" data-id="${transaction.id}">Delete</button>
                        ` : ''}
                    </td>
                `;
                transactionsTable.appendChild(row);
            });

            // Add event listeners for the buttons
            document.querySelectorAll('.edit-btn').forEach((button) =>
                button.addEventListener('click', (e) => handleEdit(e.target.dataset.id))
            );
            document.querySelectorAll('.delete-btn').forEach((button) =>
                button.addEventListener('click', (e) => handleDelete(e.target.dataset.id))
            );
        }

        goalForm.addEventListener('submit', (e) => {
            e.preventDefault();
            savingsGoal = parseFloat(document.getElementById('goalAmount').value);
            goalStatus.textContent = `Savings Goal Set: PHP ${savingsGoal.toLocaleString('en-PH', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;

            document.getElementById('goalAmount').value = '';
        });
        fetchTransactions();
    </script>
</body>
</html>
