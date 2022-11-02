using DifferentialEquations
using Plots

function signal(t)
    tp = rem.(t, 3)

    y = (4 * tp) .* (tp .< 1) .+
        (4) .* ((tp .>= 1) .& (tp .< 2)) .+
        (0) .* ((tp .>= 2))

    return y
end

function diferencijalnaJednacina!(dx, x, p, t)
    A, B, C = p
    F = signal(t)

     dx[1] = x[3]
     dx[2] = x[4]
     dx[3] = -3 * x[3] - C * (x[3] - x[4]) - B * (x[1] - x[2])
     dx[4] = (C * (x[3] - x[4]) - A * x[2] + B * (x[1] - x[2]) + F) / 2
end

# main.jl

# provera signala
# t = 0:0.01:9
# plot(t, signal(t), xticks =0:9)

tspan = (0.0, 9.0)
x0 = [0.0, 0.0, 0.0, 0.0]
parametri = (12.0, 8.0, 4.0)

problem = ODEProblem(diferencijalnaJednacina!, x0, tspan, parametri)
resenje = solve(problem)

plot(resenje)