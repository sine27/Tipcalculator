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

The following **additional** features has bug unsolved:
* Using locale-specific currency (and currency thousands separators) displays a strange unit after changing into language other than English ("US$" when select French)

The following **additional** features are in the TODO list:
- change outlook by enable user setting (Setting controller is a table view, add cell to enable more)

### Test cases concern:
- Setting: any (input > 100 || input < 0) will remain original value without notification
- Setting: "Back" button should and will lead to no change
- Setting: empty text field will automatically set to 0

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

[![Alt text](https://i.ytimg.com/vi/7rqaIN4-Wzw/hqdefault.jpg)](https://youtu.be/7rqaIN4-Wzw)

<img src='http://i.imgur.com/8JsJInq.gif' title='tip calculation' width='270' alt='Video Walkthrough' />

<img src='http://i.imgur.com/vDNSKHP.gif' title='Setting' width='270' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

- Update value in unwindToList
- Corresponding Currency with user setting

