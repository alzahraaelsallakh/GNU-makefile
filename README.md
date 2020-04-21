# GNU makefile

Make tool to automate the build process by defining different rules and showing progress bar/percentage

## makefile defined rules
  - **clean:** a rule to clean all generated files 
  - **onlyCompile:** a rule to only compile source files and generate object files 
  - **link:** a rule to link all object files and generate executable file 
  - **depend:** a rule to generate dependencies for each source file 
  - **all:** a rule to generate dependencies, object files and executable file 
  
## makefile main target (FinalTargetName)
  The callable target on invoking "make" generates all files by default
  
## makefile configuration
  **config.mk:** configuration file that holds the required configuration for the makefile, including:    
    - Source files  
    - Compiler command (CC)     
    - Final target name     
    
## Representing the progress of make process

  **progress.bat**: A batch script to increment the progress value stored in **progress.txt** each time the script is invoked. And creating **progress.txt** for the first time or if it doesn't exist.
  
  **progress.py**: A python script to check the progress value stored in **progress.txt** and updating the progress bar and the progress percentage using [Progress bar class](http://code.activestate.com/recipes/578228-progress-bar-class/) 
  
  The class provides methods to:  
    - Set the maximum value that corresponds to 100%  ```__init__(self, minValue = 0, maxValue = 100, totalWidth=75)```     
    - Update current amount ``` updateAmount(self, newAmount = 0)```     
    - Draw the progress bar ``` draw(self)```   
 
  The python script must be invoked by passing input argument representing the max value
  
Both batch script and python script are invoked in makefile each time it generates a file, the output of the make should be like
 <p align="center">
  <img  src="../media/makeOP.png?raw=true">
</p>

---

# Eclipse integration 
 
 ## Replacing eclipse build tool 
  1- Add the files (makefile, config.mk) to the project directory  
  2- Set the properites for the project as follow:   
  <p align="center">
  <img  src="../media/sett1.PNG?raw=true">
</p>
  <p align="center">
  <img  src="../media/sett2.PNG?raw=true">
</p>
    where "makeToolFinalProj" represents the project name<br/>
    3- Add new build target for each required rule       
</p>
  <p align="center">
  <img  src="../media/sett3.PNG?raw=true">
</p>


 ## Adding progress bar
 1- Add the files (progress.bat, progress.py, progressBar.py) to the project directory   
  Using **Grep Console** from eclipse marketplace, the settings should be as follow:   
  2- Add new expression > Progress   
   <p align="center">
  <img  src="../media/Eclipse_grep2.PNG?raw=true">
</p>
  3- Set the expression to  `\[(\S*).*\]\s(\d+%)` and set styles for the 2 groups bar and percentage
   <p align="center">
  <img  src="../media/Eclipse_grep3.PNG?raw=true">
</p>
4- The Grep view should be like 
<p align="center">
  <img  src="../media/Eclipse_grepOutput.PNG?raw=true">
</p>
