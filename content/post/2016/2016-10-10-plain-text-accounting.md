---
date: '2016-10-10T00:00:00Z'
slug: ledger
tags:
  - software
  - review
title: Plain Text Accounting
---

For the last few years, I've always wanted to budget properly and see where my
money was going. But like all habits that are good for you, looking after your
finances takes time, care and attention. I started off by researching the market
for budgeting software. A lot of the prepackged software out there was very
US-centric, including Quicken, Microsoft Money and
[Mint.com](https://www.mint.com). I eventually settled on and bought a license
for [You Need a Budget](https://www.ynab.com), because: it had a budgeting
methodology, very good Euro support and was cross platform with
[Adobe Air](https://en.wikipedia.org/wiki/Adobe_AIR). YNAB lasted me well for a
few years, with its pretty graphs and ease of expense entry. I even liked their
much pared-down companion iOS app at the time.

Fast forward to a few months ago, I decided I needed to get back on the
budgeting horse, so to speak. I had a look at YNAB, expecting a major new
version but instead was greeted with a cloud service. Although I love cloud
services, I don't appreciate a third party which is not my bank having my
financial information, because every major company, even ones the size of Yahoo,
get hacked eventually. I then tried an iOS application called iBank, which
retrieves your bank statements automatically by logging in to your bank on your
behalf. But this again crosses the line on security and privacy, so I was out of
luck.

That is until I found [plain text accounting](http://plaintextaccounting.org/)
and the programs [ledger](http://www.ledger-cli.org/) and
[hledger](http://hledger.org/). These two programs are command line
applications, which read a plain text file filled with your transactions, like
this:

```
2016-10-10 Two Euro Shop ; Shouldn't buy this cheap stuff again
  Expenses:Knicknacks €2
  Assets:Checking -€2
```

Each transaction is as simple as the one above and is compatible between the two
programs. There's no prefined accounts (like Expenses:Knicknacks or
Assets:Checking), you can put whatever makes sense to you and the categories
will exist. Anything prefixed with semicolon (;) is a comment, which is handy
for searching the file and the date (2016-10-10) well obviously, it's a date!
The only thing you have to make sure of is that the transaction balances, so the
€2 and -€2 have to equal 0.

So at this point it looked good, but I had four major questions:

1. How do I get data in?
2. How do I start with incomplete data?
3. How do I budget?
4. What can I use on iOS?

So getting to the first question, it's very easy thankfully, but this is where
we bring in the second program, hledger. Hledger is compatible with ledger, but
with a few nice bells and whistles on top. One of these is extra nice CSV
support, so you can download CSV files and import them. All CSV files are
different, so how do we make sure we get the right data in?
[Use rules files, which are a hledger concept](http://hledger.org/how-to-read-csv-files.html).
Stick a .rules file named the same as your .csv file:

```
$ ls
Transaction_export.csv.rules
Transaction_export.csv
```

These .rules file are fairly simple:

```
#Skip the first few lines
skip 2

#these are fields to match the csv, including skipping fields
fields date, description, , amount-in, amount-out

if
 McDonalds
 account2 Expenses:Restaurants
```

Then we can print the transactions with
`hledger -f Transaction_export.csv print` which will show us what would be
produced (like the transaction above for the €2 shop). Simply tweak the rules
file to match retailers, banks, restaurants etc you use and then append the
result to your budget file:
`hledger -f Transaction_export.csv print >> .hledger.journal`. Simply wash and
repeat every few days, once you have enough transactions.

Next, starting with incomplete data is inevitable, I'm not going to remember
every transaction before I started to pay attention! But this problem is easy to
solve, create a balancing transaction at the top of your budget file, dated
before your first transaction you started with, like so:

```
2016-10-09 * Opening Balance Current Account ; Just started budgeting!
  Assets:Checking €2
  Equity:Opening Balances -€2
```

You'll know this is successful if the balance command actually reflects your
account balance in real life: `ledger -f ~/.hledger.journal balance`.

After this, your accounts are all set up and you have your transactions, so why
all this pain again? Oh yes - budgeting! There are many ways to do this, such as
shadow accounts etc that I won't cover, please have a look on
[Plain Text Accounting](http://plaintextaccounting.org/) for some more advice on
this. I'll cover my preffered method, a set budget every month, which you can
check the balance of. At the top of my file I simply have something like this:

```
~ Monthly
  Expenses:Restaurants €15
  Expenses:Entertainment €30
  Expenses:Car Tolls  €0
```

Then we can just issue one command to see the the status of each category:
`ledger -p "this month" --budget --monthly balance ^expenses`, I have this
aliased to "budget" as a command, which shows if we are on target or have
overspent this month on any category we like.

If your on a mobile device, unless you use an
[SSH](https://en.wikipedia.org/wiki/Secure_Shell) program to a central server,
plain text accounting can be hard to use. My solution is to use the budgets
above and reflect them in the brilliant
[Pennies app](https://www.getpennies.com/). Pennies is lightweight and doesn't
want transactions really, it wants a different budget for each category you
need. This way you can see if you've gone over or under every month in any
category you want. So you don't have to enter correct data, just data with the
right amounts, which is easy to get from ledger. That way when you feel an
impulse purchase coming on, you can check Pennies and remind yourself your
budget is more important!
