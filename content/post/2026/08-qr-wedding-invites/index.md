---
title: 'Custom QR Wedding Invites'
slug: qr-wedding-invites
draft: true
date: 2026-08-25
tags:
  - wedding
  - programming
  - elixir
---

Last year in 2025 I got married and I was recently telling a work colleague about the things I put in place myself both to save money and add a personal touch. I plan to write about a few of these aspects over time here - and hopefully someone else can draw inspiration from it!

OK, now on to QR codes. I knew I wanted a 'techie' element to the invites and I landed on customized indindividual QR codes that would auto login the guest, know who they are and have dropdowns for each guest in the party (ie. family of 4 would have 4 RSVP fields). Next, how do you actually make that work? First, I considered the invites, and for now I'll simplify and say you need space for the QR code to go. Then I needed to think how to produce the QR codes themselves. The company I used for the invites had the ability to only add static QR codes and any dynamic element was difficult.

Ultimately I found a company selling labelling software that was easy to use - [LabelLive](https://label.live) and that they also sell a printer - [myDPI 300v1][] which can work with it (LabelLive is free to use with their printer). I found it's label designer to be the best I could find, and it would import from a comma seperated values (CSV) file so I could feed it unique data for every QR code. Next, I needed label stock and luckily with direct thermal printers there is an abundance of choice on the likes of Amazon. I went with these [round 2in silver labels][], which seemed a nice size and would fit the colour palette of the invites. Important consideration is that thermal printer I mentioned will only print black (if you want colour, you can use Avery style A4 label sheets, and LabelLive has presets for them - but you'll have to pay for a license to use LabelLive). But, the labels themselves come in a large variety of colours and finishes.

For the website itself, I chose to use Elixir programming language and Phoenix web framework - there is a pragmatic programmers video course which takes you through building one end-to-end. You can use any framework or programming language you want, I did most of this in 2024 before LLMs got better at generating code! I'll cover more about Elixir/Phoenix later, this post is about the labels. For the website I wanted most people to scan the QR code label and RSVP, after they RSVP'd they would see all the wedding details. In case they lost or misplaced the invite, I wanted to be able to send them the link to log in directly (over WhatsApp for example) - or they could log in manually. This meant I wanted to keep the invite code (basically login code) fairly simple and user friendly. I decided on maximum of 6 characters - with numbers and a few letters (so reasonably hard to guess) - see the code here:

```elixir
defmodule Ardeo.InviteCodeGenerator do
  # Define allowed characters
  @charset Enum.concat(Enum.map(?A..?F, &<<&1>>), Enum.map(?1..?9, &<<&1>>))

  @doc """
  Generates a 6-character long invite code using letters A-F and numbers 1-9.
  """
  def generate_code(length \\ 6) do
    1..length
    # Randomly select characters
    |> Enum.map(fn _ -> Enum.random(@charset) end)
    # Combine into a string
    |> Enum.join("")
  end
end
```

OK, great, I have a way to generate invite codes, next I needed to fix a URL for each QR code to use. I settled on this convention `https://cloonogrogan.wedding/rsvp/<code>` so every QR code would just have the last 6 charachters as unique, i.e. `https://cloonogrogan.wedding/rsvp/ABC123` would be unique to an invited party of guests. I had this layout in the database:

```
party (holds invite code, rsvp_status) -> 1..* guests
```

then on a guest visiting the URL, I get the code and check it exists in a party, if not I throw an error and they are not logged in. If it does, they are logged in, and I can look up guests to get individual RSVP status. If they have already RSVP'd - they see all the details of the wedding (which was also on invite recieved). The RSVP is recorded at both party level and guest level (since I wanted to know if a party has completed RSVP'ing and then whichn of the individual guests are coming or not). If they know the code and visit the main page, they can enter the code manually if needed.

OK, so now we have:

- the label software
- the label printing machine
- a way to generate codes
- a url the QR code can use

Now, we need to finish the design of the label, and industrialise the creation. This was the design I ended up on after experimentation:

![Label Live designer][ll-design]

It has:

- QR code in the middle (generated from url: https://cloonogrogan.wedding/rsvp/`<code>`)
- Main site url at the top
- wedding logo to the left side
- Party name on right side
- Invite code at the bottom

As you can see from this invite, it's possible to bypass the QR code completely and manually enter it also. This was for quests who may not know they need to scan or didn't have an availble device to do so. The party name was for my benefit - when you are doing 150+ of these I didn't want to mix them up, so party name was shorthand for who the invite was for - so when I attached them later I could be sure they were 100% correct. Nothing worse then the incorrect RSVP for the wrong people!

Next I added a function the phoenix web app to dump a csv file from the parties tables:

```csv
row, party_name, invite_code, address_line_1, address_line_2, town, county, eircode, country
1, Bloggs, ABC123, 1 Town Street, The Way, Athlone, Westmeath, N37 XXXX, Ireland
2, Kellys, FED457, 2 Bachelor Walk, The Quays, Dublin, Dublin, D01 XXXX, Ireland
```

I can then import this in to label live and put placeholders where it'll insert values:

![Label Live placeholder values][ll-placeholders]

which then gives me a final label to print. Bonus is I also added addresses to each party so I can print the address labels for the front of the envelopes also.

[myDPI 300v1]: https://mydpi.com/products/300v1
[round 2in silver labels]: https://www.amazon.co.uk/dp/B0CXPNLGCL
[ll-design]: ll-design.jpg
[ll-placeholders]: ll-placeholders.jpg
