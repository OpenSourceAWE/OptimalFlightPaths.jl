using ControlPlots

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
C = 0.0       # size of right part of the figure-eight
D = -1.0      # asymmetry factor
x0 = 0.0      # center x-coordinate
y0 = 0.0      # center y-coordinate
theta = 0*π/6   # rotation angle in radians
num_points = 200

x_path, y_path = figure_eight_path(A, B, C, D, x0, y0, theta, num_points)

plt.figure("Figure-of-Eight Path")
ax = plt.gca()
plt.plot(x_path, y_path)
plt.grid(true)
ax.set_aspect("equal")
