---
date: '2016-08-19T00:00:00Z'
slug: gmail-newsletter-filter
tags:
  - automation
  - javascript
  - programming
  - code
title: Automatic Newsletter Cleanup in Gmail
---

If you haven't tried [Google Apps Script][], I found a really nifty use for it:
_smart filtering_ for email. Wait, shouldn't I just use Gmails' built-in
filters? As it turns out you can't - my filter needs to act on email that
matched that filter _in the past_. So in other words: a filter can only act on
email it actually "filters", which kinda makes sense! I'm a big fan of
automation (and email is ripe for automation), as you can see from [my post on
meetings in Outlook][Outlook].

The source is below, all you need to do is replace the mailing list identifiers
at the start (see the comments). You can find these easily enough in Gmail by
using the dropdown menu on the email and selecting "Filter mails like this":

![Selecting a newsletter mail's menu to filter](/img/16/gmail-menu-filter.png 'Selecting a newsletter mail to filter')

This will prefill the search with the mailing list id you need:

![Gmail Filter Search](/img/16/gmail-filter-search.png 'Gmail Filter Search in Action')

```javascript
function processInbox() {
  Logger.log('Starting')
  var mailingLists = [
    // replace the strings in this array with your own!
    "list:'faa8eb4ef3a111cef92c4f3d4mc list <faa8eb4ef3a111cef92c4f3d4.583821.list-id.mcsv.net>'",
    "list:'e2e180baf855ac797ef407fc7mc list <e2e180baf855ac797ef407fc7.654029.list-id.mcsv.net>'",
    "list:'9f4b80a35728f7271fe3ea6ffmc list <9f4b80a35728f7271fe3ea6ff.511493.list-id.mcsv.net>'",
  ]

  for (var i = 0; i < mailingLists.length; i++) {
    // process all threads in the Inbox
    var threads = searchMessages(mailingLists[i])

    if (threads.length > 1) {
      Logger.log(
        'Found: ' +
          threads.length +
          ' messages to process, for ' +
          mailingLists[i],
      )
      var msgToSort = getMessagesFromThreads(threads)

      msgToSort.sort(function (a, b) {
        return new Date(b.date).getTime() - new Date(a.date).getTime()
      })

      msgToSort.splice(0, 1) // Remove latest mail

      for (var i = 0; i < msgToSort.length; i++) {
        Logger.log('Moving message: ' + msgToSort[i].subject + ' to trash')
        msgToSort[i].message.moveToTrash()
      }

      Logger.log(msgToSort)
    }
  }
}

function searchMessages(filter) {
  return GmailApp.search(filter)
}

function getMessagesFromThreads(threads) {
  var msgsToSort = []
  for (var i = 0; i < threads.length; i++) {
    // get all messages in a given thread
    var messages = threads[i].getMessages()
    for (var j = 0; j < messages.length; j++) {
      msgsToSort.push(processMessage(messages[j]))
    }
  }
  return msgsToSort
}

function processMessage(message) {
  var subject = message.getSubject()
  var date = message.getDate()
  Logger.log(date + ' ' + subject)
  return {subject: subject, message: message, date: date}
}
```

Also available as an easily cloneable (with git) [Gist on Github][Gist].

[Google Apps Script]: https://developers.google.com/apps-script/
[Outlook]: /outlook
[Gist]: https://gist.github.com/dueyfinster/a66238c3f99c883ffd8d264b539dc2d8
