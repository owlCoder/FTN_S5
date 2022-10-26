using Plots

# kruznica
t_kruznica_domen = 0:0.001:4

t_kruznica = rem.(t_kruznica_domen, 2)
y_kruznica = sqrt.(1 .- ((t_kruznica .- 1) .^ 2))

plot(t_kruznica_domen, y_kruznica, label="kruznica", color=:blue, linestyle=:dash)

# trougao
t_trougla = 0:0.001:4
tp = rem.(t_trougla, 2)

y1 = (2 * tp) .* (tp .<= 1)
y2 = (-2 * tp .+ 4) .* (tp .> 1)

y_trougao = y1 + y2

plot!(t_trougla, y_trougao, xticks=0:4, label="trougao", color=:red, linestyle=:dash)

# konacni signal
t_domen = 0:0.001:4

y1_a = y_trougao .* (tp .< 0.4)
y1_b = y_trougao .* (tp .> 1.6)
y2 = y_kruznica .* ((tp .>= 0.4) .& (tp .<= 1.6))

y = y1_a + y1_b + y2

plot!(t_domen, y, xticks=0:4, label="y", color=:green, lw=2)

xlabel!("t")
ylabel!("y")
