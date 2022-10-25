using Plots

t = -1:0.0001:1
y = sqrt.(1.0 .- t.^2)

plot(t, y, xticks=-1:2, label="kruznica")
