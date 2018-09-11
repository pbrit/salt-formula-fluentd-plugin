{% from "fluentd/map.jinja" import fluentd_agent with context %}
{%- if fluentd_agent.get('enabled', False) %}

fluentd_gems_agent_amqp:
  gem.installed:
    - names: fluent-plugin-amqp
    - gem_bin: {{ fluentd_agent.gem_path }}
    - require:
      - pkg: fluentd_packages_agent
fluentd_gems_agent_elasticsearch:
  gem.installed:
    - names: fluent-plugin-elasticsearch
    - gem_bin: {{ fluentd_agent.gem_path }}
    - require:
      - pkg: fluentd_packages_agent

transmuter:
  file.managed:
    - name: {{ fluentd_agent.dir.config }}/config.d/transmuter.conf
    - source:
      - salt://fluentd/files/transmuter.conf
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
    - name: {{ fluentd_agent.dir.config }}/config.d/output-es.conf
    - source:
      - salt://fluentd/files/output-es.conf
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

input_{{ param.openstack_message_queue_node01_hostname }}_agent:
  file.managed:
    - name: {{ fluentd_agent.dir.config }}/config.d/input-{{ param.openstack_message_queue_node01_hostname }}.conf
    - source:
      - salt://fluentd/files/rabbitmq-audit.conf
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
        host: {{ param.openstack_message_queue_node01_address }}

input_{{ param.openstack_message_queue_node02_hostname }}_agent:
  file.managed:
    - name: {{ fluentd_agent.dir.config }}/config.d/input-{{ param.openstack_message_queue_node02_hostname }}.conf
    - source:
      - salt://fluentd/files/rabbitmq-audit.conf
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
        host: {{ param.openstack_message_queue_node02_address }}

input_{{ param.openstack_message_queue_node03_hostname }}_agent:
  file.managed:
    - name: {{ fluentd_agent.dir.config }}/config.d/input-{{ param.openstack_message_queue_node03_hostname }}.conf
    - source:
      - salt://fluentd/files/rabbitmq-audit.conf
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
        host: {{ param.openstack_message_queue_node03_address }}

fluentd_service_agent:
  service.running:
    - name: {{ fluentd_agent.service_name }}
    - enable: True
    {%- if grains.get('noservices') %}
    - onlyif: /bin/false
    {%- endif %}
    - watch:
      - file: fluentd_config_agent
      - file: fluentd_config_service
    - require:
      - file: fluentd_positiondb_dir

{%- endif %}
