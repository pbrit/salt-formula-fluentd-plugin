{% from "fluentd_plugin/map.jinja" import client with context %}
{%- if client.get('enabled', False) %}

fluentd_plugin_packages_agent:
  pkg.installed:
    - names: {{ client.pkgs }}

fluentd_gems_agent_amqp:
  gem.installed:
    - name: fluent-plugin-amqp
    - gem_bin: {{ client.gem_path }}
    - require:
      - pkg: fluentd_packages_agent

fluentd_gems_agent_elasticsearch:
  gem.installed:
    - name: fluent-plugin-elasticsearch
    - gem_bin: {{ client.gem_path }}
    - require:
      - pkg: fluentd_packages_agent

transmuter:
  file.managed:
    - name: {{ client.dir.config }}/config.d/transmuter.conf
    - source:
      - salt://fluentd_plugin/files/transmuter.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: fluentd_packages_agent
      - file: fluentd_config_d_dir
    - require_in:
      - file: fluentd_config_d_dir_clean
    - watch_in:
      - service: fluentd_service_agent

output_es:
  file.managed:
    - name: {{ client.dir.config }}/config.d/output-es.conf
    - source:
      - salt://fluentd_plugin/files/output-es.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: fluentd_packages_agent
      - file: fluentd_config_d_dir
    - require_in:
      - file: fluentd_config_d_dir_clean
    - watch_in:
      - service: fluentd_service_agent

input_{{ client.rabbitmq.cluster_node01_hostname }}_agent:
  file.managed:
    - name: {{ client.dir.config }}/config.d/input-ampq-{{ client.rabbitmq.cluster_node01_hostname }}.conf
    - source:
      - salt://fluentd_plugin/files/rabbitmq-audit.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: fluentd_packages_agent
      - file: fluentd_config_d_dir
    - require_in:
      - file: fluentd_config_d_dir_clean
    - watch_in:
      - service: fluentd_service_agent
    - defaults:
        host: {{ client.rabbitmq.cluster_node01_address }}

input_{{ client.rabbitmq.cluster_node02_hostname }}_agent:
  file.managed:
    - name: {{ client.dir.config }}/config.d/input-ampq-{{ client.rabbitmq.cluster_node02_hostname }}.conf
    - source:
      - salt://fluentd_plugin/files/rabbitmq-audit.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: fluentd_packages_agent
      - file: fluentd_config_d_dir
    - require_in:
      - file: fluentd_config_d_dir_clean
    - watch_in:
      - service: fluentd_service_agent
    - defaults:
        host: {{ client.rabbitmq.cluster_node02_address }}

input_{{ client.rabbitmq.cluster_node03_hostname }}_agent:
  file.managed:
    - name: {{ client.dir.config }}/config.d/input-ampq-{{ client.rabbitmq.cluster_node03_hostname }}.conf
    - source:
      - salt://fluentd_plugin/files/rabbitmq-audit.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - require:
      - pkg: fluentd_packages_agent
      - file: fluentd_config_d_dir
    - require_in:
      - file: fluentd_config_d_dir_clean
    - watch_in:
      - service: fluentd_service_agent
    - defaults:
        host: {{ client.rabbitmq.cluster_node03_address }}

fluentd_plugin_service_agent:
  service.running:
    - name: {{ client.service_name }}
    - enable: True
    {%- if grains.get('noservices') %}
    - onlyif: /bin/false
    {%- endif %}

{%- endif %}
