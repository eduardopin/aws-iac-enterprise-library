resource "aws_budgets_budget" "this" {
  name         = var.name
  budget_type  = "COST"
  limit_amount = var.limit_amount
  limit_unit   = "USD"
  time_unit    = var.time_unit
}
