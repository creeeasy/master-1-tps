import tkinter as tk
import time

# Définition de la grille et de l'agent
GRID_SIZE = 15
CELL_SIZE = 40
START_POS = (1, 1)
OBSTACLE_POS = (5, 1)  # Position de l'obstacle (mur)
OBSTACLE_STRUCTURE = [
    [1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1],
    [1, 1, 0, 0, 1, 1],
    [1, 1, 0, 0, 1, 1],
]

class Robot:
    def __init__(self, canvas):
        self.canvas = canvas
        self.x, self.y = START_POS
        self.speed = 0.5
        self.agent = self.canvas.create_oval(self.x * CELL_SIZE + 10, self.y * CELL_SIZE + 10,
                                             (self.x + 1) * CELL_SIZE - 10, (self.y + 1) * CELL_SIZE - 10,
                                             fill='black')
        self.walls = [(0, i) for i in range(GRID_SIZE)] + [(i, 0) for i in range(GRID_SIZE)] + \
                     [(GRID_SIZE - 1, i) for i in range(GRID_SIZE)] + [(i, GRID_SIZE - 1) for i in range(GRID_SIZE)]
        self.obstacle_walls = []
        self.draw_walls()
        self.draw_obstacle()
    
    def draw_walls(self):
        for wall in self.walls:
            x, y = wall
            self.canvas.create_rectangle(x * CELL_SIZE, y * CELL_SIZE, 
                                         (x + 1) * CELL_SIZE, (y + 1) * CELL_SIZE, 
                                         fill='gray')
    
    def draw_obstacle(self):
        for i, row in enumerate(OBSTACLE_STRUCTURE):
            for j, cell in enumerate(row):
                x, y = OBSTACLE_POS[0] + j, OBSTACLE_POS[1] + i
                if cell == 1:
                    self.obstacle_walls.append((x, y))
                    self.canvas.create_rectangle(x * CELL_SIZE, y * CELL_SIZE, 
                                                 (x + 1) * CELL_SIZE, (y + 1) * CELL_SIZE, 
                                                 fill='brown', outline='black')
    
    def move(self, dx, dy):
        new_x, new_y = self.x + dx, self.y + dy
        if (new_x, new_y) not in self.walls and (new_x, new_y) not in self.obstacle_walls:
            self.x, self.y = new_x, new_y
            self.canvas.move(self.agent, dx * CELL_SIZE, dy * CELL_SIZE)
        
    def sense_environment(self):
        return {
            'n': (self.x, self.y - 1) in self.walls or (self.x, self.y - 1) in self.obstacle_walls,
            'e': (self.x + 1, self.y) in self.walls or (self.x + 1, self.y) in self.obstacle_walls,
            's': (self.x, self.y + 1) in self.walls or (self.x, self.y + 1) in self.obstacle_walls,
            'o': (self.x - 1, self.y) in self.walls or (self.x - 1, self.y) in self.obstacle_walls,
        }
    
    def decide_action(self):
        sensors = self.sense_environment()
        if sensors['n'] and not sensors['e']:
            return (1, 0)  # est
        elif sensors['e'] and not sensors['s']:
            return (0, 1)  # sud
        elif sensors['s'] and not sensors['o']:
            return (-1, 0)  # ouest
        elif sensors['o'] and not sensors['n']:
            return (0, -1)  # nord
        return (1, 0)  # par défaut suivre le mur vers l'est
    
    def run(self):
        visited = set()
        for _ in range(200):
            dx, dy = self.decide_action()
            if (self.x + dx, self.y + dy) in visited:
                break  # Éviter la boucle infinie
            visited.add((self.x, self.y))
            self.move(dx, dy)
            self.canvas.update()
            time.sleep(self.speed)
    
    def speed_up(self):
        self.speed = max(0.1, self.speed - 0.1)
    
    def slow_down(self):
        self.speed += 0.1

# Interface graphique
def main():
    root = tk.Tk()
    root.title("Robot Suivi de Mur")
    canvas = tk.Canvas(root, width=GRID_SIZE * CELL_SIZE, height=GRID_SIZE * CELL_SIZE)
    canvas.pack()
    robot = Robot(canvas)
    
    tk.Button(root, text="Démarrer", command=robot.run).pack()
    tk.Button(root, text="Accélérer", command=robot.speed_up).pack()
    tk.Button(root, text="Ralentir", command=robot.slow_down).pack()
    
    root.mainloop()

if __name__ == "__main__":
    main()