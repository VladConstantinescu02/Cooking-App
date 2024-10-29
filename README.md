
Project proposal with gathered requirements and a high-level architecture

Project Proposal:

This application will let its user input the current state of their fridge and give them ideas for meals and link them to resources for recipes. There will also be a social game aspect where users will receive a daily recipe prompt, for example: “Cook a meal with two eggs and spinach”. The ones that wish to participate will cook the meal, add a small description of the cooking process, upload a photo of the dish and submit the entry for the challenge. Then, users that do not participate in the challenge will vote for their favorite submission and the participants will receive points depending on where they ranked. The points will then contribute to a weekly ranking.

This application would help solve a wide array of issues, including:

-Food Waste: By recommending meals that use ingredients already in users' fridges, the app helps minimize food waste.

-Cost Efficiency: The app encourages cooking at home by suggesting simple, affordable recipes, reducing the need to order food or dine out.

Tools and technologies: 

API:

-Programming language: C#
-Framework: ASP.NET CORE
-Database: Microsoft SQL or SQLite with Entity Framework ORM
-Cloud: Azure and Google

Client:

-Programming language: Dart
-Framework: Flutter

Third Party:

-Spoonacular API









Requirements Gathering:

-The user will need to log in into the app in order to use it. The authentication will be done with Google

-After the user authenticates, if they don’t have a profile, they will be prompted to create one. Here they will need to input:
	-An user name
	-An optional profile photo
	-Three dishes that they enjoy
	-They will also be able to search for their preferred dietary option (vegetarian,   dairy-free, etc.)
The user will be able to change all of these later from the profile section.

-After the user successfully creates their profile, they will be prompted to the fridge section. At the fridge section, they will be able to search any ingredient that they currently have and add it to their virtual fridge. They will also be able to add an approximate quantity. If the user adds an ingredient that they said they are allergic to or doesn’t comply with their dietary option, they will get a warning, but they won’t be forbidden from adding it.

-After the user completes their fridge, they will be able to do whatever they like

-The navigation will consist of:
	-Home page;
	-Fridge page;
	-Profile page;
	-Meals page;
	-An option to logout from you account;

-The meals page will have a list of all the meals that the user has completed. The user will also be able to search through their meals.

-If the user chooses to create a new meal, they will be prompted to the “create meal” page. Here the user will be able to input the following things:
		-Choose what ingredients from the fridge to be used
		-Input a minimum and maximum number of calories that the meal can have
		-Cuisine preferences (French, Italian, etc.)
		-Meal type (Breakfast, Lunch, Dinner, etc.)
		-The dietary options and allergies will be taken from the user profile

-After submitting the meal preferences, the app will return the user a list of possible meals and their recipes. If the user chooses a meal from here, it will be added to their “In Progress” section of the meals page. From here, they can choose to either discard it or complete it. If they complete it, the meal will be added to the “Completed” section of the meals page.


-The home page will be the place where the daily challenge takes place. Basically, every day except Monday the users will receive a prompt for a dish. If a user wishes to participate, they will have the whole day to cook the dish, take a photo of it, describe the cooking process and submit it to the challenge. Both participants and non participants will be able to see the submissions, but only non participants will be able to vote their favorites. The next day, the winner for the previous day will be announced. The participants will receive points for their ranking and each Monday a ranking will be announced for the previous week.

Wireframe:
-To further develop our understanding of this app and to have a clearer overview of the apps behavior, we developed a wireframe to exemplify the apps use:

https://www.figma.com/proto/UyFrY5vtajZPQ3PBoOREOm/IoT?node-id=132-2&t=jKx56pllzt1T1Qzv-1



