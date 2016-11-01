# Project 3 - *Twitter-client*

**Twitter-client** is a basic twitter app to read and compose tweets from the [Twitter API](https://apps.twitter.com/).

Time spent: **12** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can sign in using OAuth login flow.
- [x] User can view last 20 tweets from their home timeline.
- [x] The current signed in user will be persisted across restarts.
- [x] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.  In other words, design the custom cell with the proper Auto Layout settings.  You will also need to augment the model classes.
- [x] User can pull to refresh.
- [x] User can compose a new tweet by tapping on a compose button.
- [x] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.

The following **optional** features are implemented:

- [x] When composing, you should have a countdown in the upper right for the tweet limit.
- [x] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [x] Retweeting and favoriting should increment the retweet and favorite count.
- [ ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [x] Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [x] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Better ways to update an array from another controller

## Video Walkthrough

Here's a walkthrough of implemented user stories:

* User can sign in using OAuth login flow.

![login](https://cloud.githubusercontent.com/assets/3449724/19876061/8c0d9ec4-9f8f-11e6-921a-1b0e0100b4ef.gif)

* User can view last 20 tweets from their home timeline.

![feed](https://cloud.githubusercontent.com/assets/3449724/19876065/9092967a-9f8f-11e6-9782-85871fc0b72b.gif)

* User can compose a new tweet by tapping on a compose button.

![compose](https://cloud.githubusercontent.com/assets/3449724/19876068/959be054-9f8f-11e6-8713-bbc47fe480c8.gif)

* User can pull to refresh.

![refresh](https://cloud.githubusercontent.com/assets/3449724/19876186/b96f5866-9f90-11e6-9f0c-879fac3a1092.gif)

* The current signed in user will be persisted across restarts and user can load more tweets.

![scroll](https://cloud.githubusercontent.com/assets/3449724/19876182/b826113e-9f90-11e6-9f50-d47ca92ad2a6.gif)

GIFs created with [LiceCap](http://www.cockos.com/licecap/).
