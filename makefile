include config.mk


# Creating variable to hold the names of all object files from the corresponding source files
allObjs = $(allSrcs:.c=.o)
# Creating variable to hold the names of all dependencies files from the corresponding source files
allDeps = $(allSrcs:.c=.d)

# Concatenating all files that can be generated from makefile
allFiles = $(allObjs) 
allFiles += $(allDeps)
allFiles += $(FinalTargetName)

# Calculating the number of all files that can be generated
numberOfAllGeneratedFiles := $(words $(allFiles))

# Progress bar updating stuff 
# Porgress file name that holds the value of progress
progressFile = progress.txt
# Reseting progress to zero command
cleanProgress = echo 0 > $(progressFile)

# Batch file to update the progress value in progress file
updateProgressFile = progress.bat
# Calling batch file command
updateProgress = call $(updateProgressFile)

# Drawing progress bar program interpretter
drawingInterpreter = python
# Python file that update progress bar depending on the current value in progress file
updateDrawingFile = progress.py
# Calling python file command
updateDrawing = $(drawingInterpreter) $(updateDrawingFile) $(numberOfAllGeneratedFiles)

# Setting CC flag depending on build stage
$(FinalTargetName) : CFLAG = 
$(allObjs): CFLAG = -c
$(allDeps): CFLAG = -MM

# Make main target
# Compiling all source files to get object files
# Generating dependencies
# Linking all object files to get executable file
# Updating progress value
# Updating progress drawing
$(FinalTargetName) : $(allObjs) 
	$(MAKE) $(allDeps)
	$(CC) $(CFLAG) $^ -o $@ 
	$(updateProgress)
	$(updateDrawing)


# Compiling all source file to get object files	
# Updating progress value
# Updating progress drawing
$(allObjs) : %.o : %.c 
	$(CC) $(CFLAG) $< -o $@
	$(updateProgress)
	$(updateDrawing)


# Generating all dependencies for each source file
# Updating progress value
# Updating progress drawing
# Copying all generated dependecies to their specified folder
$(allDeps) : %.d : %.c | Dependencies
	$(CC) $(CFLAG) $< -o $@
	$(updateProgress)
	$(updateDrawing)
	@copy /y $@ Dependencies\ > NUL


# Target to create directory for dependencies
Dependencies:
	@mkdir $@

# PHONY target
.PHONY: clean link onlyCompile depend all

# Clean target
# Deleting all .exe and .o and .d files
# Deleting Dependencies directory if exists
# Reseting progress value
clean: 
	DEL /Q $(FinalTargetName) $(allObjs) $(allDeps)
	IF exist Dependencies ( DEL /Q Dependencies\* && rmdir Dependencies ) 
	$(cleanProgress)

# Link target
# Linking all object files to get executable file
# Updating progress value
# Updating progress drawing
link: 
	$(CC) $(CFLAG) $(allObjs) -o $(FinalTargetName)
	$(updateProgress)
	$(updateDrawing)

# Target to only generate objects files
onlyCompile: $(allObjs)
	
# Target to only generate dependencies files
depend: $(allDeps)

# Target to generate all files
# Calling main target
# Reseting progress value
all: 
	$(MAKE) $(FinalTargetName)
	$(cleanProgress)

# Suppress command echoing by default
ifndef VERBOSE
.SILENT:
MAKEFLAGS += --no-print-directory
endif