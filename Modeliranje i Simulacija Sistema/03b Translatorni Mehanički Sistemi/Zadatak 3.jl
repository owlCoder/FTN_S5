using LinearAlgebra, Plots, DifferentialEquations

function signal(t)
    tp = rem.(t, 3)

    y = sin.(tp)
end

function diferencijalneJednačine!(dx, x, p, t)
    m1, m3, m2, c, k, g = p
    f = signal(t)

    dx[1] = x[2]
    dx[2] = 1 / m1 * (-c * (x[2] - x[4]) - k * (x[1] - x[3]) + m1 * g - k * x[1])
    dx[3] = x[4]
    dx[4] = 1 / m2 * (-k * (x[3] - x[5]) + k * (x[1] - x[3]) + c * (x[2] - x[4]) - k * x[3] + m2 * g)
    dx[5] = x[6]
    dx[6] = 1 / m3 * (k * (x[3] - x[5]) + m3 * g - f)
end

# main.jl
t = (0.0, 12.0)
p = (5.0, 5.0, 10.0, 10.0, 15.0, 9.81)
x0 = [0.0, 3.0, 0.0, 3.0, 0.0, 3.0]

problem = ODEProblem(diferencijalneJednačine!, x0, t, p)
rešenje = solve(problem)

plot(rešenje)

# pod d) 
# promena pozicija tela m1 i m2 i najudaljenije tacke
x1 = [x[1] for x in rešenje.u]
x3 = [x[3] for x in rešenje.u]

Δm1 = diff(x1)
Δm2 = diff(x3)

~, max_m1 = findmax(abs.(Δm1))
~, max_m2 = findmax(abs.(Δm2))

plot([rešenje.t[1:end-1]], [Δm1, Δm2], lw = 2, label = ["Δm1" "Δm2"])
plot!([rešenje.t[max_m1]], [Δm1[max_m1]], markershape = :o, color = :red, label = "max Δm1")
plot!([rešenje.t[max_m2]], [Δm2[max_m2]], markershape = :o, color = :green, label = "max Δm2")

# pod e)
# promenu rastojanja između tela mase m2 i m3, ako je rastojanje
# u početnom trenutku iznosilo 2
x0 = [0.0, 3.0, 2.0, 3.0, 0.0, 3.0]

problem = ODEProblem(diferencijalneJednačine!, x0, t, p)
rešenje = solve(problem)

x2 = [x[2] for x in rešenje.u]
x3 = [x[3] for x in rešenje.u]

Δm2 = diff(x2)
Δm3 = diff(x3)

razlika_rastojanja = abs.(Δm2 - Δm3)

plot([rešenje.t[1:end-1]], [Δm2, Δm3], lw = 2, label = ["Δm2" "Δm3"], xticks = 0:12)
plot!(rešenje.t[1:end-1], razlika_rastojanja, lw = 3, color = :mint, label = "razl. rast.")