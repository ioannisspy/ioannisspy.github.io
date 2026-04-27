---
layout: archive
title: ""
permalink: /cv/
author_profile: true
---
{% assign cv = site.data.cv %}

## CV
<a href="{{ cv.profile.pdf | relative_url }}" target="_blank">Link to CV (PDF)</a>

<div style="text-align: center; margin-bottom: 1em;">
  <h2 style="margin-bottom: 0.3em;">{{ cv.profile.name }}</h2>
  <a href="mailto:{{ cv.profile.email }}">{{ cv.profile.email }}</a><br>
  <a href="{{ cv.profile.website }}">{{ cv.profile.website }}</a><br>
  {{ cv.profile.address }}<br>
  {{ cv.profile.phone }}
</div>

---

## Academic Employment

{% for item in cv.employment %}
- {{ item.title }} <span style="float:right;">{{ item.dates }}</span>
{% endfor %}

---

## Education

{% for item in cv.education %}
- {{ item.degree }} <span style="float:right;">{{ item.dates }}</span>
{% endfor %}

---

## Published Research

{% include cv_papers.md papers=cv.research.published %}

---

## Working Papers

{% include cv_papers.md papers=cv.research.working %}

---

## Work In Progress

{% include cv_papers.md papers=cv.research.work_in_progress %}

---

## Teaching

{% for school in cv.teaching %}
- **{{ school.school }}**
{% if school.courses %}
  - **Courses**
{% for course in school.courses %}
    - {{ course.name }}{% if course.evaluation %} (Student evaluation: {{ course.evaluation }}){% endif %}
{% endfor %}
{% endif %}
{% if school.awards %}
  - **Teaching Awards**
{% for award in school.awards %}
    - *{{ award }}*
{% endfor %}
{% endif %}
{% endfor %}

---

## Professional Activities

**{{ cv.professional_activities.conference_heading | replace: '*', '\*' }}**

{% for conference in cv.professional_activities.conferences %}
- **{{ conference.year }}:** {{ conference.items | replace: '*', '\*' }}
{% endfor %}

**{{ cv.professional_activities.referee_heading }}:**

{{ cv.professional_activities.referees }}

---

## Scholarships, Honors, and Awards

{% for award in cv.awards %}
- {{ award.title }} <span style="float:right;">{{ award.dates }}</span>
{% endfor %}