{% if pillar.fluentd_plugin.client is defined %}
include:
- fluentd.agent
- fluentd_plugin.plugin
{% endif %}
