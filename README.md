# This is a CS490iOS project
<br />
## Done:
- enabled calculate different bill amount with select tip percentage
- enabled animation
- enabled increasing or decreasing divider(i.e. #people))
- enabled setting controller
- enabled default tip percentage (open the app will always use default percentage)
- enabled changable percentage value
- enabled reset the view by changing percentage to default, and setting divider starting with 1
- enabled UserDefault to store user data

### Test cases concern:
- Setting: any input > 100 || < 0 will remain original value without notification
- Setting: "Back" button should and will lead to no change
- Setting: empty text field will automatically set to 0

<br />
## Todo:
- currency problem: change language setting will lead to a strange result value with unexpected unit (localeCurrency)
- change outlook by enable user setting (Setting controller is a table view, add cell to enable more)

<br />
## Notes:
- Update in unwindToList
- This app could be used as a tax calculator
- This app could be used as a simple divider with 0% of tip rate

<br />
## Demo:

### The demo video is posted on youtube:

[![Alt text](https://i.ytimg.com/vi/7rqaIN4-Wzw/hqdefault.jpg)](https://www.youtube.com/embed/7rqaIN4-Wzw)

<iframe width="560" height="315" src="https://www.youtube.com/embed/7rqaIN4-Wzw" frameborder="0" allowfullscreen></iframe>
<br />
### tip calculation____________________setting_________________________reset divider

<img src="http://i.imgur.com/8JsJInq.gif" width="300">  <img src="http://i.imgur.com/vDNSKHP.gif" width="300"> <img src="http://i.imgur.com/diFc4kq.gif" width="300">

