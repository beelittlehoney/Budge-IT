<?php
// Database Connection
$host = "https://auth-db1156.hstgr.io/index.php?route=/";
$username = "u415861906_infosec2234";
$password = "3nE[W0=#vnXwbqx!";
$dbname = "u415861906_infosec2234";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (isset($_POST['description']) && isset($_POST['amount'])) {
        $description = $conn->real_escape_string($_POST['description']);
        $amount = $conn->real_escape_string($_POST['amount']);

        $sql = "INSERT INTO transactions (description, amount) VALUES ('$description', '$amount')";
        if ($conn->query($sql) === TRUE) {
            echo "Transaction added successfully";
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
    }
}

$conn->close();
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
            background-color: #4CAF50;
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
            color: #4CAF50;
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
        form input, form button {
            margin: 10px 0;
            padding: 10px;
            font-size: 16px;
        }
        form button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        form button:hover {
            background-color: #45a049;
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
                <input type="number" id="amount" placeholder="Amount" required>
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
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="transactions"></tbody>
            </table>
        </section>

        <section id="goals">
            <h2>Set Savings Goals</h2>
            <form id="goalForm">
                <input type="number" id="goalAmount" placeholder="Savings Goal" required>
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
        const transactions = [];
        const addForm = document.getElementById('addForm');
        const goalForm = document.getElementById('goalForm');
        const transactionsTable = document.getElementById('transactions');
        const goalStatus = document.getElementById('goalStatus');
        let savingsGoal = 0;

        // Add transaction
        addForm.addEventListener('submit', function(event) {
            event.preventDefault();
            const description = document.getElementById('description').value;
            const amount = parseFloat(document.getElementById('amount').value);

            transactions.push({ description, amount });
            document.getElementById('description').value = '';
            document.getElementById('amount').value = '';

            updateTransactions();
        });

        // Set savings goal
        goalForm.addEventListener('submit', function(event) {
            event.preventDefault();
            savingsGoal = parseFloat(document.getElementById('goalAmount').value);
            goalStatus.textContent = `Savings Goal Set: $${savingsGoal}`;
        });

        // Update transactions table
        function updateTransactions() {
            transactionsTable.innerHTML = '';
            transactions.forEach((transaction, index) => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${transaction.description}</td>
                    <td>${transaction.amount}</td>
                    <td>
                        <button onclick="deleteTransaction(${index})">Delete</button>
                    </td>
                `;
                transactionsTable.appendChild(row);
            });
        }

        // Delete transaction
        function deleteTransaction(index) {
            transactions.splice(index, 1);
            updateTransactions();
        }
    </script>
</body>
</html>
