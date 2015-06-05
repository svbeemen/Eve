### Essential Features

-   The user can set when she last had her menstruation

-   The user can alter the predicted dates concerning her cycle, up to and
    including the current date

-   Altered dates concerning the users cycle have to be taken into account for
    future predictions

-   The user can set what time to be informed that she is in her fertile period

-   The user can choose whether and when to be informed on her menstruation
    period

 

### Extra features 

-   The user can create an account

-   The app can be used in combination with other contraceptives

-   The user can be informed which days to take the pill

-   The user can be informed which days to replace a non oral form of anti
    contraceptive

-   The user can ben informed on fertile days with a humorous element such as a
    gif

 

### Classes

CycleInformation Class

NotificationsClass

 

### ViewControllers

CalendarCollectionViewController.

SettingsViewController

 

### Swift API Frameworks 

-   UIKit Framework

-   Notification Center framework 

-   EventKit Framework

-   NSCalendar

-   NSDate

-   UICollectionView

-   UICollectionViewCell

 

### CalendarCollectionView

## properties
-   Is an empty calendar, light grey days. A circle around the current date,
    indicating which day it is.

-   A layer over the calendar, disabling the calendar. Show a textfield with
    instruction.

-   When box is touched, layer disappears and calendar view is enabled.


## Initial Calendar
Is an empty calendar, light grey days. A circle around the current date, indicating which day it is.
A layer over the calendar, disabling the calendar. Show a textfield with instruction.
When box is touched, layer disappears and calendar view is enabled.

![alt text][initial calendar]

 

## Working Calendar
All date cells of the last 3 months up to and including current day date cell
are enabled. When a date is clicked the respective cell becomes bigger and goes
to the foreground. The cell displays extra information concerning that date and
a ‘+’ button. When the ‘+‘ button is clicked it displays ‘-’ and the cell
becomes red. When clicked again the ‘+’ button displays ‘-‘ and becomes grey.
When the cell is touched the new information is set to the CycleInformation
class and which then calculates the users next cycles. This information is sent
to the calendarCollectionViewController. This then displays the calendar in the
respective colours.

![alt text][working calendar]

[initial calendar]: https://github.com/svbeemen/Eve/blob/master/Docs/initialInterface.png
[working calendar]: https://github.com/svbeemen/Eve/blob/master/Docs/calendarInterface.png
