# GitGhost

## Purpose
This repository is designed to automate the setup of a project, including setting up a Git repository, initializing starting scripts and environments, generating requirements files, and then gently ghosting from the newly created repository.

---

## !!! IMPORTANT !!!
The nature of this repository is such that, executing the scripts is **<ins>designed to remove the repository from your local machine!</ins>**

As such, it is *vital* that you **read through the entirety of this README <ins>before</ins> executing any of the steps listed**, because if anything goes wrong, you likely will not have this guide to help, and you will need to delete everything and clone the repository again.

I have added a `build-safe.ps1` script if you want to keep this README file after everything is done, but you will then need to do your own cleanup, and it is just easier for everyone to listen to gramma:
> "Make sure you read through the whole recipe before you start cooking!" ~Your Gramma

*You have been warned...*

---

## Requirements
In order to take advantage of this repo, you will need a base set of pre-existing programs. GitGhost is written to wrap around Git and ~~aims to~~ provide support (both moral and development-wise) for a variety of other aids as well!

Here's the current list of requirements and supported auxiliaries:

#### Core (required)
- `git` - Standard, run-of-the-mill Git! Get your copy today at [git-scm.com][1]!
- `PowerShell` - All the central scripts that operate this repository run using PowerShell `.ps1` scripts (for now). You can download it from [docs.microsoft.com][2]!

#### Auxiliary (optional)
- `python` *(highly-recommended)* - Python 3 is the primary version GitGhost supports. Download link at [python.org][3]!
- `VSCode` - VSCode extensions and integrated support for many other tools makes it a good companion! Grab a copy from [code.visualstudio.com][4]!

[1]: <https://git-scm.com/downloads> "Git downloads"
[2]: <https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.2> "PowerShell installations"
[3]: <https://www.python.org/downloads/> "Python downloads"
[4]: <https://code.visualstudio.com/> "VSCode downloads"

---

## Usage
Since you have likely cloned this repo in order to use it, you will want to interact with it from a specific location.
1. Locate the directory in which you wish to build your python environment. This is where you will want to clone this repo into.
    - **[NOTE]:** If you did not clone this repo into the chosen directory, feel free to run the `reset.ps1` script which was created to simplify this process for you.
    
```
.\reset.ps1 <path_to_target_repo>
```

2. Once you are located at the target repo directory (of which the `GitGhost` repo should be a subdirectory by now), run the `build.ps1` script as follows, where `<project_module>` is the name of a supported project module:

```
.\GitGhost\build.ps1 <project_module>
```

#### Currently-supported project modules
- `pygame` - Moderately low-level Python library framework for developing video games using Python3
- `typer`  - Python command-line application library framework for developing command-line tools using Python3
- ... ***<ins>AND MORE</ins>*** (*soon...*)

---

*Developed by J Karstin Neill, 2022*
