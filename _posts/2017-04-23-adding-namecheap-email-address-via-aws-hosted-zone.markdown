---
layout: post
title:  "Adding Namecheap email address via AWS hosted Zone"
date:   2017-04-23 10:00:00 +0100
categories: DevOps
---

I like smart email addresses. Since my last name starts with an 'a', I figured I'd register the nifty personal email address `anton@mlinger.com` to be like other cool developers. This is a write-up on how to reproduce this for other domains as well.

[Namecheap](https://www.namecheap.com/) is usually my goto place for domains. They got a pretty user-friendly interface as well as a nice and fast customer support. So I naturally grabbed the domain mlinger.com from there.

### Setting up a Hosted Zone

As I manage most of my domains through AWS, I decided to setup the domain in Route 53 as a hosted zone. This can be done by logging into your AWS account, going to `Route 53` > `Hosted Zones` > `Create Hosted Zone`, enter the domain that you own, any comment about the hosted zone, and leave the type as is to be able to access it from the public Internet. *[This TechGenix](http://techgenix.com/namecheap-aws-ec2-linux/) page provides a more detailed description of the way to go about this.*

You'll notice that AWS already has setup Name Server records for this hosted zone (I've always had trouble remembering what all DNS record names do, so at the end I've put a table explaining the records in this post). We'll need to copy the value of these to Namecheap, to let it know that the domain should be handled by AWS name servers. The value of the `NS` record should look something like the following, but will most likely be different for each hosted zone:
```
ns-888.awsdns-47.net.
ns-1506.awsdns-60.org.
ns-472.awsdns-59.com.
ns-1771.awsdns-29.co.uk.
```

Note these values, and head over to Namecheap. Go to `Domain List` > `mlinger.com` and have a look under `Nameservers`. Change the value to `Custom DNS`, and add the values found in AWS on individual lines.

### Managing an email inbox

To be able to send and receive emails, an email server needs to get the emails. There are a couple of alternatives to achieving this, one being hosting your own server, which I didn't go for initially for simplicity. I eventually want to handle my emails through Gmail, and given that, it seems like there are two options to go for:
* Signing up for Gsuite to register a custom domain.
* Buying Privateemail from Namecheap and handle that through Gmail.

The former option has been discouraged from, since that is more of an option for companies and not private persons, and will disable certain features from your Google apps. This being the case, I went for the latter option.

### Sending emails to Namecheap Privateemail

Privateemail can be set up through Namecheap for the domain in question, after which we need to make sure that email reaches the server by setting up records in the hosted zone pointing to the email server on Namecheap. According to [Namecheaps guide](https://www.namecheap.com/support/knowledgebase/article.aspx/1340/2176/namecheap-private-email-records-for-domains-with-thirdparty-dns), the following records need to be set up.

| Name               | Type     | Value                                      |
|:-------------------|:------------------------------------------------------|
| *Leave blank*      | `MX`     | `10 mx2.privateemail.com`                  |
| *Leave blank*      | `MX`     | `10 mx1.privateemail.com`                  |
| *Leave blank*      | `TXT`    | `v=spf1 include:spf.privateemail.com ~all` |
| mail               | `CNAME`  | `privateemail.com`                         |
| autodiscover       | `CNAME`  | `privateemail.com`                         |
| autoconfig         | `CNAME`  | `privateemail.com`                         |
| _autodiscover._tcp | `CNAME`  | `0 0 443 privateemail.com`                 |

The `MX` records will point out where the mail server is located, and the other ones should be optional, but are encouraged.

Allowing up to 1 hour for the records to take effect might be needed, before moving on to the next step

### Handle email from Gmail

Last step is to let Gmail manage the email settings. This is thoroughly explained step by step [here](https://www.namecheap.com/support/knowledgebase/article.aspx/9188/2175/google-mail-fetcher-setup-for-namecheap-private-email), but here is a quick walkthrough. In your Gmail account, and go to `Settings` > `Accounts and Import` >  `Add a mail account`. In the popup, step by step:
1. Enter your custom email address
2. Your Privateemail username/password, `mail.privateemail.com` for POP Server and use port 995
3. Tick that you want to be able to send email as well
4. Add the same custom email address
5. Use `mail.privateemail.com` as SMTP server, your username/password, port 465, and use SSL.
6. Fill in the verification code that you should have received from Gmail in the Privateemail account.

After this step, Gmail should be able to handle sending/receiving emails from a custom domain!

### DNS records and what they are used for.

This is a brief explanation of the records that are used in this post.

| Record  | Value          | What it does                                           |
|:--------|:---------------|:-------------------------------------------------------|
| `NS`    | Name Server    | The server to use to get info about hosts in this zone |
| `MX`    | Mail eXchange  | Points to the location for a server handling email     |
| `TXT`   | TeXT           | Arbitrary text record for human readable text          |
| `CNAME` | Canonical NAME | An alias for another domain name                       |
| `SRV`   | SeRVice        | Defines host/port for the specified service            |
