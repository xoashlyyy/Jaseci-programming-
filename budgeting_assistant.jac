# budget_tracker_ai.jac

::py::
import uuid
from datetime import datetime

expenses = []

def get_uuid():
    return str(uuid.uuid4())

def get_timestamp():
    return datetime.utcnow().isoformat()

def log_expense(category, amount, description):
    expense = {
        "id": get_uuid(),
        "category": category,   # e.g., Food, Transport, Bills
        "amount": amount,       # in USD or KES
        "description": description,
        "logged_at": get_timestamp(),
    }
    expenses.append(expense)
    return expense

def list_expenses():
    return expenses
::py::

import from byllm.llm { Model }

# global LLM instance
glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);

# AI helper functions
def analyze_expenses(expense_list: list) -> str by llm();
def suggest_saving_plan(expense_list: list, goal: str) -> str by llm();

with entry {
    print("💰 Budget Tracker (AI Edition) Online!");

    # Ask user for budget goal
    let goal = input("Enter your financial goal (e.g., Save for vacation, reduce eating out): ");

    # Ask number of expenses
    let count = int(input("How many expenses do you want to log today? "));

    for i in range(count) {
        let cat = input("Enter expense category (Food/Transport/Bills/etc.): ");
        let amt = float(input("Enter amount spent: "));
        let desc = input("Enter short description: ");
        log_expense(cat, amt, desc);
    }

    print("\nYour expenses:");
    for e in list_expenses() {
        print("[" + e["id"] + "] " + e["category"] + " - " + str(e["amount"]) + " (" + e["description"] + ")");
    }

    # AI analysis
    let analysis = analyze_expenses(list_expenses());
    print("\n📊 AI Analysis: " + analysis);

    let plan = suggest_saving_plan(list_expenses(), goal);
    print("💡 AI Suggested Saving Plan: " + plan);
}
