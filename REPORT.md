Description 
------------

Eve is an app that predicts a female’s menstrual cycle. The user can input when
she had her last menstruation and/or menstruations. The app will calculate when
the user can expect her next periods and when she is ovulating. The user can
choose to receive notifications alerting the user if she should expect a
menstruation day and/or an ovulation day and therefore should practice safe sex
to prevent pregnancy. The user can adjust predicted menstruation dates if they
where incorrect. The more input from the use the smarter the calculations of the
app will become.

 

Design
------

### ViewControllers

-   InitialCalendarViewController

-   CalendarViewController

-   DetailViewController

-   SettingsViewController

 

### Views

-   InstructionView

-   CalendarCollectionView

-   NewDateCell

-   NewMonthReusableView

 

### Models

-   SavedDateManager

-   CycleNotifications

-   CalendarClass 

-   MenstruationCycleClass

 

### SubClasses

-   CycleDate

-   CalendarViewFlowLayout

 

### Swift Api Frameworks

-   UIKit Framework

-   Notification Centre Framework 

-   NSUserDefaults

-   NSCalendar

-   NSDate

-   UICollectionView

-   UICollectionViewCell

-   DateTools (Cocoapod)

 

### InitialViewController 

The initialViewController first instantiates a instructionView, a
UIVisualEffectView with a tapGestureRecogniser, as subview and displays
instructions for the user. When tapped the subview is removed and the view
displays an instance of a CalendarCollectionView with only dates. The
initialViewController instantiates a calendarClass that produces the dates for
the dateCells and sets the date type of the selected dates. When the female
symbol is pressed the segue instantiates the nextViewController and the
savedDataManager saves the selected dates.

![](https://github.com/svbeemen/Eve/blob/master/Docs/Final_InitialViewController.png)

### CalendarViewController

The CalendarViewController instantiates a CalendarClass and a
CalendarCollectionView. The instance of the CalendarClass produces the dates for
the date cells of the CalendarCollectionView. The CalendarClass instantiates a
MenstruationCycleClass, which uses the saved menstruation dates, set by the
user, to calculate the future menstruation cycles. When a date cell is tapped
the CalendarCollectionView segues to the DetailViewController and presents it
over itself. The CalendarViewController sets its instance of NewDateCell and
CalendarClass as those of the DetailViewController.

![](https://github.com/svbeemen/Eve/blob/master/Docs/Final_CalendarViewController%26SettingViewController.png)

 

### DetailViewController

The DetailViewController instantiates a NewDateCell and CalendarClass which are
equal to those of the CalendarViewController. If the date displayed in the
NewDateCell is the current day or before the NewDateCell displays a button to
add or delate a menstruation date. The DetailViewController call the
CalendarCollectionView’s changeDate function as a delegate. The
MenstruationClass in the CalendarCollectionView adjust the menstruation dates
and calculates the new menstruation cycle. The CalendarClass resets the date
types of the calendar dates and the new cycle dates. The changeDate function
returns newDateCell with the newly set type to the DetailViewController, which
adjust the image of the newDateCell to the appropriate date type.

![](https://github.com/svbeemen/Eve/blob/master/Docs/Final_InitialViewController.png)

 

### Possible Extra Functionality

-   The initial calendar view could have a button allowing the user to return to
    the instructions view.

-   The CalendarViewController could segue back the InitialViewController to
    allow a new user to use the app, without having to reinstall the app.
