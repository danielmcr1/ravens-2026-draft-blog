---
layout: page
title: Ravens 2026 Draft Blog
---

Welcome. This blog covers the Baltimore Ravens' 2026 NFL Draft class — eleven players selected across three days in Pittsburgh, picked by general manager Eric DeCosta and a coaching staff led by first-year head coach Jesse Minter. Posts below break down the picks, the strategy, and what it means for the franchise heading into the 2026 season.

The site is deployed via a GitHub Actions pipeline. Use the **Best Pick** widget on each post to vote for your favourite of the eleven 2026 selections.

---

## Latest posts

{% for post in site.posts %}
### [{{ post.title }}]({{ post.url | relative_url }})

*{{ post.date | date: "%-d %B %Y" }}*

{{ post.excerpt | strip_html | truncatewords: 35 }}

{% endfor %}
