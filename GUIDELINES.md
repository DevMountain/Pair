# Guidelines

Following the curriculum you have learned in class, the mentor and instructor team will make their recommendation to you based on the following points:

1. Follows a Master-Detail pattern for listing and editing individual entities. 
2. Considered UI to display the randomized pairs. Preferred master list displayed using a UITableView with sections.
3. Proper MVC design. Model object, model object controller, list view controller, detail view controller.
4. Model object controller with CRUD methods and randomize method. There are many ways to handle serving the randomized data. 
5. Data persistence using NSUserDefaults, Write to File, or Core Data. Bonus if using NSCoding with one of the Plist options. Bonus if the last randomized order is persisted. Huge bonus if using custom REST API.
6. Considered UX for the button to randomize the pairs again. Preferred button as UIBarButtonItem in NavigationBar, custom cell in the list view, or button in footer view. Bonus if using a custom delegate.

## Other Considerations

This is a coding challenge that would be given 60-90 minutes in a technical interview. It is not a question of _if_ you can finish it, every job would expect you to be able to finish this in a timely manner. It is a question of _how_ you approach the topic, and _how quickly_ you are able to do so.

## Potentially Helpful Class Solution Code

1. [Journal](https://github.com/DevMountain/Journal) for Master-Detail, MVC Design, and Persistence.
2. [Task](https://github.com/DevMountain/Task) for custom cells and custom delegates.
