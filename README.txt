Setup

In order to use this script there is some prepration that needs to be done before.

1. The person using the Script must have Ownership of the Azure application.
2. The Excel Sheet must be of extension type .xlsx (Can easily be converted by opening the older file and Saving As one of the newer versions of the application)
3. The Excel file must be in the same folder as the script.
4. The column containing the emails of the users to be added must be named exactly "user login" (As long as the file format doesnt change it should be fine)


Warnings

1. The script does not check if user is in MPBSD so if you accidently add someone who is not in our practice they may have access to the app (Basically if the person exists in the Azure database they can be added no outside/non OPS users should be added)
2. I have not tested on Applications that have more than one Approle so im not sure on how that experience will go if you use the script on an application of that variety (I suspect it will fail as it will not be able to find the AppRole Id to assign the user)
