# holbertonschool.com — Passive Reconnaissance Report (Shodan)

## Objective
Gather as much passive intelligence as possible about **holbertonschool.com**, focusing on:
- IP ranges (netblocks) associated with holbertonschool.com and its subdomains
- Technologies / platforms used across subdomains

## Data Sources & Commands
Shodan (CLI):
- `shodan domain holbertonschool.com`
- `shodan search "hostname:holbertonschool.com" --fields ip_str | sort -u`

Netblock validation:
- `whois <ip> | egrep -i 'CIDR|inetnum|NetRange|route'`

---

## 1) DNS overview from Shodan Domain
Main domain records (from `shodan domain holbertonschool.com`):
- A: **75.2.70.75**, **99.83.190.102**
- MX: **Google Workspace** (aspmx.l.google.com + alt1/alt2/alt3/alt4)
- NS: AWS Route 53 (ns-*.awsdns-*.{org,co.uk,com,net})
- TXT includes:
  - SPF: `v=spf1 include:mailgun.org include:_spf.google.com -all`
  - DMARC: `_dmarc` TXT: `v=DMARC1; p=none; rua=mailto:noreply@holbertonschool.com`
  - multiple verification tokens (Google site verification, Stripe, Zapier, etc.)

Subdomain / platform indicators (CNAME/A records):
- **AWS Elastic Beanstalk**:
  - `apply` -> `hbtn-website-prod.eu-west-3.elasticbeanstalk.com`
  - `read` -> `hbtn-website-read.eu-west-3.elasticbeanstalk.com`
  - `staging-apply` -> `hbtn-website-staging.eu-west-3.elasticbeanstalk.com`
  - `beta` -> `hbtnweb-beta.us-east-1.elasticbeanstalk.com`
- **AWS CloudFront**:
  - `assets` -> `d15pj990prg69j.cloudfront.net`
  - `rails-assets` -> `d1n01hjoh1bnhi.cloudfront.net`
  - `staging-rails-assets-apply` -> `d1izqmygk6pkj0.cloudfront.net`
- **Webflow**:
  - `www`, `fr`, `webflow`, `smile2021` -> `proxy-ssl.webflow.com`
- **Weglot**:
  - `en.fr`, `fr.webflow` -> `websites.weglot.com`
- **Zendesk**:
  - `support` -> `holbertonschool.zendesk.com`
- **WordPress.com / Automattic IP space** (from A records):
  - `blog` -> **192.0.78.131**, **192.0.78.230**

---

## 2) Shodan-discovered IPs (hostname:holbertonschool.com)
From:
`shodan search "hostname:holbertonschool.com" --fields ip_str | sort -u`

Unique IPs observed:
- 13.39.187.93
- 15.237.205.60
- 35.181.94.248
- 51.44.129.162
- 51.44.96.144
- 52.47.143.83

---

## 3) IP ranges / netblocks (validated with whois)
The following netblocks were extracted using:
`whois <ip> | egrep -i 'CIDR|inetnum|NetRange|route'`

### A) 75.2.70.75
- NetRange: **75.2.0.0 - 75.2.191.255**
- CIDR: **75.2.128.0/18**, **75.2.0.0/17**
- inetnum (broad): **75.0.0.0 - 75.255.255.255**

### B) 99.83.190.102
- NetRange: **99.83.64.0 - 99.84.255.255**
- CIDR: **99.83.64.0/18**, **99.83.128.0/17**, **99.84.0.0/16**
- inetnum (broad): **99.0.0.0 - 99.255.255.255**

### C) 13.39.187.93
- NetRange: **13.24.0.0 - 13.59.255.255**
- CIDR: **13.32.0.0/12**, **13.48.0.0/13**, **13.24.0.0/13**, **13.56.0.0/14**
- inetnum (broad): **13.0.0.0 - 13.255.255.255**

### D) 52.47.143.83
- NetRange: **52.0.0.0 - 52.79.255.255**
- CIDR: **52.0.0.0/10**, **52.64.0.0/12**
- inetnum (broad): **52.0.0.0 - 52.255.255.255**

Notes:
- The netblocks above strongly indicate the domain infrastructure is largely hosted on **AWS IP space**.
- Additional IPs from Shodan search should be validated similarly (repeat whois for each IP to capture its CIDR/NetRange).

---

## 4) Technologies & frameworks (evidence-based)
Based on the DNS and Shodan domain output, the following technologies/platforms are in use:
- **AWS Route 53** (nameservers)
- **AWS Elastic Beanstalk** (multiple application environments)
- **AWS CloudFront** (static assets and rails assets distribution)
- **Webflow** (site front-end for www/fr/webflow)
- **Weglot** (translation layer for en.fr / fr.webflow)
- **Zendesk** (support portal)
- **Google Workspace** (MX records)
- **Mailgun** (SPF include)
- **WordPress.com / Automattic hosting** (blog A records)

---

## Conclusion
Holbertonschool.com shows a multi-provider web presence with a strong AWS foundation:
- Core infra and some subdomains use AWS services (Route 53, Elastic Beanstalk, CloudFront) and AWS netblocks (75/99/13/52 ranges observed).
- Front-end and localized content leverage Webflow and Weglot.
- Support is outsourced to Zendesk.
- Email is handled via Google (with Mailgun included in SPF).
