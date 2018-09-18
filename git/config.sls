{%- from "git/map.jinja" import git with context %}

include:
  - git.install

{%- if 'config' in git %}
  {%- for user, params in git.config.get('users', {}).items() %}

git_config_{{user}}_{{key}}:
  git.config_set:
    - name: {{key}}
    {%- for k, v in params.items() %}
    - {{k}}: {{v}}
    {%- endfor %}
    - require:
      - sls: git.install

  {%- endfor %}
{%- endif %}
