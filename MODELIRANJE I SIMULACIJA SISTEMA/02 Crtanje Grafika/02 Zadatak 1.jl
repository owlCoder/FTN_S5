using Plots

t  = 0:0.01:10;
tp = rem.(t, 5)

y = (( 2 * tp) .* (tp .< 2)) .+ 
    (  2 * ((tp .>= 2) .& (tp .< 4)) ) .+ 
    ((-2 * tp .+ 10) .* ((tp .>= 4) .& (tp .<= 5)) );

plot(t, y, title="\nZadatak 1\n")
xlabel!("tp")
ylabel!("y")