# =========================================================
# SEASONAL TEXTILE PROFIT ANALYSIS (Q2)
# =========================================================
library(lpSolveAPI)

# Setting up a model with 12 boundary conditions and 9 variables
fabric_engine <- make.lp(12, 9)

# Define the Profit Coefficients (Revenue minus all costs)
# Variables: c1,c2,c3, w1,w2,w3, s1,s2,s3
profit_targets <- c(22, 8, 34, 9, -5, 21, 4, -10, 16)
set.objfn(fabric_engine, profit_targets)
lp.control(fabric_engine, sense = "maximize")

# 1. CAPACITY LIMITS (Spring, Autumn, Winter totals)
# 
set.row(fabric_engine, 1, rep(1, 3), indices = c(1, 4, 7)) 
set.row(fabric_engine, 2, rep(1, 3), indices = c(2, 5, 8)) 
set.row(fabric_engine, 3, rep(1, 3), indices = c(3, 6, 9)) 

# 2. MIXTURE PERCENTAGE REQUIREMENTS
# Coefficients for the material ratio inequalities
set.row(fabric_engine, 4,  c(0.47, -0.53, -0.53), indices = c(1, 4, 7))
set.row(fabric_engine, 5,  c(0.70, -0.30, -0.30), indices = c(4, 1, 7))
set.row(fabric_engine, 6,  c(0.99, -0.01, -0.01), indices = c(7, 1, 4))
set.row(fabric_engine, 7,  c(0.53, -0.47, -0.47), indices = c(2, 5, 8))
set.row(fabric_engine, 8,  c(0.60, -0.40, -0.40), indices = c(5, 2, 8))
set.row(fabric_engine, 9,  c(0.98, -0.02, -0.02), indices = c(8, 2, 5))
set.row(fabric_engine, 10, c(0.64, -0.36, -0.36), indices = c(3, 6, 9))
set.row(fabric_engine, 11, c(0.50, -0.50, -0.50), indices = c(6, 3, 9))
set.row(fabric_engine, 12, c(0.97, -0.03, -0.03), indices = c(9, 3, 6))

# Define Right Hand Side and Operator Directions
rhs_vals <- c(3200, 3800, 4200, rep(0, 9))
set.rhs(fabric_engine, rhs_vals)
set.constr.type(fabric_engine, c(rep("<=", 3), rep(">=", 9)))

# Establish non-negative production boundaries
set.bounds(fabric_engine, lower = rep(0, 9))

# CALCULATE RESULTS
solve(fabric_engine)
max_return <- get.objective(fabric_engine)
optimal_mix <- get.variables(fabric_engine)

# Console Output
print(max_return)
print(optimal_mix)



