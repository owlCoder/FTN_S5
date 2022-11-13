using LinearAlgebra, Plots, DifferentialEquations

function signal(t)
    tp = rem.(t, 3)

    y_sinus = abs.(sin.(pi / 3 * t))
    y_prava = 1 / 3 * tp

    y = min.(y_sinus, y_prava)
end

function diferencijalneJednačine!(dx, x, p, t)
    
end

# main.jl
t = 0:0.01:18
plot(t, signal(t))