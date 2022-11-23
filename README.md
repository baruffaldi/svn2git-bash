# svn2git-bash

## SVN to GIT repository migrator

This script has been made belong my needings.

I just needed one simple bash script, easy to customize, to migrate a lot of SVN repos to new GIT repos.

It just need:

- users mapping file
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
