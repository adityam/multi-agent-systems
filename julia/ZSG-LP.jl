using JuMP, GLPK

function solve_ZSG_naive(u)
    n, m = size(u)

    ## Primal LP to find strategies of row player
    primal = Model(GLPK.Optimizer)

    @variable(primal, v_lower)
    @variable(primal, p[1:n] >= 0)

    @objective(primal, Max, v_lower)

    @constraint(primal, sum(p[i] for i ∈ 1:n) == 1)
    for j ∈ 1:m
        @constraint(primal, sum(p[i]*u[i,j] for i ∈ 1:n) >= v_lower)
    end

    ## Dual LP to find strategies for column player
    dual = Model(GLPK.Optimizer)

    @variable(dual, v_upper)
    @variable(dual, q[1:m] >= 0)

    @objective(dual, Min, v_upper)
    
    @constraint(dual, sum(q[j] for j ∈ 1:m) == 1)
    for i ∈ 1:n
        @constraint(dual, sum(q[j]*u[i,j] for j ∈ 1:m) <= v_upper)
    end
    
    JuMP.optimize!(primal)
    JuMP.optimize!(dual)

    row_strategy = JuMP.value.(p)
    col_strategy = JuMP.value.(q)
    game_value   = JuMP.value(v_lower) # Same as v_upper

    return row_strategy, col_strategy, game_value
end

function solve_ZSG(u)
    n, m = size(u)

    ## LP to find strategies of row player
    primal = Model(GLPK.Optimizer)

    @variable(primal, v_lower)
    @variable(primal, p[1:n] >= 0)

    @objective(primal, Max, v_lower)

    q = Vector{JuMP.ConstraintRef}(undef, m)


    @constraint(primal, sum(p[i] for i ∈ 1:n) == 1)
    for j ∈ 1:m
        q[j] = @constraint(primal, sum(p[i]*u[i,j] for i ∈ 1:n) >= v_lower)
    end
    JuMP.optimize!(primal)

    row_strategy = JuMP.value.(p)
    col_strategy = JuMP.dual.(q)
    game_value   = JuMP.value(v_lower) # Same as v_upper

    return row_strategy, col_strategy, game_value
end
