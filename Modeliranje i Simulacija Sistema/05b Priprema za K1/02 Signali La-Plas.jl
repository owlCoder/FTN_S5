using Plots

function rampa(t)
    return (t .* (t .>= 0))
end

function h(t)
    return (1 .* (t .>= 0))
end

t = 0:0.01:5

# y1 = -3 .* h(t)
# y2 = 6 * h(t .- 1)
# y3 = 3 * rampa(t .- 1)
# y4 = 6 * rampa(t .- 3)
# y5 = 3 * rampa(t .- 4)

y = 2* h(t) .- 2 * h(t .- 1) .+ 2 * rampa(t .- 1) .- 2 * 2 * rampa(t .- 2) .+ 2 * rampa(t .- 3) .- 2 * h(t .- 3) .+ 2 * h(t .- 4)

#y = y1 .+ y2 .- y3 .+ y4 .- y5
plot(t, y, yticks = -3:1:3, lw = 2)