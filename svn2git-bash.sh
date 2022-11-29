#!/bin/bash

DEFAULT_USER="Default user"
DEFAULT_EMAIL="user@example.com"

# Check if arguments has been passed
if [ $# -lt 2 ]
  then
    echo "No needed arguments supplied. Ex: ./svn2git.sh users_file svn_repo_url git_repo_url [optional:user] [optional:user_email]"
fi

# Process arguments
SVN_REPO=$2
GIT_REPO=$3
SVN_REPO_NAME=${SVN_REPO##*/}
if [ -z "$SVN_REPO_NAME" ]
  then
	SVN_REPO_NAME=${SVN_REPO%-*}
	SVN_REPO_NAME=${SVN_REPO_NAME##*/}
fi

if [ ! -z "$4" ]
  then
    GIT_REPO_USER=$4
  else
    GIT_REPO_USER=DEFAULT_USER
fi

if [ ! -z "$5" ]
  then
    GIT_REPO_EMAIL=$5
  else
    GIT_REPO_EMAIL=DEFAULT_EMAIL
fi


# Clone the repo (trunk)
git svn clone --quiet --stdlayout --no-metadata --authors-file=$1 $SVN_REPO tmp
cd tmp
git svn fetch && git svn fetch && git svn fetch && git svn fetch && git svn fetch && git svn fetch && git svn fetch
git fetch && git fetch && git fetch && git fetch && git fetch && git fetch && git fetch

# Convert ignore parameters
git config user.name $GIT_REPO_USER
git config user.email $GIT_REPO_EMAIL

git svn show-ignore > .gitignore
git add .gitignore
git commit -m 'Conversione da svn:ignore a .gitignore.'

# Clone the branch
BRANCHES=`git branch -r | grep -v "  origin/trunk"`
while read -r branch; do
	[ ! -z "$branch" ] && git checkout -f -b $branch $branch
	[ ! -z "$branch" ] && git svn fetch && git svn fetch && git svn fetch && git svn fetch && git svn fetch && git svn fetch && git svn fetch
	[ ! -z "$branch" ] && git fetch && git fetch && git fetch && git fetch && git fetch && git fetch && git fetch
done <<< $BRANCHES
while read -r branch; do
	[ ! -z "$branch" ] && git branch -d -r $branch
done <<< `git branch -r`
git switch master

# Clone the tags
for t in $(git for-each-ref --format='%(refname:short)' refs/remotes/tags); do git tag ${t/tags\//} $t && git branch -D -r $t; done

# Create new blank GIT repo
cd ..
git clone tmp $SVN_REPO_NAME
cd $SVN_REPO_NAME

while read -r branch; do
	[ ! -z "$branch" ] && git checkout -f -b ${branch##*/} origin/$branch
	[ ! -z "$branch" ] && git fetch && git fetch && git fetch && git fetch && git fetch && git fetch && git fetch
done <<< $BRANCHES
git switch master

# Change the origin and push all contents
git remote rm origin
git remote add origin $GIT_REPO
git push -u origin --all
git push -u origin --tags

# Clean stuff
cd ..
rm -rf tmp
rm -rf $SVN_REPO_NAME
