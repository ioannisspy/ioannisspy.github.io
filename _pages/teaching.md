---
layout: archive
title: "Teaching"
permalink: /teaching/
author_profile: true
---
{% assign cv = site.data.cv %}

{% for school in cv.teaching %}
## {{ school.school }}

{% if school.courses %}
**Courses**
{% for course in school.courses %}
- {{ course.name }}{% if course.evaluation %} (Student evaluation: {{ course.evaluation }}){% endif %}
{% endfor %}
{% endif %}

{% if school.awards %}
**Teaching Awards**
{% for award in school.awards %}
- *{{ award }}*
{% endfor %}
{% endif %}
{% endfor %}