---
title: 'Building a QR-Code RSVP System for Our Wedding'
slug: qr-wedding-invites
draft: true
date: 2026-08-25
tags:
  - wedding
  - programming
  - elixir
---

I got married in 2025. I was recently telling a colleague about some of the things I made myself for the wedding, both to save money and to add a personal touch. I plan to write about a few of them here, in the hope that someone else can draw inspiration from them.

First up: our wedding invitations. Each one had a personalised silver label with a unique QR code. Scanning it signed a household into an RSVP page that already knew who they were and listed every guest in their party. A family of four, for example, saw four individual RSVP fields.

![Circular wedding-invitation label containing a QR code, wedding URL, party name and manual invite code][ll-design]

The party name in this screenshot and the `ABC123` invite code are placeholders.

## What I needed

The project had five main parts:

- an invitation design with enough space for a QR-code label
- a website that handled the invitations and RSVPs
- a unique URL for every invited party
- software that could turn a CSV file into a batch of labels
- a label printer and suitable label stock

The company producing our invitations could add a static QR code, but personalising every invitation was difficult. That led me to print and attach the labels myself.

## Building the RSVP flow

I built the site with the Elixir programming language and Phoenix web framework. [The Pragmatic Studio Phoenix course](https://pragmaticstudio.com/phoenix) walks through building a Phoenix application from end to end, but there is nothing about this approach that requires Elixir: any web framework capable of looking up an invitation and recording an RSVP would work.

Most guests would scan their label and arrive already signed in. Once they had responded, the site showed them the full wedding details, which were also printed on the invitation. If someone lost the invitation, I could send the same link over WhatsApp. Guests could also type their code into the site's home page manually.

I used a simple one-to-many relationship in the database:

```text
party (invite_code, rsvp_status) -> one or more guests (rsvp_status)
```

The party-level status told me whether the household had completed the RSVP form. The guest-level statuses recorded which individuals were attending.

Each link followed this pattern:

```text
https://cloonogrogan.wedding/rsvp/<code>
```

For example, `https://cloonogrogan.wedding/rsvp/ABC123` represented one invited party. When someone visited the URL, Phoenix looked up the code on the party record. A valid code signed them in and loaded the associated guests; an invalid code produced an error.

## Generating invite codes

I originally chose six characters, using the letters A–F and the digits 1–9. Avoiding characters such as `0` and `O` made codes easier to read and type.

There is an important security trade-off here. With 15 possible characters, a six-character code has `15⁶`, or 11,390,625, possible combinations. I felt that was an appropriate balance for a small, short-lived wedding site because the codes remained easy for guests to type. It is not strong authentication, however. Anyone who obtains the URL can act as that party, so the site should not expose especially sensitive information behind the link alone. Rate limiting would provide additional protection against automated guessing, but I did not implement it for this project.

This is the code I used to generate them:

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

I added a unique constraint on `invite_code` at the database level, with the application retrying generation if an insert collided with an existing code.

## Choosing the label software and printer

I settled on [LabelLive](https://label.live), which could import a comma-separated values (CSV) file and insert unique data into every label. It also worked with the [myDPI 300v1][] direct-thermal printer. LabelLive was free to use with that printer, and its label designer was the best fit I found for this job.

Direct-thermal printers only print in black, but compatible labels come in many colours and finishes. I chose [round two-inch silver labels][] because they suited the invitation's colour palette and left enough room for a reliably scannable QR code.

If you need colour printing, another option is to use Avery-style A4 label sheets with a colour label printer. LabelLive includes presets for them, although using the software that way requires a licence.

## Designing the label

The final design contained:

- the wedding website at the top
- a QR code in the centre
- our wedding logo on the left
- the party name on the right
- the invite code at the bottom

Printing the site address and code meant guests could bypass the QR code and sign in manually if they did not have a suitable device or were unsure how to scan it.

The party name was mainly for me. With more than 150 personalised labels to attach, I needed an obvious way to match each one to the correct invitation. Mixing up two labels would have sent the wrong guests to the wrong RSVP form.

It is important to print a sample and test it with multiple phones before producing the full batch. QR codes need a clear margin around them, often called the quiet zone, and metallic stock can introduce glare. Testing at the final size is the safest way to confirm that the code, printer resolution and label finish work together.

## Creating the labels in bulk

I added a function to the Phoenix application that exported the parties table as a CSV file:

```csv
row,party_name,invite_code,address_line_1,address_line_2,town,county,eircode,country
1,Bloggs,ABC123,1 Town Street,The Way,Athlone,Westmeath,N37 XXXX,Ireland
2,Kellys,FED457,2 Bachelor Walk,The Quays,Dublin,Dublin,D01 XXXX,Ireland
```

The values above are fictional examples. LabelLive used `invite_code` to construct the complete RSVP URL and populate the QR code; the other fields were available as placeholders in the design:

![LabelLive object list showing placeholders for the party name and invite code, plus the RSVP URL used by the QR code][ll-placeholders]

After importing the CSV, I mapped `PARTY_NAME` and `INVITE_CODE` to the corresponding text objects. The QR-code object used this value:

```text
https://cloonogrogan.wedding/rsvp/{INVITE_CODE}
```

That produced a complete batch of personalised labels ready to print. Including each party's postal address in the same export also allowed me to print address labels for the envelopes.

## Was it worth it?

This approach involved more setup than linking every invitation to one generic RSVP form, but it made the experience much more personal. Guests did not have to find their names or re-enter information I already knew, and I could track responses at both household and individual level. Batch printing from the same data used by the website also reduced repetitive work and helped me keep more than 150 invitations organised.

I also got a great deal of satisfaction from designing the whole experience. I could keep the branding consistent, work with a defined colour palette and make the invitations, labels and website feel like parts of the same design. The finished result looked professional while still being something I had created myself.

The overall cost probably came to about the same as paying someone else to produce the labels. The difference is that I now own the label printer and have the software and remaining label stock to use for other projects. They have not sat idle, either: I have since used them to make labels for Christmas presents. That continuing usefulness made the investment easier to justify, even if the wedding labels alone did not save much money.

If I built it again, I would keep both the six-character codes and the overall workflow: one party record, individual guest responses, a CSV export and labels generated from placeholders. I would retain the database uniqueness check, consider adding rate limiting, and test the printed QR code on several devices before committing to the full batch.

The result was a small detail that tied the physical invitations to a system I had built myself—which was exactly the kind of practical, personal touch I wanted for the wedding.

[myDPI 300v1]: https://mydpi.com/products/300v1
[round two-inch silver labels]: https://www.amazon.co.uk/dp/B0CXPNLGCL
[ll-design]: ll-design.jpg
[ll-placeholders]: ll-placeholders.jpg
