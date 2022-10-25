using Plots

t = 0:0.01:10
tp = rem.(t, 2)

# jednacina prave kroz dve tacke za pravu
y1 = 4/10 * t

y2 = 4 .* (tp .<= 1) # ako je manje od 1 onda je y = 4, u suprotnom y = 0

y = min.(y1, y2)

plot(t, y2, color=:red, label="y1", linestyle=:dash)
plot!(t, y, title="\nZadatak 3\n", label="y", xticks=0:10, color=:blue)

xlabel!("t")
ylabel!("y")
