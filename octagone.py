import turtle
counter = 0
while counter < 36:
    for i in range(8):
        if(i==2):
            turtle.color('Green')
        elif(i==3):
            turtle.color('red')
        elif(i==4):
            turtle.color('blue')
        turtle.forward(50)
        turtle.right(45)
    turtle.right(10)
    counter += 1

