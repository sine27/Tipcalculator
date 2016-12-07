# Pre-work - Tip Calculator Application for iOS

- This app could be used as a tax calculator
- This app could be used as a simple divider with 0% of tip rate


Submitted by: Shayin Feng

Time spent: **8** hours spent in total

## User Stories

The following **required** functionality is complete:
* User can enter a bill amount, choose a tip percentage, and see the tip and total values.

The following **optional** features are implemented:
* Settings page to change the default tip percentage.
* UI animations
* Remembering the bill amount across app restarts (if < 10 mins)
* Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- Users can change the percentage value in the segment controller
- Users can increase and decrease the value of divider
- Users can reset the divider starting with 1, empty the imput, initialize the results, return to default tip rate by tapping resetting
- Users can use this app both on iPhone and iPad

The following features has bug with my solution different with the requirment:

- Using locale-specific currency (and currency thousands separators) displays a strange format after changing into some language
	- usercase: I am a Chinese living in US, but use Chinese system
	- my solution: enable setting currency in setting controller, with 4 general choices.

The following features are in the **TODO** list:

- change outlook by enable user setting (Setting controller is a table view, add cell to enable more)

### Test cases concern:
- Setting: any (input > 100 || input < 0) will remain original value without notification
- Setting: "Back" button should and will lead to no change
- Setting: empty text field will automatically set to 0

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

Click to view the **DEMO Video** on Youtube:

(https://youtu.be/kY90RGqJHgM)

<br\ >
### Demo GIF

Basic Calculation and percentage changing

<img src='http://i.imgur.com/VCNt2B6.gif' title='tip calculation' width='270' alt='Video Walkthrough' />

reseting

<img src='http://i.imgur.com/U3LKSXz.gif' title='restarting' width='270' alt='Video Walkthrough' />

##### Image not displaying: 

Restarting

http://i.imgur.com/8qbsoRN.gif

currency with locale.current

http://i.imgur.com/RfFObzW.gif

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- Update value in unwindToList
- Corresponding Currency with user setting

