# datastack
simple data stack for python and sql experiments

## Purpose
Intention here is to have a simple docker compose to have all the bits needed for loading files (csv, wotevs) via python into postgres or mssql.

The setup leverages docker for installing and running the database.  Why?  It just isolates your project and enables you to shut the whole lot down and start it back up again when you need it without any of the bits having to be installed on your desktop.  Just makes it cleaner.  

## Prerequisites

* Internet connection
* Docker
* Python (preferably Python3)


### Install and Configure Docker Desktop

**this is a one time operation**

* docker and docker compose needs to be installed.  To install docker desktop visit: https://docs.docker.com/desktop/install/mac-install/ and follow the instructions.
* you should not need a docker account to run docker desktop (I don't)
* you can configure docker to not start automatically and waste resources until you need it.
<img width="800" alt="docker desktop settings" src="https://github.com/ddagruma/datastack/assets/50228185/cebd67da-f32b-4203-9509-baf6ed0d136c">
* you can also adjust the resource limits in settings too so its not hogging your machine
<img width="800" alt="docker desktop adjust cpu and memory" src="https://github.com/ddagruma/datastack/assets/50228185/b2d56dd3-3242-4ab6-a522-206887ed1c54">


### Install Python

**this is a one time operation** but it is idempotent so its okay if you do it more than once :-) 
This is a distilled set of instruction of https://www.freecodecamp.org/news/python-version-on-mac-update/ 


1) install homebrew. homebrew is a package manager for your mac.  Open `Terminal` on your mac using spotlight (Command + Space) and type in "Terminal"
<img width="600" alt="Terminal" src="https://github.com/ddagruma/datastack/assets/50228185/cac007b4-a5ac-4b4b-b721-cefd8b90cd65">

2) enter the following command in the terminal.  It will prompt you for your root (master) password and then prompt you to hit Enter.  Just do it.
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
<img width="600" alt="Screenshot 2024-01-19 at 7 51 28 PM" src="https://github.com/ddagruma/datastack/assets/50228185/779a2e15-bf18-471e-aba8-0c48ddce342c">

3) after homebrew is installed, enter the following command
```
brew install pyenv
```

4) finally we can install Python
```
pyenv install 3.12.1
```
5) you need to add python to your PATH too...
```
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile

```
then...

```
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
```
and then finally...
```
reset
```

Test it out.  Enter python, then print("hello") then finally quit().  you should get this:
```
% python3
Python 3.12.1 (v3.12.1:2305ca5144, Dec  7 2023, 17:23:38) [Clang 13.0.0 (clang-1300.0.29.30)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> print("hello")
hello
>>> quit()
% 
```

## Starting and Stopping the database

The database admin name and passwords are stored in the `docker-compose.yaml` file.  This isn't secure but this presumes that the data is not being shared beyond your own laptop :-) 

to start the postgres database:
```
docker-compose up -d
```

to stop it:
```
docker-compose down
```

## connecting to the database using pgadmin

Open http://localhost:5050 

<paste the image here of login>

Click "add a new server"
<paste link to image>

In General:
  set Name = "docker"
In Connection:
  set host name = "postgres_db"
  port = 5432
  username = admin
  password = adminadmin

Save

## Configure your python env 


```
pip install pandas
pip install psycopg2-binary 
```


### got dramas?

- ddagruma at da gee male 
