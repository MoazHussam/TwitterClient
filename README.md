# Twitter Client

This twitter client made as a demo. The UI design is inspired by the twitter building crash course on youtube by "let's build that app".
Also, I took the approach -as in the course- of building the UI completely in code as its more robust, reusable and gives you full control, you will eventually need some manipulation in code anyway so why not doing it from the begining :)

A TTD approach was taken partially in some classes only, also test cases are not covering all scenarios of any single class, Instead, I covered the happy path only. Please note that some tests need network connection to run successfully.

A protocol-oriented programming approach was taken partially in encapsulating the mess of registering a collection view cell and dequeuing them. This method was taken from Natasha the robot in her protocol-oriented-programming lecture.

I've taken the approach of using the Twitter REST-API with manual authentication and fully encapsulated the networking process while implementing automatic authentication of all requests even if a request was made while no token is available, the Authentication manager puts the request on hold (Litraly) and retrieves an OAuth token first.

Networking responses caching is done through Core data instead of HTTP cache because HTTP cache not only unpredictable but also won't run in offline mode even if data exists on disk, so using CoreData caching could be achieved reliably. Also, an attribute was added to the TwitterUser entity called following and it indicates the users followed by that particular user, However, for simplicity as there won't be any user followed by multiple users, I've made it String instead of NSSet.

No proper error handling was made. I only covered the happy path.

There is show more button at the footer of the collection view, well, it's not implemented :)

Links for the references mentions:
- let's build that app twitter crash course (instructor only built the UI in the mentioned course): https://www.youtube.com/playlist?list=PL0dzCUj1L5JE1wErjzEyVqlvx92VN3DL5
- Natasha the robot: https://news.realm.io/news/appbuilders-natasha-muraschev-practical-protocol-oriented-programming/
