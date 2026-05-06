---
layout: default
title: Ravens 2026 Draft Blog
---

<h1>Ravens 2026 Draft Blog</h1>

<p>Welcome. This blog covers the Baltimore Ravens' 2026 NFL Draft class — eleven players selected across three days in Pittsburgh, picked by general manager Eric DeCosta and a coaching staff led by first-year head coach Jesse Minter. Posts below break down the picks, the strategy, and what it means for the franchise heading into the 2026 season.</p>

<p>The site is deployed via a GitHub Actions pipeline as part of the BPP Level 5 DevOps module. Use the <strong>Best Pick</strong> widget on each post to vote for your favourite of the eleven 2026 selections.</p>

<hr>

<h2>Latest Posts</h2>

<ul class="post-list">
  {% for post in site.posts %}
    <li style="margin-bottom: 1.5em;">
      <h3 style="margin-bottom: 0.2em;">
        <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a>
      </h3>
      <span class="post-meta">{{ post.date | date: "%-d %B %Y" }}</span>
      <p>{{ post.excerpt | strip_html | truncatewords: 40 }}</p>
    </li>
  {% endfor %}
</ul>
