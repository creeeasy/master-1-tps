import tkinter as tk
from tkinter import messagebox

def calculate_distance():
    try:
        speed = float(speed_entry.get())
        condition = condition_var.get()
        
        if speed > 100:
            result_label.config(text="🚗 Stopping distance: Longer", fg="red")
        elif speed < 40:
            result_label.config(text="🚗 Stopping distance: Shorter", fg="green")
        else:
            result_label.config(text="🚗 Stopping distance: Moderate", fg="orange")
        
        d_sec = (speed / 10) * 3
        d_humid = d_sec + (speed / 10) * 1.5 if condition == "Humide" else d_sec
        
        distance_label.config(text=f"📏 Distance: {d_humid:.2f} m ({condition})", fg="blue")
        iteration_label.config(text="🔄 Iterations: 1 (Simple Rules)", fg="purple")
        
    except ValueError:
        messagebox.showerror("Input Error", "Please enter a valid number for speed.")

# GUI Setup
root = tk.Tk()
root.title("Stopping Distance Calculator")
root.geometry("400x300")
root.configure(bg="#f4f4f4")

# Input Speed
title_label = tk.Label(root, text="🚦 Enter Speed (km/h):", font=("Arial", 12, "bold"), bg="#f4f4f4")
title_label.pack(pady=5)

speed_entry = tk.Entry(root, font=("Arial", 12), width=10)
speed_entry.pack(pady=5)

# Condition Selection
condition_var = tk.StringVar(value="Sec")
frame = tk.Frame(root, bg="#f4f4f4")
frame.pack(pady=5)

tk.Radiobutton(frame, text="🌞 Temps Sec", variable=condition_var, value="Sec", font=("Arial", 10), bg="#f4f4f4").pack(side=tk.LEFT, padx=10)
tk.Radiobutton(frame, text="🌧 Temps Humide", variable=condition_var, value="Humide", font=("Arial", 10), bg="#f4f4f4").pack(side=tk.LEFT, padx=10)

# Calculate Button
calculate_button = tk.Button(root, text="Calculate", font=("Arial", 12, "bold"), bg="#007BFF", fg="white", command=calculate_distance)
calculate_button.pack(pady=10)

# Output Labels
result_label = tk.Label(root, text="", font=("Arial", 12, "bold"), bg="#f4f4f4")
result_label.pack(pady=5)

distance_label = tk.Label(root, text="", font=("Arial", 12), bg="#f4f4f4")
distance_label.pack(pady=5)

iteration_label = tk.Label(root, text="", font=("Arial", 10, "italic"), bg="#f4f4f4")
iteration_label.pack(pady=5)

# Run the GUI
root.mainloop()