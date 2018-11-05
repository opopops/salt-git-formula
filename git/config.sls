{%- from "git/map.jinja" import git with context %}

include:
  - git.install

{%- for user, config in git.get('config', {}).items() %}
  {%- for key, params in config.items() %}

git_config_{{user}}_{{key}}:
  git.config_set:
    - name: {{key}}
    {%- for k, v in params.items() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - require:
      - sls: git.install

  {%- endfor %}
{%- endfor %}
