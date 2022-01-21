#!/bin/bash

#colors for styles
RED='\033[0;31m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
GREEN='\033[0;32m'
NC='\033[0m' #No Color

# current Git branch
branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

# current project name
projectName=$(git config --local remote.origin.url|sed -n 's#.*/\([^.]*\)\.git#\1#p')

echo "on Branch: $branch"
echo "Choose from de options below"
echo "1) push a project"
echo "2) new branch"
echo "3) change branch"

read number

if [[ $number -eq 1 ]]
then
    echo "Project: ${BLUE}$projectName${NC}"
    echo "Branch: ${PURPLE}$branch${NC}"
    
    git add .
    
    echo "Enter Commit Message:"
    echo ""
    read msg
    
    if [[ -z $msg ]]
    then
        echo "${RED}commit message cannot be empty${NC}"
        echo "try again"
        
    elif [[ ! -z $msg ]]
    then
        git commit -m "$msg"
        
        echo "$msg"
        
        git push
        
        echo "${GREEN}pushed${NC}"
        
    fi
    
elif [[ $number -eq 2 ]]
then
    
    echo "git status"

    git status

    echo "Name of new Branch"

    read branch

    # create branch from current or master? (m/c)
    echo "Create $branch from current branch (c) or from Master (m)"
    
    # -p OPTION PUTS THE PROMPT IN LINE WITH THE COPY; cm BECOMES A NEW VARIABLE ($cm) STORING THE ANSWER
    read -p "current (c) / Master (m)?" cm
    # THE USER SHOULD EITHER ENTER 'c' OR 'm'; THAT VALUE WILL BE STORED IN $cm
    
    # AND NOW THE if LOGIC
    if [ $cm == 'c' ]; then
        # CHECKOUT FROM CURRENT, SO...
        git checkout -b $branch
        # ELSE IF...
        elif [ $cm == 'm' ]; then
        # CHECKOUT FROM MASTER, SO...
        git checkout master && git pull origin master && git checkout -b $branch
        # DEFINITELY SAVED A FEW KEYSTROKES THERE! NOW THE FUN PART...
    else
        # IF $cm HAS ANY VALUE OTHER THAN 'c' OR 'm'...
        cowsay "Fat fingers? Try again, Dipshit!" | lolcat
        # YOU COULD JUST echo THIS, BUT cowsay AND lolcat ARE THE BEST!
    fi
    
elif [[ $number -eq 3 ]]
then
    echo "${GREEN}branches${NC}"
    git branch -a
    echo "change branche to: "
    read branch
    git checkout $branch
    
else
    echo "select a valid number"
fi