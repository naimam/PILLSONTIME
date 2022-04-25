<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/naimam/MOBILEAPPROJECT">
    <img src="assets/medicine.png" alt="Logo" width="100" height="100">
  </a>

<h1 align="center">Pills on Time</h1>
</div>




<!-- ABOUT THE PROJECT -->
## Decription
Our app  “Pills on Time” serves as a reminder and tracker app for medication. It is intuitive, fast, and the design philosophy provides ease-of-use. Through our app the user can look up medicines (along with the Rxcui number and any notes), add them to their profile, create alarms (one time or recurring) which send push notifications to the user reminding them to take their “Pills on Time”.

## Features

Authentication Functionality:
We have implemented Firebase Authentication in our app. This allows the user to sign in with their Google ID’s, or create a new user login ID. While signing up, users are also asked about gender and date of birth, which is used to construct their profile. 

User Profile Feature:
Users have profiles associated with them containing information like: name, email, date of birth. Once a profile is created, a user can then add medicines which they take and alarms they want to set to their profiles.

Medicines Feature:
This feature allows a user to search medicine which is linked to the DailyMed API. This is done by first searching for a medicine on the medicine screen. Then, based on your input, a list of matching entries is given to the user. It is also interesting to note that the same medicine may have two different entries for the different forms it may have (e.g. Oral Pill, Oral Liquid). We implemented this feature for accuracy. Once a user selects the correct medicine, they are given a list of different dosages obtained from the API, from which the user can correctly select their prescription. It is paramount to maintain correctness and accuracy whenever designing any application related to healthcare as it may have severe consequences. After choosing the correct dosage, the user is prompted to select the shape of the pill. This is critical because different pills have different shapes, and if the user keeps all the daily pills in a box separate from the original packaging, it helps to easily identify the correct one. Further, the user is also asked to select the color of the pill for the same reasons as above. Then, the final step is asking the user to enter notes if they want to. Examples of this can be “Don’t eat empty stomach”, etc. 

Alarm Feature Functionality: 
This is one of the core features of our app. In the alarms screen, the user is shown a list of medicine they have added to their profile. From which they can select one or multiple pills they would like to add to an alarm. After selecting the desired medicine, and clicking on create alarm, for each selected medicine the user is asked to select how many pills / drops etc. of each medicine they want to be reminded about. We made this effectively so that a user can select 2 pills and 2 drops for different medicine in the same alarm. The dosage can also not be zero, which is a failsafe that we implemented. The next page invites the user to name this alarm (e.g. Morning Pills), and also add notes along with (e.g. Eat on an empty stomach). Then the user can decide whether it is a repeating alarm or a single use. If repeating is chosen, the user can effectively set their repeat pattern by selecting a value and corresponding minutes, day, week time from the drop down menu. Then, using the time and calendar features the user can select the Start and End time for when the alarm is repeating, or the single start time if not repeating. Then pressing submit saves the alarm and it is active. The user also has the option of deleting a saved alarm. Then when an alarm is supposed to ring, it send a push notification to the user reminding them to take their medicine, along with providing any notes which they have entered.


Platform Compatibility:
Our app is working on the web platform (browsers such as Chrome, Edge etc.) and also on Mobile Emulators (e.g. Android).


## Built With

* [Flutter](https://flutter.dev/)
* [Firebase](https://firebase.google.com/)


## To Launch App

This project is a starting point for a Flutter application.

### :computer:WEB
```
flutter run -d <broswer> --web-renderer html --web-hostname localhost --web-port 5000
```

### :iphone:MOBILE(Android)
launch emulator the run:
```
flutter run -d <emulator name>
```


<!-- CONTACT -->
## Members

Thu Vo 
  
Naima Mohamed 

Aaron Reyes

Piyush Dahiya 




