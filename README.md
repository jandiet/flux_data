# flux_data
repository for code and workflow of the flux_data

General setup to use the R code
1.   setup git/rstudio
1.1
 -> install git from https://git-scm.com/downloads 
 -> connect your Rstudio with git:  -> tools -> global options -> git/svn
 -> make sure Version Control is enabled and that Git executable points to the folder of your git. 
 -> restart Rstudio!

1.2 
 -> open new project: -> file -> new project -> Version Control -> git -> repository url: 
     https://github.com/jandiet/flux_data.git 
-> now you have a copy of the github repository at the chosen location. all the scripts of the repository should be in the files tab in the bottom right of rstudio. 
(if you close R and want to restore the the project, just go file -> open project -> look for the project file in the repository folder)
 
2.               usage
 At the top right of RStudio a "Git"-Tab shoulb be now visible (next to Environment,History,Connections).
 When you made changes first save them then you have to commit them to the repository. 
 -> commit in the Git - Tab. -> enable the file you have changed by clicking the box
 Now you should see all the changes, lines deleted and lines added, at the bottom and you can make a last check.
 -> always leave a short but meanigful message in the box top before pressing commit, otherwise its hard to traceback changes an go to old versions again. 
 After you have successfully commited your changes to the local repository you have to push that into the main-repository on github. 
 -> push (either in the commit window, or if you have closed it or if you have edited multiple files also in the Git-Tab)

Now your changes are saved to the github repository.  

# Note: No regional branching included.
