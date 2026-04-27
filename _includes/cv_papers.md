{% for paper in include.papers %}
- {% if paper.url %}[**{{ paper.title }}**]({{ paper.url }}){:target="_blank"}{% else %}**{{ paper.title }}**{% endif %}{% if paper.authors %} (with {{ paper.authors }}){% endif %}
{% if paper.notes %}{% for note in paper.notes %}
  - *{{ note }}*
{% endfor %}{% endif %}
{% if include.spacer %}<br />
{% endif %}
{% endfor %}