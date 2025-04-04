import tkinter as tk
from tkinter import messagebox


cpt = 0

def inference_engine(facts):
    rules = [
        ({'A', 'C'}, 'F'),
        ({'A', 'E'}, 'G'),
        ({'B'}, 'E'),
        ({'G'}, 'D')
    ]
    
    inferred = set(facts)
    iterations = 0
    changes = True
    
    while changes:
        changes = False
        iterations += 1
        for conditions, conclusion in rules:
            if conditions.issubset(inferred) and conclusion not in inferred:
                inferred.add(conclusion)
                changes = True
    
    return 'D' in inferred, iterations, inferred

def run_inference():
    global cpt
    cpt += 1  

    initial_facts = {letter for letter, var in fact_vars.items() if var.get()}
    
    result, iterations, inferred_facts = inference_engine(initial_facts)
    
    message = "✅ D est prouvé !" if result else "❌ D ne peut pas être prouvé."
    message += f"\n🔄 Nombre d'itérations : {iterations}"
    message += f"\n🔍 Faits déduits : {', '.join(sorted(inferred_facts))}"
    
    messagebox.showinfo("Résultat", message)
    
    iteration_label.config(text=f"Nombre d'itérations du M.I: {iterations}")
    counter_label.config(text=f"Nombre total d'exécutions : {cpt}")

root = tk.Tk()
root.title("Moteur d'Inférence")

label = tk.Label(root, text="Sélectionnez les faits initiaux et exécutez l'inférence :")
label.pack(pady=10)


fact_vars = {letter: tk.BooleanVar() for letter in "ABCDEFG"}
check_buttons = [tk.Checkbutton(root, text=letter, variable=fact_vars[letter]) for letter in "ABCDEFG"]

for cb in check_buttons:
    cb.pack()

run_button = tk.Button(root, text="Exécuter", command=run_inference)
run_button.pack(pady=10)

iteration_label = tk.Label(root, text="Nombre d'itérations du M.I: -")
iteration_label.pack(pady=5)

counter_label = tk.Label(root, text="Nombre total d'exécutions : 0")
counter_label.pack(pady=5)

root.mainloop()
