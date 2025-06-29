using GLMakie

function figure_eight_path(A, B, C, D, x0, y0, theta, num_points)
    t = range(0, 2π, length=num_points)
    x = A * sin.(t)
    y = B * sin.(t) .* cos.(t) .+ C .* cos.(t) .+ D .* cos.(2t)
    # Apply rotation
    x_rot = x .* cos(theta) .- y .* sin(theta) 
    y_rot = x .* sin(theta) .+ y .* cos(theta)
    y_rot = y_rot / (maximum(y_rot)/(B/2))
    # Apply translation
    x_final = x_rot .+ x0
    y_final = y_rot .+ y0
    return x_final, y_final
end

# Example usage:
A = 10.0      # width of the figure-eight
B = 5.0       # height of the figure-eight
C = Observable(1.0)       # size of right part of the figure-eight
D = Observable(1.0)      # asymmetry factor
x0 = 0.0      # center x-coordinate
y0 = 0.0      # center y-coordinate
theta = 0*π/6   # rotation angle in radians
num_points = 200

# Define the x range
x = LinRange(0, 6π, 500)

# Observable for the y values
y = @lift($C .* sin.($D .* x))

# Create the figure and axis
fig = Figure()
ax = Axis(fig[1, 1], xlabel = "x", ylabel = "y")

# Plot the sine wave
lineplot = lines!(ax, x, y)

# Create sliders for amplitude and frequency
sg = SliderGrid(
    fig[2, 1],
    (label = "C", range = 0.0:0.01:2.0, startvalue = 1.0),
    (label = "D", range = 0.5:0.01:3.0, startvalue = 1.0)
)

# Connect sliders to observables
on(sg.sliders[1].value) do val
    C[] = val
end

on(sg.sliders[2].value) do val
    D[] = val
end

# Optional: keep axis limits stable if amplitude changes a lot
# ax.ylims = (-2, 2)  # or use autolimits! if you prefer dynamic limits

fig
