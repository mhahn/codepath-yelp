Yelp
=========

An app to search for restaurants and businesses nearby.

Time spent: 18 hours

### Required:
#### Search Results Page
* [x] Table rows should be dynamic height according to the content height
* [x] Custom cells should have the proper Auto Layout constraints
* [x] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).

#### Filter page
##### (Unfortunately, not all the filters are supported in the Yelp API)

* [x] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
* [x] The filters table should be organized into sections as in the mock.
* [x] You can use the default UISwitch for on/off states.
* [x] Radius filter should expand as in the real Yelp app
* [x] Categories should show a subset of the full list with a "See All" row to expand. Category list is here: http://www.yelp.com/developers/documentation/category_list
* [x] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.

### Optional:
* [ ] Infinite scroll for restaurant results.
* [ ] Implement the restaurant detail page.
* [ ] Implement map view of restaurant results

Walkthrough of all user stories:

![Video Walkthrough]()

GIF created with [LiceCap](http://www.cockos.com/licecap/).

*Notes:*

Had a really hard time with the autolayout. If there are any resources you can point me to I would love to read up on it more. I spent several hours trying to understand how to get the text to wrap properly.


## Resources Used

### Pods

* AFNetworking
* BDBOAuth1Manager
* ReactiveCocoa

### APIs

Yelp API

### Further Reading

http://www.raywenderlich.com/55384/ios-7-best-practices-part-1
http://www.yelp.com/developers/documentation/v2/search_api
