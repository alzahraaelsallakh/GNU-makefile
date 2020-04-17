from progressBar import progressBar
from sys import argv 



#################################
####### Global Variables  #######
#################################

notValidMessgae = 'usage: progress.py MAXSIZE'

# Maximum number for the progress bar
maxNumber = 50

# Progress value 
progressValue = 0

# File name that holds current updated progress value
progressFileName = "progress.txt"

# Object that represents progress bar
progress = ""


def checkInput():
    global maxNumber, progress

    # Holding error status
    status = 1

    # Check if max number of percentage is passed as argument or not
    if (len(argv) == 2 ):
        maxNumber = argv[1]

        # Checking if max number is valid input
        if (maxNumber.isdigit()):
            maxNumber = int(maxNumber)

            # Updating progress object with the new max value
            progress = progressBar(maxValue = maxNumber)

        
        else:
            status = 0

    else:
        status = 0
    
    return status


def readStoredValues():
    global progressValue

    # Opening progress file
    progressFilePtr = open (progressFileName,'r')

    # Reading progress value
    progressValueTemp = progressFilePtr.readline()
    if (progressValueTemp):
        progressValue = int(progressValueTemp)
        progressFilePtr.close()


if __name__ == "__main__":
    
    if (checkInput()):
        readStoredValues()
        progress.updateAmount(progressValue)
        progress.draw()
    else:
        print(notValidMessgae)    