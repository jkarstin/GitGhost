# GitGhost

Welcome to GitGhost! Happy to have you here! \~^-^\~


## Purpose

This repository is designed to automate the setup of a project, including setting up a Git repository, initializing starting scripts and environments, generating requirements files, and then gently ghosting from the newly created repository.


---


## Navigation: Branches & Versions

- **<ins>[Stable][1]</ins>:**       *none*
- **<ins>[Alpha][2]</ins>:**        *none*
- **<ins>[Development][3]</ins>:**  [v0.1.0-alpha][5]


[1]: <https://github.com/jkarstin/GitGhost> "Stable branch (default)"
[2]: <https://github.com/jkarstin/GitGhost/tree/alpha> "Alpha branch"
[3]: <https://github.com/jkarstin/GitGhost/tree/dev> "Development branch"
[5]: <https://github.com/jkarstin/GitGhost/milestone/1> "Alpha Build v0.1.0-alpha Milestone"


---


## !!! DON'T COUNT YOUR GHOSTLINGS BEFORE THEY CRACK !!!

The nature of this repository is such that, executing the scripts is **<ins>designed to fundamentally change in the process of a successful execution!</ins>** This means that once the tool has done what it is supposed to do, it will not be able to be easily reverted back to it's original form.

As such, it is *\*vital\** that you **<ins>read through the entirety of this README *before* executing any of the steps listed</ins>**, because if anything goes wrong, this help information will likely no longer be around, and you will need to delete everything and clone the repository again.

I have added a `crack-eggs.safe` script if you want to keep all the original repo files, but you will then need to do your own cleanup, and it is just easier for everyone to listen to Gramma Ghoulie:

> "Make sure you read through the whole recipe before you start cracking eggs! It's much easier to take the yolk from the egg than it is to put it back in." ~Gramma Ghoulie

*You have been warned... (with \*love\* of course)*


---


## Kitchen Prep!

In order to take advantage of this repo, you will need a base set of pre-existing programs. GitGhost is written to wrap around Git and ~~aims to~~ provide support (both moral and development-wise) for a variety of other aids as well!

Here's the current list of requirements and supported auxiliaries:


#### Core (required)

- `git` - Standard, run-of-the-mill Git! Get your copy today at [git-scm.com][10]!
- `PowerShell` - All the central scripts that operate this repository run using PowerShell `.ps1` scripts (for now). You can download it from [docs.microsoft.com][11]!


#### Auxiliary (optional)

- `python` *\*highly-recommended\** - Python 3 is the primary version GitGhost supports. Download link at [python.org][12]!
    + *Psssssst... future plans for this tool aim to have the core scripting done in Python 3, so definitely get python if you plan to use this for future updates ;)*
- `VSCode` - VSCode extensions and integrated support for many other tools makes it a good companion! Grab a copy from [code.visualstudio.com][13]!


[10]: <https://git-scm.com/downloads> "Git downloads"
[11]: <https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.2> "PowerShell installations"
[12]: <https://www.python.org/downloads/> "Python downloads"
[13]: <https://code.visualstudio.com/> "VSCode downloads"


---


## Usage

Since you have likely cloned this repo in order to use it, you will want to interact with it from a specific location.

1. Locate the directory in which you wish to build your python environment. This is where you will want to clone this repo into.
    - **[NOTE]:** If you did not clone this repo into the chosen directory, feel free to run the `wrong-kitchen` script which was created to simplify this process for you.

```
wrong-kitchen <path_to_correct_repo>
```

2. Once you are located at the target repo directory (of which the `GitGhost` repo should be a subdirectory by now), run the `crack-eggs` script as follows, where `<egg_name>` is the name of a supported project `egg` [See subsection **Current Egg Carton Selection**]:

```
GitGhost\crack-eggs <egg_name>
```


#### Current Egg Carton Selection

- `pygame` - Moderately low-level Python library framework for developing video games using Python3
- `typer`  - Python command-line application library framework for developing command-line tools using Python3
- ... ***<ins>AND MORE</ins>*** (*soon...*)


---


*Developed by J Karstin Neill (with help from Gramma Ghoulie), 2022*
