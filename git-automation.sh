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

    read -p "current (c) / Master (m)?" cm
    
    if [ $cm == 'c' ]; then
        git checkout -b $branch
        elif [ $cm == 'm' ]; then
        git checkout master && git pull origin master && git checkout -b $branch
    else
        cowsay "Fat fingers? Try again, Dipshit!" | lolcat
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