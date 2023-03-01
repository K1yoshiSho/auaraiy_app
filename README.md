# Auaraiy

Test project with BLoC, MVVM, Provider and OpenWeather API.

For the the state management Bloc was used. Each feature has 3 folders.&nbsp;
**bloc** - folder contains the event, state and bloc classes.&nbsp;
**resources** - contains repository class, which connects bloc with the api's. Repository receives the event and emits state, and can make api calls if needed&nbsp;
**features** - contains all ui related code. It may contain two folders: pages and widgets.&nbsp;
