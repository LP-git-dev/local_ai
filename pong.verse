using { /Verse.org/Simulation }
using { /UnrealEngine.com/Transient }

# Petit jeu de Pong en Verse
# Une raquette contrôlée par le joueur, une balle qui rebondit

var PlayerY:float = 50.0
var BallX:float = 100.0
var BallY:float = 50.0
var BallVelX:float = 2.0
var BallVelY:float = 1.5
var Score:int = 0

const ARENA_WIDTH:float = 200.0
const ARENA_HEIGHT:float = 100.0
const PADDLE_HEIGHT:float = 20.0
const PADDLE_WIDTH:float = 5.0
const BALL_SIZE:float = 2.0

# Initialise le jeu
InitializePong() : void =
    Print("=== Pong Game Started ===")
    Print("Use UP/DOWN arrows to move your paddle")
    Print("Try to keep the ball in play!")
    set PlayerY = ARENA_HEIGHT / 2.0
    set BallX = ARENA_WIDTH / 2.0
    set BallY = ARENA_HEIGHT / 2.0
    set BallVelX = 2.0
    set BallVelY = 1.5
    set Score = 0

# Déplace la raquette du joueur
MovePaddle(Direction:int) : void =
    if (Direction > 0):
        set PlayerY = PlayerY + 3.0
    else if (Direction < 0):
        set PlayerY = PlayerY - 3.0
    
    # Limite la raquette dans l'arène
    if (PlayerY < PADDLE_HEIGHT / 2.0):
        set PlayerY = PADDLE_HEIGHT / 2.0
    else if (PlayerY > ARENA_HEIGHT - PADDLE_HEIGHT / 2.0):
        set PlayerY = ARENA_HEIGHT - PADDLE_HEIGHT / 2.0

# Déplace la balle
UpdateBall() : void =
    # Déplace la balle
    set BallX = BallX + BallVelX
    set BallY = BallY + BallVelY
    
    # Rebondit sur le haut et le bas
    if (BallY <= BALL_SIZE or BallY >= ARENA_HEIGHT - BALL_SIZE):
        set BallVelY = -BallVelY
        if (BallY <= BALL_SIZE):
            set BallY = BALL_SIZE
        else:
            set BallY = ARENA_HEIGHT - BALL_SIZE
    
    # Rebondit sur la raquette (côté gauche)
    if (BallX <= PADDLE_WIDTH and 
        BallY >= PlayerY - PADDLE_HEIGHT / 2.0 and 
        BallY <= PlayerY + PADDLE_HEIGHT / 2.0):
        set BallVelX = -BallVelX
        set BallX = PADDLE_WIDTH + BALL_SIZE
        set Score = Score + 1
        # Augmente légèrement la vitesse
        set BallVelX = BallVelX * 1.02
        set BallVelY = BallVelY * 1.01
        Print("Score: {Score}")
    
    # Reset si la balle sort du terrain
    if (BallX < 0.0 or BallX > ARENA_WIDTH):
        Print("Ball out! Resetting...")
        Print("Final Score: {Score}")
        set BallX = ARENA_WIDTH / 2.0
        set BallY = ARENA_HEIGHT / 2.0
        set BallVelX = 2.0
        set BallVelY = 1.5
        set Score = 0

# Affiche l'état du jeu
DisplayGameState() : void =
    Print("┌────────────────────┐")
    Print("│ PONG GAME          │")
    Print("│ Score: {Score}")
    Print("│ Ball: ({BallX:0}, {BallY:0})")
    Print("│ Paddle: {PlayerY:0}")
    Print("└────────────────────┘")

# Boucle principale du jeu
GameLoop() : void =
    var Iteration:int = 0
    loop:
        if (Iteration > 100):
            break
        
        # Simule les entrées du joueur (vous pouvez adapter)
        if (Iteration < 30):
            MovePaddle(1)  # Haut
        else if (Iteration < 60):
            MovePaddle(-1) # Bas
        
        UpdateBall()
        
        if (Iteration % 20 = 0):
            DisplayGameState()
        
        set Iteration = Iteration + 1
        
        # Petite pause
        Sleep(0.016)

# Point d'entrée principal
RunPong() : void =
    InitializePong()
    GameLoop()
    Print("=== Pong Game Over ===")
