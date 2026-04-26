# --- Analysis for Player A ---
library(lpSolveAPI)
p1_solv <- make.lp(0, 7)
lp.control(p1_solv, sense = "maximize")
set.objfn(p1_solv, c(rep(0, 6), 1))


v <- 80
nv <- -80

# Sequence Constraints
add.constraint(p1_solv, c(0, 0, nv, 0, 0, v, 1), "<=", 0)
add.constraint(p1_solv, c(0, 0, 0, v, nv, 0, 1), "<=", 0)
add.constraint(p1_solv, c(v, 0, 0, 0, 0, nv, 1), "<=", 0)
add.constraint(p1_solv, c(0, nv, 0, 0, v, 0, 1), "<=", 0)
add.constraint(p1_solv, c(0, v, 0, nv, 0, 0, 1), "<=", 0)
add.constraint(p1_solv, c(nv, 0, v, 0, 0, 0, 1), "<=", 0)

add.constraint(p1_solv, c(rep(1, 6), 0), "=", 1)
set.bounds(p1_solv, lower = c(rep(0, 6), -Inf))

solve(p1_solv)
get.objective(p1_solv)
get.variables(p1_solv)

# --- Analysis for Player B ---
p2_solv <- make.lp(0, 7)
lp.control(p2_solv, sense = "minimize")
set.objfn(p2_solv, c(rep(0, 6), 1))

add.constraint(p2_solv, c(0, 0, nv, 0, 0, v, 1), ">=", 0)
add.constraint(p2_solv, c(0, 0, 0, v, nv, 0, 1), ">=", 0)
add.constraint(p2_solv, c(v, 0, 0, 0, 0, nv, 1), ">=", 0)
add.constraint(p2_solv, c(0, nv, 0, 0, v, 0, 1), ">=", 0)
add.constraint(p2_solv, c(0, v, 0, nv, 0, 0, 1), ">=", 0)
add.constraint(p2_solv, c(nv, 0, v, 0, 0, 0, 1), ">=", 0)

add.constraint(p2_solv, c(rep(1, 6), 0), "=", 1)
set.bounds(p2_solv, lower = c(rep(0, 6), -Inf))

solve(p2_solv)
get.objective(p2_solv)
get.variables(p2_solv)