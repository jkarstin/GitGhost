#################################
# main.py
#-------------------------------
# J Karstin Neill    <M_DD_YYY>
#################################


### IMPORTS ###

import typer


### CONSTANTS ###


### MAIN FUNCTION DEFINITION ###

app = typer.Typer(add_completion=False)

@app.command()
def main():
    typer.echo('Hello world!')


### CORE FUNCTIONS ###




### UTILITY FUNCTIONS ###




### MAIN FUNCTION EXECUTION ###

if __name__ == '__main__':
    app()
