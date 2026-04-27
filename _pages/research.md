---
layout: archive
title: "Research"
permalink: /research/
author_profile: true
---
{% assign cv = site.data.cv %}

<div class="vita-page">
{% include vita_papers.html title="Published Papers" papers=cv.research.published %}
{% include vita_papers.html title="Working Papers" papers=cv.research.working %}
{% include vita_papers.html title="Work In Progress" papers=cv.research.work_in_progress %}

</div>



<!-- 
{% if author.googlescholar %}
  You can also find my articles on <u><a href="{{author.googlescholar}}">my Google Scholar profile</a>.</u>
{% endif %}

{% include base_path %}

{% for post in site.publications reversed %}
  {% include archive-single.html %}
{% endfor %}
 -->