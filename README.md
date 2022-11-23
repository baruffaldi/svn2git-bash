# svn2git-bash

## SVN to GIT repository migrator

This script has been made belong my needings.

I just needed one simple bash script, easy to customize, to migrate a lot of SVN repos to new GIT repos.

It just need:

- users mapping file ( create it with this command: svn log -q | awk -F '|' '/^r/ {gsub(/ /, "", $2); sub(" $", "", $2); print $2" = "$2" <"$2">"}' | sort -u > users.txt )
- SVN source repository
- GIT destination repository

Optionally you can specify:

- User name
- User email

## Some usage examples


#### Without user and email:
```
./svn2git.sh /media/users.txt "file:///media/svn/projects/sound-kiosk/" "https://gitlab.example.com/internal/mobile-applications/sound-kiosk.git"
```



#### With user
```
./svn2git.sh /media/users.txt "file:///media/svn/projects/sound-kiosk/" "https://gitlab.example.com/internal/mobile-applications/sound-kiosk.git" "Filippo Baruffaldi"
```



#### With user and email
```
./svn2git.sh /media/users.txt "file:///media/svn/projects/sound-kiosk/" "https://gitlab.example.com/internal/mobile-applications/sound-kiosk.git" "Filippo Baruffaldi" "filippo.baruffaldi@example.com"
```


## Future implementations
- better arguments handling
- users.txt mapping auto create
- repos authentication
