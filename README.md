# Setup

**In order to use this script there is some prepration that needs to be done before.**

1. The person using the Script must have Ownership of the Azure application.
2. The Excel Sheet must be of extension type .xlsx (Can easily be converted by opening the older file and Saving As one of the newer versions of the application)
3. The Excel file must be in the same folder as the script.
4. The Excel Sheet must be closed when running the script
5. You must know the name of the column the emails to be added to the application is stored in the Excel Sheet
6. You must know the name of the Application you would like to add users to (Can Easily find in the app overview on the Azure page)


### Warnings

1. The script does not check if user is in MPBSD so if you accidently add someone who is not in our practice they may have access to the app (Basically if the person exists in the Azure database they can be added no outside/non OPS users should be added)
2. I have not tested on Applications that have more than one Approle so im not sure on how that experience will go if you use the script on an application of that variety (I suspect it will fail as it will not be able to find the AppRole Id to assign the user)


## HOW TO USE

You are going to need to run this command before you can use this script: 
**Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser**
(You do no need the stars) After you have run it once you shouldnt have to run it again

1. To use this script open powershell navigate to the directory the files are stored in.
2. Type ./main.ps1 into poweshell and on the first run it will install the required modules onto your computer then immediately run the user adding script and then follow the prompts on screen
