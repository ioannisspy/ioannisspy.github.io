---
layout: archive
title: "Research"
permalink: /research/
author_profile: true
---
{% assign cv = site.data.cv %}

## Published Papers

{% include cv_papers.md papers=cv.research.published spacer=true %}

## Working papers

{% include cv_papers.md papers=cv.research.working spacer=true %}

## Work In Progress

{% include cv_papers.md papers=cv.research.work_in_progress %}



<!-- 
{% if author.googlescholar %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
 -->